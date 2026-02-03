---
title: Migrate /var/log to a Separate LVM Logical Volume on linux
date: 2025-11-13
categories: [linux]
tags:
  - Hands On Lab
  - Linux
  - lvm
description: Migrate /var/log to a Separate LVM Logical Volume on Linux
---


# How to Migrate `/var/log` to a Separate LVM Logical Volume on Linux

Managing log files is critical for server health. If the `/var/log` directory remains on the root partition, unchecked log growth can quickly fill up your main filesystem and bring the server to a halt.

This guide provides a step-by-step walkthrough on how to move `/var/log` to a dedicated, separate **LVM (Logical Volume Management) Logical Volume** using a new disk (in this example, /dev/xvdb).

**Prerequisites:** You must have a new, unpartitioned disk (/dev/xvdb in this guide) attached to your Linux server, and you must have `sudo` (root) privileges.

## The Environment (Reference)

For this guide, we assume the following initial state:

| Device | Size | Type | Purpose |
| :--- | :--- | :--- | :--- |
| /dev/xvda | 10G | disk | System disk (Root, /) |
| /dev/xvdb | 10G | disk | **New disk for logs** |

![output](/assets/img/Screenshot_20251114_123150.png)

## Step 1: Initialize LVM Structure on the New Disk

We will convert the new disk (/dev/xvdb) into an LVM structure.

### 1.1 Create the Physical Volume (PV)

This initializes the raw disk as an LVM Physical Volume.

```bash
sudo pvcreate /dev/xvdb
```

### 1.2 Create the Volume Group (VG)

Create a Volume Group, which acts as a container for your LVs. We'll name it `vg_log`.

```bash
sudo vgcreate vg_log /dev/xvdb
```

### 1.3 Create the Logical Volume (LV)

Create the Logical Volume for the logs, named `lv_varlog`, consuming 100% of the space in the new Volume Group.

```bash
# Create a 100% free Logical Volume named 'lv_varlog' in 'vg_log'
sudo lvcreate -l 100%FREE -n lv_varlog vg_log
```

The new device is now ready at `/dev/vg_log/lv_varlog`.

## Step 2: Format and Prepare the Logical Volume

The LV needs a filesystem before it can store data.

### 2.1 Format the Logical Volume

Format the new LV with the `ext4` filesystem.

```bash
sudo mkfs.ext4 /dev/vg_log/lv_varlog
```

### 2.2 Verify the LVM Creation

Use `lsblk` to confirm the LVM layer is visible.

```bash
lsblk
```

You should see the logical volume linked to $\mathbf{/dev/xvdb}$ (e.g., `vg_log-lv_varlog`).

## Step 3: Migrate Existing Log Data

This is the most critical stage, where you temporarily copy the data.

### 3.1 Copy the Existing Logs

Use `rsync` to copy all contents from the current `/var/log` to the new mount point, ensuring all permissions and file attributes are preserved.

  * The `-a` flag preserves permissions, ownership, and timestamps.
  * The `-x` flag ensures `rsync` does not cross filesystem boundaries (e.g., into `/var/log/journal`).


```bash
sudo mkdir -p /var/log_old
sudo rsync -ax /var/log/ /var/log_old
```

### 3.2 Switch the Mount Points
1.  **mount it permanently**
    ```bash
    sudo mount /dev/vg_varlog/lv_varlog /var/log
    ```
2. Copy you existing `/var/log_old/` data into new logical volume `lv_varlog` in `/var/log/`
    ```bash
    sudo rsync -ax /var/log_old/ /var/log
    ```


## Step 4: Make the Mount Permanent with `/etc/fstab`

To ensure the new LVM volume is mounted on every boot, you must add an entry to `/etc/fstab`.

### 4.1 Edit the fstab file

```bash
sudo nano /etc/fstab
```

### 4.2 Add the LV Entry

Add the following line to the end of the file. Using the LVM device path is reliable for Logical Volumes.

```fstab
/dev/vg_log/lv_varlog /var/log ext4 defaults 0 2
```

### 4.3 Verify the fstab Entry

Test the new entry without rebooting:

```bash
sudo mount -a
df -h /var/log
```

The output should confirm the volume is mounted:

```
Filesystem                      Size Used Avail Use% Mounted on
/dev/mapper/vg_log-lv_varlog  9.8G 660M  8.6G  7% /var/log
```

## Step 5: Final Verification and Cleanup

The migration is complete\! Now you just need a final check and cleanup.

### 5.1 Final System Check

Confirm the mount point is active and logs are being written: Check real-time log activity

```bash
lsblk

sudo tail -f /var/log/syslog
```

### 5.2 Clean Up (Reclaim Space)

Once you are satisfied that the system is running correctly and logs are being written to the new volume, you can safely remove the old backup directory (`/var/log_old`) to free up space on your root partition.

```bash
# *** ONLY run this command when you are 100% sure the new setup is working ***
sudo rm -rf /var/log_old
```



##  Verify the Mount Point and Size

The most important step is confirming the logical volume is correctly attached to the directory.

| Command | Purpose | Expected Output Snippet |
| :--- | :--- | :--- |
| `df -h /var/log` | Shows the disk space usage and confirms the device mapped to the directory. | `/dev/mapper/vg_log-lv_varlog 9.8G 660M 8.6G 7% /var/log` |
| `lsblk /dev/xvdb` | Shows the block device and its mount point. | `└─vg_log-lv_varlog 252:0 0 10G 0 lvm /var/log` |
| `mountpoint /var/log` | Confirms that `/var/log` is, in fact, a separate mount point. | `/var/log is a mountpoint` |

-----

You have successfully migrated your `/var/log` directory to a dedicated LVM Logical Volume, protecting your root partition from log file overflow\!