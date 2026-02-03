---
title: Guide to NFS on Linux
date: 2025-09-29
categories: [linux]
tags:
  - Hands On Lab
  - Linux
  - NFS
description: Step-by-step guide to NFS in Linux, from basic to advanced concepts, with practical examples and command explanations for each stage.
---


![output](/assets/img/Screenshot_20251007_053150.png)

***

### What is NFS?

NFS (Network File System) allows Linux systems to share directories and files with others over a network. It is commonly used for centralizing storage and making files accessible to multiple machines.

***

### NFS Architecture

- **NFS Server**: The machine that shares its directories.
- **NFS Client**: The machine that mounts and accesses the shared directories.

***

### Prerequisites

- Two Linux machines on the same network.

***

## Setting Up NFS: Step-by-Step

### 1. Install NFS Packages

**On Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install nfs-kernel-server nfs-common
```

**On CentOS/Fedora/RHEL:**
```bash
sudo yum install nfs-utils
```
- `nfs-kernel-server`: Provides the NFS server functionality.
- `nfs-common`/`nfs-utils`: Provides client utilities.

***

### 2. Create a Directory to Share

```bash
sudo mkdir -p /srv/nfs/shared
sudo chown nobody:nogroup /srv/nfs/shared
sudo chmod 777 /srv/nfs/shared
```
- `chown` and `chmod`: Set permissions so all clients can access it.

***

### 3. Configure NFS Exports

Edit the exports file:
```bash
sudo nano /etc/exports
```
Add a line like:
```
/srv/nfs/shared 192.168.1.0/24(rw,sync,no_subtree_check)
```
- `rw`: Read/write access.
- `sync`: Writes changes to disk before replying.
- `no_subtree_check`: Disables subtree checking for better performance.
- Replace `192.168.1.0/24` with your network | subnet.

***

### 4. Export the Shared Directory

```bash
sudo exportfs -ra
```
- `-ra`: Re-exports all directories listed in `/etc/exports`.

***

### 5. Start and Enable NFS Server

```bash
sudo systemctl enable --now nfs-server
```
- Starts the NFS server and enables it at boot.

***

### 6. Adjust Firewall (if enabled)

**On Ubuntu:**
```bash
sudo ufw allow from 192.168.1.0/24 to any port nfs
```

- `192.168.1.0` replace with your own ip/subnet ip 

**On CentOS/Fedora:**
```bash
sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --reload
```
- Allows NFS traffic through the firewall.

***

### 7. Check NFS Exports

```bash
showmount -e
```
- Lists exported directories on the server.

***

## NFS Client Configuration

### 1. Install NFS Client Utilities

**On Ubuntu/Debian:**
```bash
sudo apt install nfs-common
```

**On CentOS/Fedora/RHEL:**
```bash
sudo yum install nfs-utils
```
- Installs the client-side tools.

***

### 2. Mount the NFS Share

```bash
sudo mkdir -p /mnt/nfs-client
sudo mount -t nfs 192.168.1.100:/srv/nfs/shared /mnt/nfs-client
```
- Replace `192.168.1.100` with the server's IP address.
- `/mnt/nfs-client` is the local mount point.

***

### 3. Make the Mount Permanent

Edit `/etc/fstab`:
```bash
sudo nano /etc/fstab
```
Add:
```
192.168.1.100:/srv/nfs/shared /mnt/nfs-client nfs defaults 0 0
```
- Ensures the share mounts at boot.

***

### 4. Unmount the NFS Share

```bash
sudo umount /mnt/nfs-client
```
- Unmounts the share from the client.[10]

***


### Export Options

- `ro`: Read-only access.
- `no_root_squash`: Allows root on client to act as root on server (use with caution).
- `all_squash`: Maps all client users to anonymous user.
- `anonuid`/`anongid`: Set UID/GID for anonymous users.

### NFS Versions

- NFSv3: Widely supported, stateless.
- NFSv4: Improved security, stateful, supports ACLs and pseudo-root.

### Security Best Practices

- Restrict access to trusted IPs.
- Use firewalls to limit NFS ports.
- Prefer NFSv4 for better security features.

***

## Troubleshooting

- **Check NFS status:** `sudo systemctl status nfs-server`
- **View logs:** `journalctl -xe | grep nfs`
- **Test connectivity:** `showmount -e 192.168.1.100`
- **Remount all:** `sudo mount -a`
- **Check permissions:** Ensure directory and export permissions are correct.

***

## Example: Full Workflow

**On Server:**
```bash
sudo apt install nfs-kernel-server
sudo mkdir -p /srv/nfs/shared
sudo chown nobody:nogroup /srv/nfs/shared
sudo chmod 777 /srv/nfs/shared
echo "/srv/nfs/shared 192.168.1.0/24(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
sudo exportfs -ra
sudo systemctl enable --now nfs-server
```

**On Client:**
```bash
sudo apt install nfs-common
sudo mkdir -p /mnt/nfs-client
sudo mount -t nfs 192.168.1.100:/srv/nfs/shared /mnt/nfs-client
```
- Now, files placed in `/srv/nfs/shared` on the server will appear in `/mnt/nfs-client` on the client.

***

# Thank You
