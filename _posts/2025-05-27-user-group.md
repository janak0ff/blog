---
layout: post
title: "user & group modification"
date: 2025-05-27 17:27 +0545
categories: ["bash"]
tags: ["cli"]
author: sudiplun
excerpt: manages and modification user and groups in linux
---

### User Monitoring

```bash
who    # Show Logged-in users
whoami # Display the current user
id # Show current user ID (UID) and group ID (GID)
users # List currently logged-in users
w # Show detailed info about logged-in users
last # Display login history
```

---

### Creating & Managing Users

```bash
adduser username # Create a new user (Debian-based systems)
usermod -l newname oldname # Rename a user account
usermod -d /new/home username # Change a user's home directory
usermod -aG `sudo` username # Add a user to the sudo (admin) group
userdel -r username # Delete a user and remove their home directory
useradd -m username # Create a new user and create a home directory
passwd username # Set or change a user's password
chage -l username # Show password expiration info for a user
chage -E 2029-6-30 # Set account expiration date for a user
deluser username # Delete a user (Debian-based systems)
```

---

### Group Management

```bash
groupadd groupname # Create a new group
groupdel groupname # Delete a group
gpasswd -a username groupname # Add a user to a group
gpasswd -d username groupname # Remove a user from a group
groups username # Show groups a user belongs to
id username # Display user's UID, GID, and groups
newgrp groupname # Switch to a different group
groupmod -n new_name current_name #change the name of existing group name
```

---

### Managing User Permissions & Ownership

```bash
chmod 755 filename # Set file permissions (Owner: rwx, Group: r-x, Others: r-x)
chmod -R 700 /secure-dir # Recursively change permissions to private (Owner: rwx, Others: none)
chown -R user:group /dir # Change ownership of a file
chown user:group file # Recursively change ownership of a directory
chgrp groupname file # Change group ownership of a file
```

---

### Managing Sudo Privileges

```bash
visudo # Edit sudoers file safely
echo "username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers sudo -1 # Allow user to run all commands without a password
sudo -l username command  # List sudo permissions for the current user
sudo -u username command # Run a command as another user
sudo su # Switch to root user
```

---

### Locking & Unlocking User Accounts

```bash
passwd -l username  # Lock a user account
passwd -u username # Unlock a user account
usermod -L username # Another way to lock a user account
usermod -U username # Another way to unlock a user account
chage -E 0 username # Expire a user's account immediately
```

### Switching & Managing Sessions

```bash
Su - username # Switch to another user (requires password)
sudo -i # Open a root shell
sudo -u username - S # Start a shell as another user
who -U # Show logged-in users with session duration
pkill -U Username # Kill all processes of a specific user
```
