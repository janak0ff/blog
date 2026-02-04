---
title: Step to install VMware Workstation on a Linux system.
date: 2025-09-22
categories: [linux]
tags:
  - VMware
description: Step to install VMware Workstation on a Linux system.
---


**Step by step** to install **VMware Workstation** on a Linux system like Debian/Ubuntu.

---

###  Download VMware Workstation Bundle File (Need broadcom.com account)

1. Go to the official VMware download page: [VMware Workstation Pro](https://support.broadcom.com/group/ecx/free-downloads)

2. Choose required option for your system and download the `.bundle` file.

   * Example: `VMware-Workstation-Full-17.6.4-24832109.x86_64.bundle`

3. Save it in `/Downloads`.

![output](/assets/img/Screenshot_20250922_033943.png)

---

### Prepare the System

Open a terminal and run:

```bash
sudo apt update
sudo apt install build-essential linux-headers-$(uname -r) -y
```

* `build-essential`: needed to compile kernel modules.
* `linux-headers`: required for VMware kernel modules.

---

###  Make the Bundle Executable

Navigate to the folder where you downloaded the bundle and run:

```bash
cd ~/Downloads
chmod +x VMware-Workstation-Full-17.6.4-24832109.x86_64.bundle
```

---

### Run the Installer

Run the installer with:

```bash
sudo ./VMware-Workstation-Full-17.6.4-24832109.x86_64.bundle
```

![output](/assets/img/Screenshot_20250922_033153.png)


---

###  Launch VMware Workstation

After installation, launch VMware:

![output](/assets/img/Screenshot_20250922_034250.png)


---

# Thank Your