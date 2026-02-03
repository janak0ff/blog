---
title: 🐧💻 Linux Directories & Config Files Demystified - What Every DevOps Should Know
date: 2025-05-23
categories: [linux]
tags:
  - Theory
  - Linux
description: Ever wondered what all those directories and config files in Linux actually do? This comprehensive guide breaks down the Linux filesystem hierarchy, explaining every important directory, subdirectory, and configuration file—along with their purposes and functions. Whether you're a Linux newbie or a seasoned sysadmin, this post will help you master the Linux filesystem! 
---


# 📂 Linux Directory Structure and Important Configuration Files

## Linux Directory Structure (Filesystem Hierarchy Standard)

### Root Directory (`/`)
The base of the filesystem hierarchy. All other directories and files are contained within it.

### Essential System Directories

1. **/bin** - Essential command binaries
   - Contains fundamental user command binaries (like `ls`, `cp`, `mv`, `rm`, etc.)
   - Needed for single-user mode and system repair

2. **/sbin** - System binaries
   - Contains binaries for system administration (like `fdisk`, `fsck`, `ifconfig`, etc.)
   - Typically requires root privileges

3. **/boot** - Boot loader files
   - Contains files needed to boot the system (kernel, initramfs, GRUB files)
   - Important files:
     - `vmlinuz` - The Linux kernel
     - `initrd.img` - Initial RAM disk
     - `grub/` - GRUB bootloader configuration

4. **/dev** - Device files
   - Contains special device files that represent hardware components
   - Examples: `/dev/sda` (first hard disk), `/dev/tty` (terminals), `/dev/null` (null device)

5. **/etc** - System configuration files
   - Contains host-specific system-wide configuration files
   - Most important configuration directory (covered in detail below)

6. **/home** - User home directories
   - Contains personal directories for each user
   - Each user has their own subdirectory (e.g., `/home/username`)

7. **/lib** - Essential shared libraries
   - Contains libraries needed by binaries in `/bin` and `/sbin`
   - `/lib32` and `/lib64` for 32-bit and 64-bit libraries respectively

8. **/media** - Removable media mount points
   - Automatic mount points for removable devices (USB drives, CDs, etc.)

9. **/mnt** - Temporary mount points
   - Traditionally used for temporarily mounting filesystems

10. **/opt** - Optional application software
    - Contains add-on applications from third parties

11. **/proc** - Process and kernel information
    - Virtual filesystem providing process and system information
    - Important files:
      - `/proc/cpuinfo` - CPU information
      - `/proc/meminfo` - Memory information
      - `/proc/mounts` - Mounted filesystems

12. **/root** - Root user's home directory
    - Home directory for the root user (not in `/home` for recovery purposes)

13. **/run** - Runtime variable data
    - Contains system information since last boot (process IDs, lock files, etc.)

14. **/srv** - Service data
    - Contains data for services provided by the system (web, FTP, etc.)

15. **/tmp** - Temporary files
    - Stores temporary files that may be deleted between reboots

16. **/usr** - User utilities and applications
    - Secondary hierarchy containing most user utilities and applications
    - Important subdirectories:
      - `/usr/bin` - Non-essential command binaries
      - `/usr/sbin` - Non-essential system binaries
      - `/usr/lib` - Libraries for binaries in `/usr/bin` and `/usr/sbin`
      - `/usr/local` - Locally installed software
      - `/usr/share` - Architecture-independent data

17. **/var** - Variable data files
    - Contains files that change frequently (logs, spool files, caches)
    - Important subdirectories:
      - `/var/log` - System log files
      - `/var/cache` - Application cache data
      - `/var/spool` - Queued files (print jobs, mail, etc.)
      - `/var/www` - Default web server root (on some distributions)

## Important Configuration Files

### System Configuration Files (/etc)

1. **/etc/passwd** - User account information
   - Contains user account details (username, UID, GID, home directory, shell)
   - Format: `username:x:UID:GID:comment:home_dir:shell`

2. **/etc/shadow** - Secure user account information
   - Contains encrypted passwords and password aging information
   - Only readable by root

3. **/etc/group** - Group information
   - Defines system groups and their members

4. **/etc/fstab** - Filesystem table
   - Defines how disk partitions and other storage should be mounted
   - Used during system boot to mount filesystems

