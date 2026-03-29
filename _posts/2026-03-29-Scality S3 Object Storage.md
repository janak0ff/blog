---
title: Scality S3 Object Storage    
date: 2025-03-29
categories: [scality]
tags:
  - Scality S3
  - Object Storage
description: Learn how to install AWS CLI and Rclone, configure profiles, and perform all CRUD operations on Scality S3 object storage from the command line.
---

# Getting Started with Scality S3 Object Storage: A Complete Beginner's Guide

*Learn how to install AWS CLI and Rclone, configure profiles, and perform all CRUD operations on Scality S3 object storage from the command line.*

---

## Table of Contents
0. [Types of Storage: Block, File, and Object](#types-of-storage)
1. [What is Scality S3?](#what-is-scality)
2. [Install AWS CLI](#install-aws-cli)
3. [Install Rclone](#install-rclone)
4. [Configure AWS CLI for Scality](#configure-aws-cli)
5. [Configure Rclone for Scality](#configure-rclone)
6. [Bucket Operations](#bucket-operations)
7. [File Operations (CRUD)](#file-operations)
8. [Sync & Transfer](#sync-and-transfer)
9. [Pre-signed URLs](#presigned-urls)
10. [Quick Reference Cheatsheet](#cheatsheet)

---

## Types of Storage: Block, File, and Object {#types-of-storage}


### Block Storage

Stores data as **fixed-size blocks** — like a raw hard drive. Each block has a unique address and no concept of files or folders. The OS puts a filesystem on top to make it usable.

**Examples:** AWS EBS, SAN, VMware VMDK, your computer's SSD
**Best for:** Databases, virtual machine disks, OS boot drives

---

### File Storage

Organizes data in a **familiar folder/file hierarchy** — exactly like your desktop. You navigate using paths like `/home/user/documents/report.pdf`.

**Examples:** NFS, Samba, Windows File Share, NAS
**Best for:** Shared network drives, home directories, office file sharing

---

### Object Storage

Stores data as **flat, self-contained objects** in a bucket. Every object has three things:

- **Data** — the actual file content
- **Metadata** — information about the object (size, purpose, custom tags)
- **Object Key** — the unique identifier for that object

> Unlike block storage where you update a piece of a file, in object storage the **entire file object is replaced** on every update.

**Examples:** Amazon S3, Scality S3, MinIO, Cloudflare R2
**Best for:** Backups, images, videos, logs, static websites, large-scale archiving

---

### Quick Comparison

| Feature | Block | File | Object |
|---|---|---|---|
| Structure | Raw blocks | Folders & files | Flat buckets |
| Access | Block address | File path | HTTP API / Key |
| Speed | Very fast | Medium | Medium |
| Scalability | Limited | Limited | Unlimited |
| Cost | High | Medium | Low |
| Update method | Partial update | Partial update | Full object replace |
| Best for | Databases, VMs | File sharing | Cloud storage, backups |

---

## 1. What is Scality S3? {#what-is-scality}

Scality is an **enterprise-grade object storage** solution that is fully compatible with Amazon S3 API. This means you can use the same AWS CLI tools and SDKs you already know, just pointed at a different endpoint.

Think of it like this:
- **Amazon S3** → AWS cloud storage
- **Scality S3** → Your own on-premise or private cloud storage, same API

Common use cases:
- Storing backups
- Hosting static websites
- Storing application assets (images, videos, documents)
- Archiving large datasets

---

## 2. Install AWS CLI {#install-aws-cli}

[Installing or updating to the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
---

## 3. Install Rclone {#install-rclone}

Rclone is a powerful command-line tool for managing files on cloud storage. It supports S3-compatible storage like Scality.

[Install Rclone](https://rclone.org/)

---

## 4. Configure AWS CLI for Scality {#configure-aws-cli}

### Method 1: Default Profile (Single Storage, No --profile needed)

Use this if Scality is your **only** S3 storage.

```bash
aws configure
```

Enter when prompted:
```
AWS Access Key ID: YOUR_ACCESS_KEY
AWS Secret Access Key: YOUR_SECRET_KEY
Default region name: us-east-1
Default output format: json
```

Then set the endpoint permanently:
```bash
aws configure set endpoint_url https://s3-example.com
```

Your config files will look like:

**~/.aws/credentials**
```ini
[default]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
```

**~/.aws/config**
```ini
[default]
region = us-east-1
endpoint_url = https://s3-example.com
```

Now use AWS CLI without any extra flags:
```bash
aws s3 ls
aws s3 mb s3://my-bucket
```

---

### Method 2: Named Profile (Multiple Storage Providers)

Use this if you also use **real AWS S3** alongside Scality.

```bash
aws configure --profile scality
```

Enter when prompted:
```
AWS Access Key ID: YOUR_ACCESS_KEY
AWS Secret Access Key: YOUR_SECRET_KEY
Default region name: us-east-1
Default output format: json
```

Set endpoint for this profile:
```bash
aws configure set endpoint_url https://s3-example.com --profile scality
```

Your config files will look like:

**~/.aws/credentials**
```ini
[default]
aws_access_key_id = AWS_ACCESS_KEY
aws_secret_access_key = AWS_SECRET_KEY

[scality]
aws_access_key_id = SCALITY_ACCESS_KEY
aws_secret_access_key = SCALITY_SECRET_KEY
```

**~/.aws/config**
```ini
[default]
region = us-east-1

[profile scality]
region = us-east-1
endpoint_url = https://s3-example.com
```

Use with `--profile scality`:
```bash
aws s3 ls --profile scality
aws s3 mb s3://my-bucket --profile scality
```

Or set as default for your session:
```bash
export AWS_PROFILE=scality
```

To make it permanent:
```bash
echo 'export AWS_PROFILE=scality' >> ~/.bashrc
source ~/.bashrc
```

---

### Verify Your Configuration

```bash
aws configure list
# or for named profile
aws configure list --profile scality
```

Expected output:
```
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                   scality           manual    --profile
access_key     ****************NM3D      shared-credentials-file
secret_key     ****************gLu       shared-credentials-file
    region                 us-east-1      config-file    ~/.aws/config
```

---

## 5. Configure Rclone for Scality {#configure-rclone}

```bash
rclone config
```

Follow the interactive prompts:

```
n) New remote
> n

name> scality

Storage> s3
(type 5 or search for s3)

provider> Other
(type for Other/S3 compatible)

env_auth> false
(press Enter)

access_key_id> YOUR_ACCESS_KEY

secret_access_key> YOUR_SECRET_KEY

region>
(press Enter - leave blank)

endpoint> https://s3-example.com

location_constraint>
(press Enter - leave blank)

acl>
(press Enter - leave blank)

Edit advanced config? > n

y) Yes this is OK
> y
```

Verify the config file:
```bash
cat ~/.config/rclone/rclone.conf
```

Should show:
```ini
[scality]
type = s3
provider = Other
access_key_id = YOUR_ACCESS_KEY
secret_access_key = YOUR_SECRET_KEY
endpoint = https://s3-example.com
```

Test the connection:
```bash
rclone lsd scality:
```

---

## 6. Bucket Operations {#bucket-operations}

### Create a Bucket

```bash
# AWS CLI
aws s3 mb s3://my-bucket

# Rclone
rclone mkdir scality:my-bucket
```

### List All Buckets

```bash
# AWS CLI
aws s3 ls

# Rclone
rclone lsd scality:
```

### Rename a Bucket

> ⚠️ S3 does not support direct bucket renaming. The workaround is to sync to a new bucket then delete the old one.

```bash
# Step 1: Create new bucket
aws s3 mb s3://new-bucket-name

# Step 2: Sync all contents
aws s3 sync s3://old-bucket-name s3://new-bucket-name

# Step 3: Verify contents
aws s3 ls s3://new-bucket-name --recursive

# Step 4: Delete old bucket
aws s3 rb s3://old-bucket-name --force
```

### Delete a Bucket

```bash
# Delete empty bucket
aws s3 rb s3://my-bucket

# Delete bucket with all contents (force)
aws s3 rb s3://my-bucket --force

# Rclone
rclone purge scality:my-bucket
```

---

## 7. File Operations (CRUD) {#file-operations}

### Upload (Create)

```bash
# --- AWS CLI ---

# Upload single file
aws s3 cp file.txt s3://my-bucket/

# Upload to a specific folder
aws s3 cp file.txt s3://my-bucket/documents/file.txt

# Upload entire folder
aws s3 cp ./myfolder s3://my-bucket/myfolder --recursive

# --- Rclone ---

# Upload single file
rclone copy file.txt scality:my-bucket/

# Upload with progress bar
rclone copy ./myfolder scality:my-bucket/myfolder --progress
```

### List Files (Read)

```bash
# --- AWS CLI ---

# List root of bucket
aws s3 ls s3://my-bucket

# List all files recursively
aws s3 ls s3://my-bucket --recursive

# List with size summary
aws s3 ls s3://my-bucket --recursive --human-readable --summarize

# List specific folder
aws s3 ls s3://my-bucket/documents/

# --- Rclone ---

# Simple list
rclone ls scality:my-bucket

# List directories only
rclone lsd scality:my-bucket

# Detailed list (size, date, path)
rclone lsl scality:my-bucket

# Tree view (visual folder structure)
rclone tree scality:my-bucket
```

### Download (Read)

```bash
# --- AWS CLI ---

# Download single file to current directory
aws s3 cp s3://my-bucket/file.txt .

# Download to specific path
aws s3 cp s3://my-bucket/file.txt /home/user/downloads/file.txt

# Download entire bucket
aws s3 cp s3://my-bucket . --recursive

# Download specific folder
aws s3 cp s3://my-bucket/documents . --recursive

# --- Rclone ---

# Download single file
rclone copy scality:my-bucket/file.txt .

# Download entire bucket
rclone copy scality:my-bucket ./local-folder --progress
```

### Update / Overwrite (Update)

```bash
# --- AWS CLI ---

# Overwrite a file (just upload again with same name)
aws s3 cp updated-file.txt s3://my-bucket/file.txt

# Move/rename a file inside bucket
aws s3 mv s3://my-bucket/old-name.txt s3://my-bucket/new-name.txt

# Move file to different folder
aws s3 mv s3://my-bucket/file.txt s3://my-bucket/archive/file.txt

# Move entire folder
aws s3 mv s3://my-bucket/folder1 s3://my-bucket/folder2 --recursive

# Copy file within bucket
aws s3 cp s3://my-bucket/file.txt s3://my-bucket/backup/file.txt

# --- Rclone ---

# Move/rename file
rclone moveto scality:my-bucket/old.txt scality:my-bucket/new.txt

# Copy within bucket
rclone copy scality:my-bucket/file.txt scality:my-bucket/backup/
```

### Delete (Delete)

```bash
# --- AWS CLI ---

# Delete single file
aws s3 rm s3://my-bucket/file.txt

# Delete a folder and all contents
aws s3 rm s3://my-bucket/documents --recursive

# Delete all contents in bucket (keep bucket)
aws s3 rm s3://my-bucket --recursive

# --- Rclone ---

# Delete single file
rclone deletefile scality:my-bucket/file.txt

# Delete a folder
rclone delete scality:my-bucket/documents

# Delete all contents (keep bucket)
rclone delete scality:my-bucket

# Delete bucket and all contents
rclone purge scality:my-bucket
```

---

## 8. Sync & Transfer {#sync-and-transfer}

Sync is smarter than copy — it only transfers **changed or new files**.

```bash
# --- AWS CLI ---

# Sync local folder → bucket (upload changes only)
aws s3 sync ./myfolder s3://my-bucket/

# Sync bucket → local folder (download changes only)
aws s3 sync s3://my-bucket/ ./myfolder

# Sync between two buckets
aws s3 sync s3://source-bucket s3://destination-bucket

# Sync and delete files at destination that no longer exist at source
aws s3 sync ./myfolder s3://my-bucket/ --delete

# --- Rclone ---

# Sync local → bucket
rclone sync ./myfolder scality:my-bucket --progress

# Sync bucket → local
rclone sync scality:my-bucket ./myfolder --progress

# Sync between two buckets
rclone sync scality:source-bucket scality:dest-bucket --progress

# Dry run (see what would change without doing it)
rclone sync ./myfolder scality:my-bucket --dry-run
```

> ⚠️ `sync` **deletes** files at the destination that don't exist at the source. Use `copy` if you don't want deletion.

---

## 9. Pre-signed URLs {#presigned-urls}

Pre-signed URLs let you share a file temporarily without giving out your credentials.

```bash
# Generate a link valid for 1 hour (3600 seconds)
aws s3 presign s3://my-bucket/file.txt --expires-in 3600

# Valid for 1 day
aws s3 presign s3://my-bucket/file.txt --expires-in 86400

# Rclone
rclone link scality:my-bucket/file.txt
```

Anyone with the generated URL can download the file — no credentials needed — until it expires.

---

## 10. Quick Reference Cheatsheet {#cheatsheet}

### AWS CLI

| Action | Command |
|---|---|
| List all buckets | `aws s3 ls` |
| Create bucket | `aws s3 mb s3://bucket` |
| Delete bucket (force) | `aws s3 rb s3://bucket --force` |
| Upload file | `aws s3 cp file.txt s3://bucket/` |
| Upload folder | `aws s3 cp ./folder s3://bucket/ --recursive` |
| Download file | `aws s3 cp s3://bucket/file.txt .` |
| Download folder | `aws s3 cp s3://bucket/ . --recursive` |
| List files | `aws s3 ls s3://bucket --recursive` |
| Move/rename file | `aws s3 mv s3://bucket/old s3://bucket/new` |
| Copy within bucket | `aws s3 cp s3://bucket/file s3://bucket/backup/` |
| Delete file | `aws s3 rm s3://bucket/file.txt` |
| Delete folder | `aws s3 rm s3://bucket/folder --recursive` |
| Sync up | `aws s3 sync ./folder s3://bucket/` |
| Sync down | `aws s3 sync s3://bucket/ ./folder` |
| Pre-signed URL | `aws s3 presign s3://bucket/file --expires-in 3600` |

### Rclone

| Action | Command |
|---|---|
| List all buckets | `rclone lsd scality:` |
| Create bucket | `rclone mkdir scality:bucket` |
| Delete bucket | `rclone purge scality:bucket` |
| Upload file | `rclone copy file.txt scality:bucket/` |
| Upload folder | `rclone copy ./folder scality:bucket/ --progress` |
| Download file | `rclone copy scality:bucket/file.txt .` |
| List files | `rclone ls scality:bucket` |
| Tree view | `rclone tree scality:bucket` |
| Move/rename | `rclone moveto scality:bucket/old scality:bucket/new` |
| Delete file | `rclone deletefile scality:bucket/file.txt` |
| Delete all | `rclone purge scality:bucket` |
| Sync up | `rclone sync ./folder scality:bucket --progress` |
| Sync down | `rclone sync scality:bucket ./folder --progress` |
| Dry run | `rclone sync ./folder scality:bucket --dry-run` |

---

## Tips & Best Practices

- **Rotate credentials regularly** — treat your Access Key and Secret Key like passwords. Never share or commit them to git.
- **Use `--dry-run`** with rclone sync before running the real command to preview changes.
- **Use `sync` over `cp --recursive`** for large folder transfers — it skips already uploaded files.
- **Pre-signed URLs** are great for sharing files without exposing credentials.
- **Never push `.aws/` folder to GitHub** — add it to `.gitignore`.

```bash
# Add to .gitignore
echo ".aws/" >> ~/.gitignore
```

---

*Happy storing! 🚀*