5. **/etc/hosts** - Static hostname resolution
   - Maps hostnames to IP addresses before DNS
   - Can override DNS lookups

6. **/etc/resolv.conf** - DNS resolver configuration
   - Configures DNS nameservers and search domains
   - Often managed dynamically by network services

7. **/etc/hostname** or **/etc/hostname** - System hostname
   - Contains the system's hostname

8. **/etc/network/interfaces** or **/etc/sysconfig/network-scripts/** - Network configuration
   - Configures network interfaces (Debian/Ubuntu vs RHEL/CentOS)

9. **/etc/ssh/sshd_config** - SSH server configuration
   - Configures the OpenSSH server daemon
   - Controls authentication methods, ports, etc.

10. **/etc/sudoers** - Sudo configuration
    - Defines who can run what commands as root via sudo
    - Should always be edited with `visudo`

11. **/etc/crontab** - System-wide cron jobs
    - Defines scheduled tasks run by the system
    - User-specific crontabs are in `/var/spool/cron/`

12. **/etc/apt/sources.list** (Debian/Ubuntu) or **/etc/yum.repos.d/** (RHEL/CentOS) - Package repositories
    - Defines software repositories for package management

13. **/etc/ld.so.conf** - Shared library configuration
    - Lists directories to be included in the library search path

14. **/etc/sysctl.conf** - Kernel parameters
    - Configures kernel parameters at boot time

15. **/etc/modprobe.d/** - Kernel module configuration
    - Configuration files for kernel modules

16. **/etc/security/limits.conf** - User process limits
    - Sets resource limits (number of processes, file handles, etc.)

17. **/etc/default/grub** - GRUB bootloader configuration
    - Main configuration file for GRUB bootloader
    - Changes require running `update-grub` (Debian) or `grub2-mkconfig` (RHEL)

### Service-Specific Configuration Files

1. **/etc/nginx/** - Nginx web server configuration
   - `nginx.conf` - Main configuration file
   - `sites-available/` - Available website configurations
   - `sites-enabled/` - Enabled website configurations

2. **/etc/apache2/** (Debian) or **/etc/httpd/** (RHEL) - Apache web server configuration
   - `apache2.conf`/`httpd.conf` - Main configuration file
   - `sites-available/` and `sites-enabled/` (Debian)
   - `conf.d/` - Additional configuration files

3. **/etc/mysql/** - MySQL configuration
   - `my.cnf` - Main MySQL configuration file

4. **/etc/postgresql/** - PostgreSQL configuration
   - Contains configuration for PostgreSQL database server

5. **/etc/php/** - PHP configuration
   - Contains PHP configuration files for different versions

### Log Files (/var/log)

1. **/var/log/syslog** or **/var/log/messages** - General system messages
   - Primary system log file (name varies by distribution)

2. **/var/log/auth.log** - Authentication logs
   - Records authentication events (logins, sudo usage, etc.)

3. **/var/log/kern.log** - Kernel logs
   - Kernel-specific messages and errors

4. **/var/log/dmesg** - Kernel ring buffer
   - Contains messages from the kernel during boot

5. **/var/log/apt/** or **/var/log/yum.log** - Package manager logs
   - Records package installation and updates

6. **/var/log/nginx/** or **/var/log/apache2/** - Web server logs
   - Contains access and error logs for web servers

7. **/var/log/mysql/** - MySQL logs
   - Contains error logs and slow query logs for MySQL

### User Configuration Files (in home directories)

1. **~/.bashrc** - Bash shell configuration
   - Executed for interactive non-login shells
   - Contains aliases, functions, and shell options

2. **~/.bash_profile** or **~/.profile** - Login shell configuration
   - Executed for login shells
   - Typically sets environment variables and paths

3. **~/.ssh/** - SSH client configuration
   - `config` - SSH client configuration
   - `known_hosts` - Known SSH hosts
   - `authorized_keys` - Keys allowed for authentication

4. **~/.gitconfig** - Git configuration
   - User-specific Git settings

5. **~/.vimrc** - Vim configuration
   - Configuration for the Vim text editor

6. **~/.config/** - Application configuration
   - Modern location for user-specific application configurations

## Special Files

1. **/etc/motd** - Message of the day
   - Displayed after successful login

2. **/etc/issue** - Pre-login message
   - Displayed before the login prompt

3. **/etc/os-release** - OS identification
   - Contains operating system identification data

