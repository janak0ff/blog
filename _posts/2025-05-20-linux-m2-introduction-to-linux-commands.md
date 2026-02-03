---
title: Linux-M2 - Introduction to Linux Commands
date: 2025-05-20
categories: [linux]
tags:
  - Linux Introduction
  - Introduction
  - Common Linux Shell Commands
description: Learn how to use common Linux commands. what a shell and shell commands are, and how to use commands to do various tasks in Linux. How to use informational commands to find relevant information about your system, navigation commands to navigate files and directories, and management commands to create, delete, copy, and move files and directories. Learn to sort and view files in useful ways and extract specific lines and fields from your files. Use networking commands to examine your network configuration and evaluate, identify, and retrieve data from URLs. Cover file archiving and compression commands.
---


# **Overview of Common Linux Shell Commands**

---

## **1. What is a Shell?**

### **Definition**

A **shell** is a powerful **command-line interpreter** used in Unix-like operating systems (like Linux and macOS).

- It acts as both:
  - An **interactive command language** for users to interact with the OS.
  - A **scripting language** for automating tasks.

### **Common Shells in Linux**

| Shell                  | Description                                        |
| ---------------------- | -------------------------------------------------- |
| **Bash** (`/bin/bash`) | Bourne Again SHell – Default on most Linux distros |
| **sh**                 | Original Bourne shell                              |
| **ksh**                | KornShell – Enhanced version of sh                 |
| **tcsh**               | Extended C Shell with advanced features            |
| **zsh**                | Z Shell – Modern, feature-rich                     |
| **fish**               | Friendly Interactive SHell – beginner-friendly     |

> In this course, we will use **Bash**, the default shell on most Linux systems.

### **How to Check Your Current Shell**

```bash
printenv SHELL
```

Example output:

```
/bin/bash
```

If not Bash, you can switch by typing:

```bash
bash
```

---

## **2. Applications of Shell Commands**

Shell commands are essential for various tasks such as:

| Task Category              | Examples                           |
| -------------------------- | ---------------------------------- |
| **System Info**            | `uname`, `date`, `whoami`          |
| **File Management**        | `cp`, `mv`, `rm`, `touch`          |
| **Directory Navigation**   | `ls`, `cd`, `pwd`, `mkdir`         |
| **Text Display**           | `cat`, `head`, `tail`, `echo`      |
| **Search & Filter**        | `grep`, `find`                     |
| **Compression**            | `tar`, `zip`, `unzip`              |
| **Networking**             | `curl`, `wget`, `ping`, `hostname` |
| **Performance Monitoring** | `top`, `ps`, `df`                  |

---

## **3. Common Shell Commands**

### **A. System Information Commands**

| Command         | Description                          |
| --------------- | ------------------------------------ |
| `whoami`        | Displays current username            |
| `id`            | Shows user and group IDs             |
| `uname`         | Displays OS name and version         |
| `ps`            | Lists running processes              |
| `top`           | Real-time system monitoring tool     |
| `df`            | Shows disk space usage               |
| `man [command]` | Displays manual/help for any command |
| `date`          | Prints current date and time         |

---

### **B. File Management Commands**

| Command                  | Description                              |
| ------------------------ | ---------------------------------------- |
| `cp file1 file2`         | Copy files or directories                |
| `mv file1 file2`         | Move or rename files                     |
| `rm file`                | Remove/delete a file                     |
| `touch file`             | Create an empty file or update timestamp |
| `chmod permissions file` | Change file access permissions           |
| `wc file`                | Count lines, words, characters in a file |
| `grep "pattern" file`    | Search for text within a file            |

---

### **C. Directory Navigation Commands**

| Command                | Description                        |
| ---------------------- | ---------------------------------- |
| `ls`                   | List contents of current directory |
| `find . -name "*.txt"` | Find files matching a pattern      |
| `pwd`                  | Print working (current) directory  |
| `mkdir dir_name`       | Make a new directory               |
| `cd dir_name`          | Change to another directory        |
| `rmdir dir_name`       | Remove an empty directory          |

---

### **D. File Content Viewing Commands**

| Command         | Description                               |
| --------------- | ----------------------------------------- |
| `cat file.txt`  | Concatenate and print full file content   |
| `more file.txt` | View file content one page at a time      |
| `head file.txt` | Show first few lines of a file            |
| `tail file.txt` | Show last few lines of a file             |
| `echo "text"`   | Print text or variable values to terminal |

---

### **E. File Compression & Archiving**

| Command                            | Description                |
| ---------------------------------- | -------------------------- |
| `tar -cvf archive.tar file1 file2` | Archive files into `.tar`  |
| `tar -xvf archive.tar`             | Extract from `.tar` file   |
| `zip archive.zip file1 file2`      | Compress files into `.zip` |
| `unzip archive.zip`                | Extract `.zip` archive     |

---

### **F. Networking Commands**

| Command                            | Description                          |
| ---------------------------------- | ------------------------------------ |
| `hostname`                         | Show system hostname                 |
| `ping google.com`                  | Test network connectivity            |
| `ifconfig`                         | Configure or view network interfaces |
| `curl http://example.com`          | Transfer data from a URL             |
| `wget http://example.com/file.txt` | Download files from the web          |

---

## **4. Running Linux on Windows**

You can run Linux commands on a Windows machine using these methods:

| Method                                | Description                                            |
| ------------------------------------- | ------------------------------------------------------ |
| **Dual Boot**                         | Install Linux alongside Windows on separate partitions |
| **Virtual Machine (VM)**              | Run Linux inside a VM like VirtualBox or VMware        |
| **Linux Emulator (e.g., Cygwin)**     | Run Linux tools in a simulated environment             |
| **Windows Subsystem for Linux (WSL)** | Native Linux compatibility layer on Windows 10/11      |

---

## **5. Summary**

✅ The **role of a shell** in Linux as both a command interpreter and scripting tool.  
✅ How to **check and switch shells** using commands like `printenv SHELL` and `bash`.  
✅ The **main applications** of shell commands across system info, file management, networking, and automation.  
✅ The **most common shell commands** grouped by function for easy reference.

---

## **Quick Reference Table**

| Purpose            | Command                                        |
| ------------------ | ---------------------------------------------- |
| **User Info**      | `whoami`, `id`                                 |
| **System Info**    | `uname`, `date`, `top`, `df`                   |
| **File Ops**       | `cp`, `mv`, `rm`, `touch`, `chmod`, `grep`     |
| **Dir Navigation** | `ls`, `cd`, `pwd`, `mkdir`, `rmdir`, `find`    |
| **View Content**   | `cat`, `head`, `tail`, `more`, `echo`          |
| **Compression**    | `tar`, `zip`, `unzip`                          |
| **Networking**     | `curl`, `wget`, `ping`, `hostname`, `ifconfig` |

---

---

# 🔧 **Linux Shell Commands Cheat Sheet**

> This cheat sheet includes **common Linux shell commands**, their **syntax**, and **examples**. Designed for quick reference and learning.

---

## 🧑‍💻 Basic Navigation

| Command    | Description                     | Example                        |
| ---------- | ------------------------------- | ------------------------------ |
| `pwd`      | Print Working Directory         | `pwd` → `/home/user/documents` |
| `cd <dir>` | Change Directory                | `cd /home/user`                |
| `ls`       | List files in current directory | `ls`                           |
| `ls -l`    | Long listing format             | `ls -l`                        |
| `ls -a`    | Show hidden files               | `ls -a`                        |

---

## 🗂️ File & Directory Management

| Command           | Description               | Example               |
| ----------------- | ------------------------- | --------------------- |
| `touch <file>`    | Create an empty file      | `touch myfile.txt`    |
| `mkdir <dir>`     | Make a new directory      | `mkdir myfolder`      |
| `cp <src> <dest>` | Copy files/dirs           | `cp file.txt backup/` |
| `mv <src> <dest>` | Move or rename files      | `mv old.txt new.txt`  |
| `rm <file>`       | Remove/delete a file      | `rm temp.txt`         |
| `rm -r <dir>`     | Remove a directory        | `rm -r myfolder`      |
| `rmdir <dir>`     | Remove an empty directory | `rmdir empty_folder`  |

---

## 📄 Viewing and Editing Files

| Command                  | Description            | Example                    |
| ------------------------ | ---------------------- | -------------------------- |
| `cat <file>`             | View entire file       | `cat myfile.txt`           |
| `more <file>`            | View file page by page | `more bigfile.txt`         |
| `head <file>`            | Show first 10 lines    | `head myfile.txt`          |
| `tail <file>`            | Show last 10 lines     | `tail myfile.txt`          |
| `nano <file>`            | Edit file using nano   | `nano notes.txt`           |
| `echo "<text>" > <file>` | Write text to a file   | `echo "Hello" > hello.txt` |

---

## 🔍 Searching and Filtering

| Command                         | Description                    | Example                |
| ------------------------------- | ------------------------------ | ---------------------- |
| `grep "<pattern>" <file>`       | Search for pattern in file     | `grep "error" log.txt` |
| `find <path> -name "<pattern>"` | Find files matching name       | `find . -name "*.log"` |
| `wc <file>`                     | Count lines, words, characters | `wc myfile.txt`        |

---

## 🧰 System Information

| Command    | Description               | Example    |
| ---------- | ------------------------- | ---------- |
| `whoami`   | Show current user         | `whoami`   |
| `id`       | Show user and group IDs   | `id`       |
| `uname -a` | Show OS info              | `uname -a` |
| `date`     | Show current date/time    | `date`     |
| `top`      | Real-time process monitor | `top`      |
| `df -h`    | Disk space usage          | `df -h`    |
| `ps`       | List running processes    | `ps`       |

---

## 📦 Compression & Archiving

| Command                          | Description         | Example                     |
| -------------------------------- | ------------------- | --------------------------- |
| `tar -cvf <archive.tar> <files>` | Create tar archive  | `tar -cvf backup.tar *.txt` |
| `tar -xvf <archive.tar>`         | Extract tar archive | `tar -xvf backup.tar`       |
| `zip <archive.zip> <files>`      | Compress files      | `zip docs.zip *.docx`       |
| `unzip <archive.zip>`            | Extract zip archive | `unzip docs.zip`            |

---

## 🌐 Networking

| Command       | Description                            | Example                            |
| ------------- | -------------------------------------- | ---------------------------------- |
| `hostname`    | Show system hostname                   | `hostname`                         |
| `ping <host>` | Test network connection                | `ping google.com`                  |
| `ifconfig`    | Show network interfaces _(deprecated)_ | `ifconfig`                         |
| `ip addr`     | Alternative to ifconfig                | `ip addr show`                     |
| `curl <url>`  | Download from URL                      | `curl http://example.com`          |
| `wget <url>`  | Download and save file                 | `wget http://example.com/file.txt` |

---

## 💾 Package Management

### Debian/Ubuntu (.deb)

| Command                  | Description          | Example                 |
| ------------------------ | -------------------- | ----------------------- |
| `sudo apt update`        | Update package list  | `sudo apt update`       |
| `sudo apt upgrade`       | Upgrade all packages | `sudo apt upgrade`      |
| `sudo apt install <pkg>` | Install a package    | `sudo apt install curl` |

### Red Hat/CentOS/Fedora (.rpm)

| Command                  | Description         | Example                 |
| ------------------------ | ------------------- | ----------------------- |
| `sudo yum update`        | Update all packages | `sudo yum update`       |
| `sudo yum install <pkg>` | Install a package   | `sudo yum install wget` |

---

## 🖥️ Shell Utilities

| Command         | Description           | Example   |
| --------------- | --------------------- | --------- |
| `man <command>` | View manual/help      | `man ls`  |
| `history`       | Show command history  | `history` |
| `clear`         | Clear terminal screen | `clear`   |
| `exit`          | Exit shell session    | `exit`    |

---

# **Linux Informational Commands Cheat Sheet**

---

## 🔍 1. **User & Identity Info**

| Command  | Description             | Example           |
| -------- | ----------------------- | ----------------- |
| `whoami` | Show current username   | `whoami` → `john` |
| `id`     | Show user and group IDs | `id`              |
| `id -u`  | Show numeric user ID    | `id -u` → `1001`  |
| `id -un` | Show username from UID  | `id -un` → `john` |

---

## 🖥️ 2. **Operating System Info**

| Command    | Description                  | Example                          |
| ---------- | ---------------------------- | -------------------------------- |
| `uname`    | Show OS name                 | `uname` → `Linux`                |
| `uname -s` | Show OS name (same as above) | `uname -s`                       |
| `uname -r` | Show kernel release version  | `uname -r` → `5.15.0-76-generic` |
| `uname -v` | Show kernel version          | `uname -v`                       |
| `uname -a` | Show all system info         | `uname -a`                       |

---

## 💾 3. **Disk Usage Info**

| Command        | Description                           | Example             |
| -------------- | ------------------------------------- | ------------------- |
| `df -h ~`      | Disk usage of home directory          | `df -h ~`           |
| `df -h`        | Disk usage of all mounted filesystems | `df -h`             |
| `du -sh <dir>` | Show size of a directory              | `du -sh /home/john` |

> `-h` makes output human-readable (e.g., GB instead of bytes)

---

## 🔄 4. **Process Monitoring**

| Command    | Description                                          | Example    |
| ---------- | ---------------------------------------------------- | ---------- |
| `ps`       | Show running processes (current shell only)          | `ps`       |
| `ps -e`    | Show all running processes                           | `ps -e`    |
| `top`      | Real-time process monitor                            | `top`      |
| `top -n 3` | Show top 3 processes                                 | `top -n 3` |
| `htop`     | Enhanced interactive process viewer _(if installed)_ | `htop`     |

---

## 🖨️ 5. **Printing Strings, Variables, and Dates**

| Command              | Description                              | Example                                     |
| -------------------- | ---------------------------------------- | ------------------------------------------- |
| `echo "text"`        | Print text to terminal                   | `echo "Hello World"`                        |
| `echo $PATH`         | Print value of an environment variable   | `echo $HOME`                                |
| `date`               | Print current date/time (default format) | `date`                                      |
| `date +"%j %Y"`      | Print day of year and year               | `date +"Day %j of %Y"` → `Day 097 of 2023`  |
| `date +"%A, %j, %Y"` | Day name, day of year, year              | `date +"%A, %j, %Y"` → `Tuesday, 097, 2023` |

---

## 📚 6. **Command Manuals**

| Command      | Description                        | Example      |
| ------------ | ---------------------------------- | ------------ |
| `man whoami` | View manual for `whoami`           | `man whoami` |
| `man id`     | View manual for `id`               | `man id`     |
| `man df`     | View manual for `df`               | `man df`     |
| `man ps`     | View manual for `ps`               | `man ps`     |
| `man date`   | View manual for `date`             | `man date`   |
| `man man`    | Learn how to use the `man` command | `man man`    |

---

### 📚 **Getting Help for Linux Commands – A Complete Guide**

When working with Linux, knowing how to find help is just as important as knowing the commands themselves. Here’s a structured approach to getting assistance when you’re stuck or curious.

---

## 🔍 1. **Use the Built-in `man` Command**

The `man` (manual) command is the traditional and most comprehensive way to get help in Linux.

### 🧾 How to Use It:

```bash
man command_name
```

Example:

```bash
man ls
```

### 📘 Man Page Sections:

| Section     | Description                                   |
| ----------- | --------------------------------------------- |
| NAME        | Name and brief description of the command     |
| SYNOPSIS    | How to use the command, including options     |
| DESCRIPTION | Detailed explanation of what the command does |
| OPTIONS     | List of available flags or arguments          |
| EXAMPLES    | Common usage examples                         |
| SEE ALSO    | Related commands or documentation             |

### 📋 View All Available Man Pages:

```bash
man -k .
```

This lists all commands with manual pages and a short description.

---

## 📝 2. **Install and Use the `tldr` Command**

`tldr` provides **simplified**, **example-based** help for common commands — perfect for quick reference.

### 💾 Install it:

If Node.js is installed:

```bash
npm install -g tldr
```

### 🚀 Usage:

```bash
tldr ls
```

You’ll see concise examples like:

```
ls
List directory contents.

- List files one per line:
  ls -1

- List all files, including hidden ones:
  ls -a
```

Ideal for users who want **just enough info to get the job done**.

---

## 💬 3. **Search Stack Overflow**

Stack Overflow is a powerful community-driven Q&A platform for developers and sysadmins.

### 🔍 Tips for Searching:

- Use the search bar on [https://stackoverflow.com/questions/tagged/linux](https://stackoverflow.com/questions/tagged/linux)
- Include relevant tags: `linux`, `bash`, `shell`, `command-line`
- Check the date of answers and read comments for context

> 📌 Example query:  
> `"how to delete a file in linux" site:stackoverflow.com`

---

## 🤖 4. **Search Stack Exchange (Unix & Linux)**

[Unix & Linux Stack Exchange](https://unix.stackexchange.com/) is ideal for deeper technical questions.

### 🎯 Best For:

- More detailed explanations than Stack Overflow
- Complex issues involving system administration, scripting, or obscure commands

---

## 🔍 5. **Just Google It!**

Sometimes, a simple web search is the fastest way to solve a problem.

### ✅ Tips:

- Include keywords like `Linux`, `Ubuntu`, or `bash`
- Add sources like `site:wikipedia.org` or `site:askubuntu.com`
- Avoid blindly trusting old or unverified results

---

## 📋 6. **Use Course Cheat Sheets**

Throughout this course, you'll encounter cheat sheets that:

- Condense key commands into easy-to-reference formats
- Help you review and apply concepts faster
- Are great for exam prep and real-world use

---

## 📄 7. **Refer to Wikipedia's List of Unix Commands**

Wikipedia maintains a list of Unix/Linux commands:
🔗 [List of Unix Commands (Wikipedia)](https://en.wikipedia.org/wiki/List_of_Unix_commands)

Includes:

- Command name
- Category (e.g., Filesystem, Process management)
- Description
- First appearance (e.g., Version 7 AT&T UNIX)

Great for historical context and discovering lesser-known utilities.

---

## 🧠 Summary Table: Ways to Get Help

| Method         | Best For                                 | Example                                                                      |
| -------------- | ---------------------------------------- | ---------------------------------------------------------------------------- |
| `man`          | Full, official documentation             | `man ls`                                                                     |
| `tldr`         | Quick examples and cheatsheet-style help | `tldr cp`                                                                    |
| Stack Overflow | Programming-related issues               | Search "how to rename file in Linux"                                         |
| Stack Exchange | Advanced Unix/Linux topics               | Visit [Unix & Linux SE](https://unix.stackexchange.com/)                     |
| Google         | Fast solutions and general knowledge     | Search "Linux sort file"                                                     |
| Cheat Sheets   | Quick reference and learning             | Provided in this course                                                      |
| Wikipedia      | Overview and history of commands         | [List of Unix Commands](https://en.wikipedia.org/wiki/List_of_Unix_commands) |

---

### 📌 **Exercise 1 - Informational Commands**

In this exercise, you explored several **Linux commands** that provide valuable system and user information. These commands are essential for understanding your environment, troubleshooting issues, and monitoring system performance.

---

## 🔍 Overview of Commands Covered

| Command  | Purpose                                             |
| -------- | --------------------------------------------------- |
| `whoami` | Displays the current user                           |
| `uname`  | Shows kernel/OS info                                |
| `id`     | Displays user and group IDs                         |
| `df`     | Shows disk space usage                              |
| `ps`     | Lists running processes                             |
| `top`    | Real-time view of running processes and system load |
| `echo`   | Prints text or variables to the terminal            |
| `date`   | Displays or sets the system date and time           |
| `man`    | Displays manual pages for commands                  |

---

## 🧾 Detailed Breakdown

### ✅ 1.1 Display Current User

```bash
whoami
```

- Output: `theia`
- Tells you which user is currently logged in.

---

### ✅ 1.2 Get OS Info with `uname`

```bash
uname
```

- Outputs: `Linux`

To get full system info:

```bash
uname -a
```

This includes:

- Kernel name
- Hostname
- Kernel release
- Kernel version
- Machine hardware name
- Processor type
- Operating system

---

### ✅ 1.3 View User Identity

```bash
id
```

- Shows:
  - `uid`: User ID
  - `gid`: Group ID
  - List of groups the user belongs to

---

### ✅ 1.4 Check Disk Space

```bash
df
```

- Shows disk usage in **512-byte blocks**

For human-readable format:

```bash
df -h
```

- Shows sizes in KB, MB, GB

---

### ✅ 1.5 View Running Processes

```bash
ps
```

- Lists processes owned by the current user

To see all processes:

```bash
ps -e
```

---

### ✅ 1.6 Real-Time Process Monitoring with `top`

```bash
top
```

- Gives live updates of:
  - Running processes
  - CPU and memory usage
  - System uptime
  - Load average

To exit: Press `q` or `Ctrl + C`  
To limit refreshes:

```bash
top -n 10
```

Sorting options (while `top` is running):

- `Shift + M` → Sort by memory
- `Shift + P` → Sort by CPU usage
- `Shift + N` → Sort by PID
- `Shift + T` → Sort by runtime

---

### ✅ 1.7 Print Messages with `echo`

```bash
echo "Welcome to the Linux lab"
```

Output:

```
Welcome to the Linux lab
```

Use `-e` to interpret escape characters:

```bash
echo -e "Line one\nLine two"
```

Output:

```
Line one
Line two
```

Common escape characters:

- `\n` – New line
- `\t` – Tab

---

### ✅ 1.8 Show Date and Time

```bash
date
```

- Shows full current date and time

Custom formats:

```bash
date "+%D"     # mm/dd/yy
date "+%Y-%m-%d %T"  # 2025-04-05 14:30:00
```

Popular format specifiers:
| Specifier | Meaning |
|----------|---------|
| `%d` | Day of month |
| `%h` | Abbreviated month (Jan-Dec) |
| `%m` | Month number |
| `%Y` | 4-digit year |
| `%T` | Time in HH:MM:SS |
| `%H` | Hour (00–23) |

---

### ✅ 1.9 View Manual Pages

```bash
man ls
```

- Opens the manual page for the `ls` command

To list all available man pages:

```bash
man -k .
```

Man pages typically include:

- NAME
- SYNOPSIS
- DESCRIPTION
- OPTIONS
- EXAMPLES
- SEE ALSO

---

## 📋 Summary Table

| Task                   | Command                   |
| ---------------------- | ------------------------- |
| Show current user      | `whoami`                  |
| Show OS info           | `uname`, `uname -a`       |
| Show user identity     | `id`                      |
| Show disk usage        | `df`, `df -h`             |
| List running processes | `ps`, `ps -e`             |
| Monitor processes live | `top`, `top -n 10`        |
| Print text             | `echo`, `echo -e`         |
| Show date/time         | `date`, `date "+format"`  |
| View command help      | `man command`, `man -k .` |

---

## 💡 Tips & Best Practices

- Use `--help` with many commands for quick usage examples:
  ```bash
  ls --help
  ```
- Combine `man` and `tldr` for both depth and speed:
  ```bash
  tldr df
  ```
- Use `watch` for repeated execution:
  ```bash
  watch df -h
  ```

---

### 📚 **Practice Exercises with Solutions**

Here are the practice exercises along with hints and complete solutions to reinforce your understanding of essential Linux commands.

---

## 🔹 **1. Get basic information about the operating system**

### 💡 Hint:

Use the `uname` command for kernel and OS-related information.

### ✅ Solution:

```bash
uname -a
```

This will display detailed system information, including:

- Kernel name
- Hostname
- Kernel release version
- Machine hardware name
- Operating system

---

## 🔹 **2. View all running processes on the system**

### 💡 Hint:

The `ps` command lists running processes. Use an option to show **all** processes.

### ✅ Solution:

```bash
ps -e
```

This shows every process currently running on the system, not just those owned by the current user.

---

## 🔹 **3. Get the table of processes and sort by memory usage**

### 💡 Hint:

Use the `top` command and a keyboard shortcut to sort by memory.

### ✅ Solution:

```bash
top
```

Once inside `top`, press:

```
Shift + M
```

This sorts the list by **memory usage**, allowing you to quickly identify which processes are using the most RAM.

> To exit `top`, press `q`.

---

## 🔹 **4. Display the current time**

### 💡 Hint:

Use the `date` command with a format specifier to show only the time.

### ✅ Solution:

```bash
date "+%T"
```

Output example:

```
14:25:36
```

Other useful formats:

- `date "+%H:%M"` → `14:25`
- `date "+%r"` → `02:25:36 PM`

---

## 🔹 **5. Using one command, display the messages "Hello!" and "Goodbye!" separated by a new line**

### 💡 Hint:

Use the `echo` command with the `-e` option to interpret escape sequences like `\n`.

### ✅ Solution:

```bash
echo -e "Hello!\nGoodbye!"
```

Output:

```
Hello!
Goodbye!
```

> The `-e` flag enables interpretation of backslash escapes like `\n` (new line) and `\t` (tab).

---

## 🎯 Bonus Tips

- Combine `echo` with redirection to write text into files:
  ```bash
  echo "Hello World" > hello.txt
  ```
- Use `watch` to monitor changing output:
  ```bash
  watch "ps -e | head -n 10"
  ```

---

# **File and Directory Navigation Commands in Linux**

---

## **Introduction**

This video introduces the essential **Linux commands for navigating files and directories**. After watching, you will be able to:

✅ Use `ls` to list directory contents  
✅ Navigate between directories using `cd`  
✅ Understand **relative vs absolute paths**  
✅ Search for files using the `find` command

---

## **1. List Files and Directories: `ls` Command**

### **Purpose**

The `ls` (list) command is used to display the contents of a directory.

### **Basic Usage**

- To list files in the current directory:

  ```bash
  ls
  ```

- To list files in a specific directory:
  ```bash
  ls Downloads
  ```

### **Common Options**

| Option | Description                                                  | Example  |
| ------ | ------------------------------------------------------------ | -------- |
| `-l`   | Long format – shows permissions, owner, size, date, and name | `ls -l`  |
| `-a`   | Show hidden files (files starting with `.`)                  | `ls -a`  |
| `-la`  | Detailed list including hidden files                         | `ls -la` |

> The output from `ls -l` includes:

- File type and permissions (`drwxr-xr-x`)
- Number of links
- Owner name
- Group name
- Size in bytes
- Date of last modification
- File or directory name

---

## **2. Show Current Working Directory: `pwd`**

### **Purpose**

The `pwd` (print working directory) command shows your **current location** in the file system.

### **Usage**

```bash
pwd
```

> Example Output:

```
/home/user/Documents
```

Useful when:

- You're unsure which directory you are in.
- You want to verify your location before running commands.

---

## **3. Change Directory: `cd` Command**

### **Purpose**

The `cd` (change directory) command lets you move between directories.

### **Basic Syntax**

```bash
cd <directory_path>
```

### **Examples**

| Command                         | Description                               |
| ------------------------------- | ----------------------------------------- |
| `cd Documents`                  | Move into the `Documents` subdirectory    |
| `cd ..`                         | Move up one level to the parent directory |
| `cd ~` or just `cd`             | Go to your home directory                 |
| `cd /home/user/Documents/Notes` | Move to an absolute path                  |
| `cd ./projects`                 | Move to a relative path                   |

### **Understanding Path Types**

| Type              | Description                                  | Example              |
| ----------------- | -------------------------------------------- | -------------------- |
| **Absolute Path** | Starts from root `/`, always starts with `/` | `/var/log/syslog`    |
| **Relative Path** | Relative to current working directory        | `../images/logo.png` |

---

## **4. Find Files: `find` Command**

### **Purpose**

The `find` command helps you locate files and directories based on various criteria like name, type, size, etc.

### **Basic Syntax**

```bash
find <starting_directory> <options>
```

### **Common Examples**

| Command                         | Description                                             |
| ------------------------------- | ------------------------------------------------------- |
| `find . -name "a.txt"`          | Find all files named `a.txt` in current directory (`.`) |
| `find /home/user -name "*.txt"` | Find all `.txt` files in user's home directory          |
| `find . -iname "a.txt"`         | Case-insensitive search for `a.txt`                     |
| `find . -type d -name "Images"` | Find directories named `Images`                         |
| `find . -type f`                | Find only files in current directory tree               |

> Tip: The `.` means “start searching here” — it’s useful when you want to limit the scope of your search.

---

## **5. Summary of Key Concepts**

### ✅ `ls` – Listing Contents

- Lists files and directories.
- Use options like `-l`, `-a`, and `-la` for more detailed views.

### ✅ `pwd` – Knowing Where You Are

- Displays the full path of the current working directory.

### ✅ `cd` – Moving Around

- Supports both **absolute** and **relative** paths.
- Use `~` to go to your home directory.
- Use `..` to move up one level.

### ✅ `find` – Searching Efficiently

- Powerful tool for locating files and folders.
- Can use exact names, wildcards, case-insensitive searches, and filters by type.

---

## **6. Quick Reference Table**

| Task                            | Command                          |
| ------------------------------- | -------------------------------- |
| List files in current directory | `ls`                             |
| List with details               | `ls -l`                          |
| Show hidden files               | `ls -a`                          |
| Print current directory         | `pwd`                            |
| Move into a directory           | `cd <dir>`                       |
| Move to home directory          | `cd ~` or `cd`                   |
| Move up one level               | `cd ..`                          |
| Move to absolute path           | `cd /path/to/dir`                |
| Find files by name              | `find . -name "filename"`        |
| Find files case-insensitively   | `find . -iname "filename"`       |
| Find directories only           | `find . -type d -name "dirname"` |

---

## **7. Final Thoughts**

Mastering these navigation commands gives you control over your Linux environment. Whether you're organizing files, troubleshooting issues, or writing scripts, understanding how to navigate the filesystem efficiently is crucial.

---

# **File and Directory Management Commands in Linux V2**

---

## **1. Introduction**

✅ Creating and deleting files and directories  
✅ Copying and moving files and folders  
✅ Managing file permissions (e.g., making a script executable)

These commands are essential for managing your system, organizing data, and working with scripts or configuration files.

---

## **2. Creating and Removing Files and Directories**

### **A. `mkdir` – Make Directory**

- **Purpose**: Create new directories.
- **Syntax**:
  ```bash
  mkdir <directory_name>
  ```
- **Example**:
  ```bash
  mkdir test
  ```

> Creates a directory named `test` in the current location.

---

### **B. `rm` – Remove Files or Directories**

- **Purpose**: Delete files or directories.
- **Syntax**:

  ```bash
  rm <filename>
  ```

- **Remove a file**:

  ```bash
  rm file1.txt
  ```

- **Remove a directory and its contents**:
  ```bash
  rm -r folder1
  ```

> ⚠️ **Warning**: Use `rm -r` carefully — it deletes everything inside the directory recursively.

---

### **C. `rmdir` – Remove Empty Directories**

- **Purpose**: Delete only **empty** directories.
- **Syntax**:

  ```bash
  rmdir <directory_name>
  ```

- **Example**:
  ```bash
  rmdir empty_folder
  ```

> If the folder contains files or subdirectories, this command will fail — use `rm -r` instead.

---

### **D. `touch` – Create Empty Files or Update Timestamps**

- **Purpose**: Create an empty file or update the last-modified timestamp of an existing one.
- **Syntax**:

  ```bash
  touch <filename>
  ```

- **Create multiple files**:

  ```bash
  touch a.txt b.txt c.txt
  ```

- **Update timestamp on an existing file**:
  ```bash
  touch notes.txt
  ```

> Useful for testing, scripting, or resetting file timestamps.

---

## **3. Copying and Moving Files and Directories**

### **A. `cp` – Copy Files or Directories**

- **Purpose**: Copy files from one location to another.
- **Syntax**:

  ```bash
  cp <source> <destination>
  ```

- **Copy a single file**:

  ```bash
  cp notes.txt Documents/
  ```

- **Copy and rename a file**:

  ```bash
  cp notes.txt Documents/backup_notes.txt
  ```

- **Copy a directory and all contents**:
  ```bash
  cp -r Documents Docs_copy
  ```

> The `-r` option enables recursive copying of directories and their contents.

---

### **B. `mv` – Move or Rename Files/Directories**

- **Purpose**: Move files/dirs or rename them.
- **Syntax**:

  ```bash
  mv <source> <destination>
  ```

- **Move a file into a directory**:

  ```bash
  mv my_script.sh Scripts/
  ```

- **Rename a file**:

  ```bash
  mv old_name.txt new_name.txt
  ```

- **Move multiple directories into another**:
  ```bash
  mv Scripts Notes Documents/
  ```

> Unlike `cp`, `mv` does **not duplicate** the original — it moves or renames.

---

## **4. Managing File Permissions with `chmod`**

### **A. `chmod` – Change File Mode (Permissions)**

- **Purpose**: Set or change **read**, **write**, and **execute** permissions on files.
- **Syntax**:
  ```bash
  chmod [options] <filename>
  ```

### **Common Options**

| Option | Description               |
| ------ | ------------------------- |
| `+r`   | Add read permission       |
| `+w`   | Add write permission      |
| `+x`   | Add execute permission    |
| `-r`   | Remove read permission    |
| `-w`   | Remove write permission   |
| `-x`   | Remove execute permission |

### **Example: Making a Script Executable**

```bash
chmod +x my_script.sh
```

- Before:

  ```bash
  -rw-r--r-- 1 user group 0 Jan 1 12:00 my_script.sh
  ```

- After:
  ```bash
  -rwxr-xr-x 1 user group 0 Jan 1 12:00 my_script.sh
  ```

Now you can run the script:

```bash
./my_script.sh
```

---

## **5. Summary of Key Commands**

| Task                            | Command           | Notes                       |
| ------------------------------- | ----------------- | --------------------------- |
| Create a directory              | `mkdir <dir>`     |                             |
| Remove a file                   | `rm <file>`       |                             |
| Remove a directory and contents | `rm -r <dir>`     | Use with caution            |
| Remove an empty directory       | `rmdir <dir>`     | Safe alternative            |
| Create or update a file         | `touch <file>`    | Sets current timestamp      |
| Copy files                      | `cp <src> <dest>` | Use `cp -r` for directories |
| Move or rename files            | `mv <src> <dest>` | Also used for renaming      |
| Change file permissions         | `chmod +x <file>` | Makes a file executable     |

---

## **6. Final Tips**

- Always double-check before using `rm -r` — it's irreversible.
- Use `rmdir` when removing empty directories to avoid accidental deletion.
- `chmod` is essential for running scripts or setting up secure environments.
- Combine these commands with others like `ls`, `cd`, and `find` for powerful file operations.

---

### 📁 Exercise 1 - Navigating Files and Directories

In this exercise, you practiced essential Linux commands for **navigating the filesystem**, **listing directory contents**, and understanding **file patterns**.

---

## 📍 1.1 Get the Location of the Present Working Directory

### Command:

```bash
pwd
```

### What It Does:

- Stands for **"Print Working Directory"**
- Shows the **full path** to the directory where you are currently located

Example output:

```
/home/theia
```

---

## 📋 1.2 List Files and Directories in a Directory

### Basic Usage:

```bash
ls
```

- Lists all **non-hidden files and directories** in the current location
- If the directory is empty, it returns nothing

### View Contents of `/bin` (Binary Directory):

```bash
ls /bin
```

- Displays system-level commands like `ls`, `cd`, `cp`, etc.
- You can also look at specific files:
  ```bash
  ls /bin/ls
  ```

### Use Wildcards to Match Patterns:

#### 🔍 All files starting with `b`:

```bash
ls /bin/b*
```

#### 🔍 All files ending with `r`:

```bash
ls /bin/*r
```

> 💡 The `*` wildcard matches any number of characters

---

## 📄 Long Listing Format

### See detailed file information:

```bash
ls -l
```

Includes:

- File type and permissions
- Number of links
- Owner
- Group
- Size in bytes
- Last modification date/time
- File or directory name

### Common `ls` Options:

| Option | Description                                 |
| ------ | ------------------------------------------- |
| `-a`   | Show hidden files (those starting with `.`) |
| `-d`   | Show directories only                       |
| `-h`   | Human-readable sizes (e.g., KB, MB)         |
| `-l`   | Long listing format                         |
| `-S`   | Sort by file size (largest first)           |
| `-t`   | Sort by modification time (newest first)    |
| `-r`   | Reverse sort order                          |

### Example: List all files (including hidden ones) in long format:

```bash
ls -la
```

### Example: List all files in `/etc` with details:

```bash
ls -la /etc
```

This helps you explore system-wide configuration files.

---

## ✅ Summary Table

| Task                        | Command                    |
| --------------------------- | -------------------------- |
| Show current directory      | `pwd`                      |
| List files in current dir   | `ls`                       |
| List files in `/bin`        | `ls /bin`                  |
| List files matching pattern | `ls /bin/b*`, `ls /bin/*r` |
| Long list format            | `ls -l`                    |
| Show hidden files           | `ls -a`                    |
| Long list including hidden  | `ls -la`                   |
| Human-readable sizes        | `ls -lh`                   |

---

## 💡 Pro Tips

- Combine options:
  ```bash
  ls -lah   # Long list, human-readable, include hidden
  ```
- Use tab completion to avoid typing full paths:
  ```bash
  ls /bi<TAB>
  ```
  Becomes:
  ```bash
  ls /bin/
  ```

---

### 📁 Exercise 2 - Creating Files and Directories

In this exercise, you practiced using Linux commands to **create directories**, **navigate the filesystem**, and **create or update files** using the `touch` command.

---

## ✅ Summary of Commands Covered

| Task                                     | Command                |
| ---------------------------------------- | ---------------------- |
| Create a directory                       | `mkdir directory_name` |
| Change working directory                 | `cd directory_name`    |
| Move up one directory level              | `cd ..`                |
| Go back to home directory                | `cd`                   |
| Create an empty file or update timestamp | `touch filename`       |

---

## 🧾 Step-by-Step Breakdown

### 🔹 2.1 Create a Directory with `mkdir`

```bash
mkdir scripts
```

- Creates a new directory named `scripts` in your current location

Verify it was created:

```bash
ls
```

You should see `scripts` listed.

---

### 🔹 2.2 Change Working Directory with `cd`

Move into the `scripts` directory:

```bash
cd scripts
```

Check your current location:

```bash
pwd
```

Return to your home directory:

```bash
cd
```

Move up one level (to the parent directory):

```bash
cd ..
```

This is useful when navigating through nested directories.

---

### 🔹 2.3 Create an Empty File with `touch`

Go back to your home directory:

```bash
cd
```

Create a new file called `myfile.txt`:

```bash
touch myfile.txt
```

Verify the file exists:

```bash
ls
```

If the file already exists, `touch` updates its **last-modified timestamp**:

```bash
touch myfile.txt
```

To check the updated timestamp:

```bash
date -r myfile.txt
```

This shows the last time the file was accessed or modified.

---

## 📋 Tips & Tricks

- You can create multiple directories at once:
  ```bash
  mkdir dir1 dir2 dir3
  ```
- Make a nested directory structure easily:
  ```bash
  mkdir -p project/files/data
  ```
  The `-p` option creates parent directories as needed.
- Use tab completion for faster navigation:
  ```bash
  cd scri<TAB>
  ```
  Completes to:
  ```bash
  cd scripts
  ```

---

## 🧠 Why These Commands Matter

These basic tools are essential for managing your workspace in Linux:

- `mkdir`: Organize your files by creating structured directories
- `cd`: Navigate between folders quickly
- `touch`: Create placeholder files or update timestamps for testing or scripting purposes

---

### 📁 Exercise 3 - Managing Files and Directories

In this exercise, you practiced essential Linux commands for **searching**, **removing**, **moving**, **renaming**, and **copying** files and directories — key skills for managing your system effectively.

---

## ✅ Summary of Commands Covered

| Task                  | Command       |
| --------------------- | ------------- |
| Search for files      | `find`        |
| Remove (delete) files | `rm`, `rm -i` |
| Move or rename files  | `mv`          |
| Copy files            | `cp`          |

---

## 🔍 Step-by-Step Breakdown

### 🔹 3.1 Search for Files Using `find`

```bash
find /etc -name '*.txt'
```

- Searches the `/etc` directory and its subdirectories for all `.txt` files.
- `-name` specifies a filename pattern to match.
- You may see "Permission denied" errors — these are normal due to access restrictions in lab environments.

---

### 🔹 3.2 Remove Files with `rm`

```bash
rm -i myfile.txt
```

- The `-i` option prompts for confirmation before deletion:
  ```
  rm: remove regular file 'myfile.txt'? y/n
  ```

After deletion, verify:

```bash
ls
```

> ⚠️ Warning: Deleted files **cannot be recovered easily**. Always double-check what you're deleting.

Use without `-i` only when sure:

```bash
rm myfile.txt
```

Delete multiple files safely using confirmation:

```bash
rm -i *.txt
```

---

### 🔹 3.3 Move or Rename Files with `mv`

#### ✏️ Rename a File:

```bash
mv users.txt user-info.txt
```

This renames `users.txt` to `user-info.txt` in the same directory.

Verify:

```bash
ls
```

#### 📦 Move a File to Another Directory:

```bash
mv user-info.txt /tmp
```

Moves `user-info.txt` to the `/tmp` directory.

Verify:

```bash
ls
ls -l /tmp
```

> 💡 If the target file already exists, it will be overwritten silently — always be cautious!

---

### 🔹 3.4 Copy Files with `cp`

#### 📄 Copy from One Location to Another:

```bash
cp /tmp/user-info.txt user-info.txt
```

This copies the file back to your current working directory.

Verify:

```bash
ls
```

#### 📂 Copy Content of a System File:

```bash
cp /etc/passwd users.txt
```

This creates a new file `users.txt` containing the contents of `/etc/passwd`.

Check that the copy was successful:

```bash
ls
cat users.txt
```

You can also view the first few lines:

```bash
head users.txt
```

---

## 🧰 Pro Tips

- Use wildcards to move or copy groups of files:
  ```bash
  cp *.txt /backup/
  mv *.log logs/
  ```
- Combine `cp` with `-r` to copy entire directories:
  ```bash
  cp -r myfolder/ backup/
  ```
- Use `rm -r` carefully to delete directories and their contents:
  ```bash
  rm -r myfolder
  ```

---

## 🧠 Why These Commands Matter

These tools give you full control over your filesystem:

- `find`: Locate files across your system
- `rm`: Clean up unwanted files
- `mv`: Reorganize or rename files
- `cp`: Duplicate or archive content

They form the foundation for automating tasks, writing scripts, and managing data efficiently.

---

### 📚 **Practice Exercises – Managing Files and Directories**

Here are the practice exercises with **hints** and **solutions** to help reinforce your understanding of Linux commands for navigating, creating, moving, copying, and deleting files and directories.

---

## 🔹 **1. Display the contents of the /home directory**

### 💡 Hint:

Use the `ls` command to list directory contents.

### ✅ Solution:

```bash
ls /home
```

This shows all user directories inside `/home`.

---

## 🔹 **2. Ensure that you are in your home directory**

### 💡 Hint:

Use the `cd` command without arguments to return to your home directory.

### ✅ Solution:

```bash
cd
```

You can verify using:

```bash
pwd
```

It should output something like:

```
/home/theia
```

---

## 🔹 **3. Create a new directory called tmp and verify its creation**

### 💡 Hint:

Use `mkdir` to create a directory and `ls` to confirm it exists.

### ✅ Solution:

```bash
mkdir tmp
ls
```

You should see `tmp` listed in the output.

---

## 🔹 **4. Create a new, empty file named display.sh in the tmp directory, and verify its creation**

### 💡 Hint:

Navigate into the `tmp` directory and use `touch` to create an empty file.

### ✅ Solution:

```bash
cd tmp
touch display.sh
ls
```

You should see `display.sh` listed.

---

## 🔹 **5. Create a copy of display.sh, called report.sh, within the same directory**

### 💡 Hint:

Use the `cp` command to make a copy of a file.

### ✅ Solution:

```bash
cp display.sh report.sh
ls
```

Now both `display.sh` and `report.sh` should be listed.

---

## 🔹 **6. Move your copied file, report.sh, up one level in the directory tree to the parent directory. Verify your changes**

### 💡 Hint:

Use `mv` to move the file and `cd ..` or `ls -l ../` to check.

### ✅ Solution:

```bash
mv report.sh ..
ls ..
```

Or:

```bash
cd ..
ls
```

You should now see `report.sh` in the parent directory.

---

## 🔹 **7. Delete the file display.sh**

### 💡 Hint:

Use the `rm` command to delete a file. Consider using `-i` for confirmation (optional).

### ✅ Solution:

```bash
rm display.sh
```

To verify:

```bash
ls
```

The file `display.sh` should no longer appear.

---

## 🔹 **8. List the files in /etc directory in the ascending order of their access time**

### 💡 Hint:

Use the `ls` command with appropriate options to sort by access time.

### ✅ Solution:

```bash
ls -ltu /etc
```

- `-l` = long listing format
- `-t` = sort by modification time (but combined with `-u`, sorts by access time)
- `-u` = use access time for sorting

> This lists files sorted by when they were last accessed, newest first.

---

## 🔹 **9. Copy the file /var/log/bootstrap.log to your current directory**

### 💡 Hint:

Use the `cp` command to copy a file from its source path to the current directory.

### ✅ Solution:

```bash
cp /var/log/bootstrap.log .
```

To verify:

```bash
ls
```

You should see `bootstrap.log` in your current directory.

---

## 🧠 Bonus Tips

- Use tab completion to avoid typing full paths:
  ```bash
  cp /va<TAB>/lo<TAB>/boo<TAB> .
  ```
- Combine `ls` options for better readability:
  ```bash
  ls -lh
  ```
- Use `rm -i` when unsure:
  ```bash
  rm -i *.tmp
  ```

---

Great job completing these hands-on exercises! You're now comfortable with basic file and directory management in Linux.

---

### 🔒 **Security: Managing File Permissions and Ownership – Summary & Guide**

In this reading, you learned how to manage **file permissions** and **ownership** in Linux — a crucial skill for protecting sensitive data and ensuring system security.

---

## 🎯 **Learning Objectives Recap**

By the end of this section, you should be able to:

- Explain file ownership and permissions
- View file and directory permissions
- Make files private by changing permission settings

---

## 🔐 Why File Permissions Matter

Linux is a **multi-user operating system**, which means multiple people can access the same machine. Without proper permissions:

- Anyone could **read or modify your files**
- Malicious users might **execute harmful scripts**
- Sensitive documents (like tax records or company IP) could be **exposed**

That’s why **permissions and ownership** allow fine-grained control over who can read, write, or execute files.

---

## 👤 Types of Owners in Linux

There are **three categories** of users that determine permission levels:

| Category      | Meaning                                     |
| ------------- | ------------------------------------------- |
| **user (u)**  | The owner of the file (usually the creator) |
| **group (g)** | A group of users assigned to the file       |
| **other (o)** | Everyone else with access to the system     |

Each category has its own set of permissions:

- `r` = Read
- `w` = Write
- `x` = Execute

---

## 👀 Viewing File Permissions

Use:

```bash
ls -l filename
```

Example output:

```
-rw-r--r-- 1 theia users 25 Dec 22 17:47 my_new_file
```

- `-`: Indicates it's a regular file
- `rw-`: User (owner) permissions
- `r--`: Group permissions
- `r--`: Others' permissions

📘 For directories:

- `d` at the start indicates it's a directory
- Permissions mean:
  - `r`: Can list contents (`ls`)
  - `w`: Can create or delete files inside
  - `x`: Can enter the directory (`cd`)

---

## 🔧 Changing File Permissions with `chmod`

You can change permissions using:

```bash
chmod [options] filename
```

### Example: Make a file private

```bash
chmod go-r my_new_file
```

This removes **read** permission for **group** and **others**.

After running:

```bash
ls -l my_new_file
```

You'll see:

```
-rw------- 1 theia users 24 Dec 22 18:49 my_new_file
```

Now only the **owner** can read and write to the file.

> ⚠️ Only the **owner** or **root** can change permissions on a file.

---

## 🛠️ Common `chmod` Syntax Options

| Command               | Action                                       |
| --------------------- | -------------------------------------------- |
| `chmod u+x file.sh`   | Add execute permission for the user          |
| `chmod go-w file.txt` | Remove write permission for group and others |
| `chmod 755 file.sh`   | Set numeric permissions (see below)          |

### Numeric Permission Notation

Each permission level has a number value:

- `r` = 4
- `w` = 2
- `x` = 1

Sum them to get numeric values:

| Permission | Value |
| ---------- | ----- |
| `rwx`      | 7     |
| `rw-`      | 6     |
| `r-x`      | 5     |
| `r--`      | 4     |

Example:

```bash
chmod 600 secret.txt
```

Only the owner has **read and write** access.

---

## 📁 Executable Files and Shell Scripts

To make a shell script executable:

1. Add a **shebang** line at the top:
   ```bash
   #!/bin/bash
   ```
2. Give it execute permission:
   ```bash
   chmod +x script.sh
   ```
3. Run it:
   ```bash
   ./script.sh
   ```

This tells the OS that the file is a program written in Bash (or another interpreter).

---

## ✅ Summary Table

| Concept                | Description                                    |
| ---------------------- | ---------------------------------------------- |
| **User (u)**           | Owner of the file                              |
| **Group (g)**          | Group of users who share ownership             |
| **Other (o)**          | All other users                                |
| **Permissions**        | `r` = read, `w` = write, `x` = execute         |
| **View Permissions**   | `ls -l`                                        |
| **Change Permissions** | `chmod`                                        |
| **Make Private**       | `chmod go-rwx filename`                        |
| **Numeric Mode**       | `chmod 600 filename`                           |
| **Directories**        | `r` = list, `w` = modify contents, `x` = enter |

---

## 💡 Pro Tips

- Use `chmod 700 folder` to keep a directory private
- Protect sensitive scripts with `chmod 600 script.sh`
- Use `id` to see what groups you belong to
- Use `chown` (as root) to change file ownership

---

You're now equipped with the knowledge to **secure your files**, **control access**, and **protect sensitive data** in a Linux environment.

---

### 🛠️ Exercise 1 - Viewing and Modifying File Access Permissions

In this exercise, you learned how to **view** and **modify file permissions** in Linux using the `ls -l` and `chmod` commands. Understanding and managing permissions is essential for maintaining system security and controlling access to your files.

---

## 📁 1.1 View File Access Permissions

### 🔧 Steps:

1. Navigate to your project directory:

   ```bash
   cd /home/project
   ```

2. Download the required file:

   ```bash
   wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/module%201/usdoi.txt
   ```

3. View the file's permissions:
   ```bash
   ls -l usdoi.txt
   ```

### ✅ Sample Output:

```
-rw-r--r-- 1 theia theia 8121 May 31 16:45 usdoi.txt
```

### 📝 Breakdown of Permission String: `-rw-r--r--`

| Part  | Meaning                                       |
| ----- | --------------------------------------------- |
| `-`   | It's a regular file (use `d` for directories) |
| `rw-` | User (owner) has **read** and **write**       |
| `r--` | Group has only **read**                       |
| `r--` | Others have only **read**                     |

---

## 🔐 1.2 Change File Access Permissions with `chmod`

The `chmod` command allows you to modify who can **read**, **write**, or **execute** a file.

### 🔧 Syntax:

```bash
chmod [who][operator][permission] filename
```

| Component    | Values                                           |
| ------------ | ------------------------------------------------ |
| `who`        | `u` = user, `g` = group, `o` = others, `a` = all |
| `operator`   | `+` = add, `-` = remove, `=` = set exactly       |
| `permission` | `r` = read, `w` = write, `x` = execute           |

---

### 🔍 Example Commands

#### ❌ Remove read permission for all users:

```bash
chmod -r usdoi.txt
```

Verify:

```bash
ls -l usdoi.txt
```

You'll see something like:

```
--w------- 1 theia theia 8121 May 31 16:45 usdoi.txt
```

#### ✅ Restore read permission for all users:

```bash
chmod +r usdoi.txt
```

Verify:

```bash
ls -l usdoi.txt
```

You should return to:

```
-rw-r--r-- 1 theia theia 8121 May 31 16:45 usdoi.txt
```

#### 🚫 Remove read permission only for "other":

```bash
chmod o-r usdoi.txt
```

Verify:

```bash
ls -l usdoi.txt
```

Now output will be:

```
-rw-r----- 1 theia theia 8121 May 31 16:45 usdoi.txt
```

Only **user** and **group** can read the file now.

---

## 🧠 Summary Table

| Task                                    | Command              |
| --------------------------------------- | -------------------- |
| View file permissions                   | `ls -l filename`     |
| Remove read from all                    | `chmod -r filename`  |
| Add read to all                         | `chmod +r filename`  |
| Remove read from others                 | `chmod o-r filename` |
| Add execute to user                     | `chmod u+x filename` |
| Set exact permissions (e.g., rw-------) | `chmod 600 filename` |

---

## 💡 Pro Tips

- Use **numeric mode** for precision:
  ```bash
  chmod 644 usdoi.txt    # rw-r--r--
  chmod 700 secret.sh     # rwx------
  ```
- Always double-check permissions on sensitive files:
  ```bash
  ls -l secret.txt
  ```
- Only the **file owner** or **root** can change permissions.

---

Great job completing this exercise! You're now able to view and manage file permissions — an essential skill for working securely in Linux.

---

### 📁 Exercise 2 - Understanding Directory Access Permissions

In this exercise, you explored how **directory permissions** in Linux work and how they differ from file permissions. You learned that **execute (`x`) permission is required to enter a directory**, and **write (`w`) permission is needed to create or delete files inside it**.

---

## 🔍 Summary of What You Learned

| Permission    | Meaning for Directories                  |
| ------------- | ---------------------------------------- |
| `r` (read)    | Allows listing contents with `ls`        |
| `w` (write)   | Allows adding/removing files             |
| `x` (execute) | Allows entering the directory using `cd` |

> ⚠️ Even if you have write access, you can't modify contents without execute permission!

---

## 🧾 Step-by-Step Breakdown

### 🔹 2.1 View Default Directory Access Permissions

#### Create a new directory:

```bash
cd /home/project
mkdir test
```

#### Check its permissions:

```bash
ls -l
```

Output example:

```
drwxr-sr-x 2 theia users 4096 May 15 14:06 test
```

- `d`: Indicates it's a directory
- `rwx`: Owner (user) has read, write, and execute
- `r-s`: Group has read and setgid (special permission)
- `r-x`: Others have read and execute

You verified that:

- You could enter the directory
- You could create a subdirectory inside it

Commands used:

```bash
cd test
mkdir test2
cd ..
```

> 💡 The `s` in group permissions is a special flag called **setgid** — it ensures new files inherit the group of the parent directory.

---

### 🔹 2.2 Remove User Execute Permissions

#### Remove execute permission for owner:

```bash
chmod u-x test
```

Now try:

```bash
cd test
```

❌ Output:

```
bash: cd: test: Permission denied
```

Even though you still have read and write permissions, **you can't enter the directory** without execute permission.

Try listing contents:

```bash
ls -l test
```

✅ Works — because you still have **read** permission.

Try creating a subdirectory:

```bash
mkdir test/test3
```

❌ Fails — because **write requires execute**.

---

### 🔁 Restore Permissions

#### Add back execute:

```bash
chmod u+x test
```

#### Remove write:

```bash
chmod u-w test
```

Check current permissions:

```bash
ls -l
```

Now try:

```bash
cd test
mkdir test_again
```

❌ Output:

```
mkdir: cannot create directory ‘test_again’: Permission denied
```

You can **enter** the directory (thanks to `x`), but you **can't modify** it (because you don’t have `w`).

---

## 🧠 Key Takeaways

| Scenario               | Required Permission                             |
| ---------------------- | ----------------------------------------------- |
| List contents (`ls`)   | `r`                                             |
| Enter directory (`cd`) | `x`                                             |
| Create/delete files    | `w` + `x`                                       |
| Rename or move files   | `w` + `x` in both source and target directories |

> 🧩 Think of `x` as a key to open a door — you need it before you can do anything useful inside a directory.

---

## ✅ Summary Table

| Command            | Effect                                                    |
| ------------------ | --------------------------------------------------------- |
| `ls -l`            | Show directory permissions                                |
| `chmod u+x dir`    | Allow user to enter directory                             |
| `chmod u-w dir`    | Prevent user from modifying directory contents            |
| `cd dir`           | Requires execute (`x`) permission                         |
| `ls dir`           | Requires read (`r`) permission                            |
| `mkdir dir/subdir` | Requires write (`w`) + execute (`x`) permissions on `dir` |

---

You've now mastered how **directory permissions** control access differently than file permissions — an essential concept for securing and managing your Linux system effectively.

---

### 🛠️ **Practice Exercises – File and Directory Permissions**

Here are the **practice exercises** with hints and full solutions to help you reinforce your understanding of Linux file and directory permissions.

---

## 🔹 **1. List the permissions set for the file `usdoi.txt`**

### 💡 Hint:

Use the `ls -l` command to view file permissions.

### ✅ Solution:

```bash
ls -l usdoi.txt
```

Example output:

```
-rw-r--r-- 1 theia users 8121 May 31 16:45 usdoi.txt
```

This shows that:

- The owner has **read and write**
- The group has **read**
- Others have **read**

---

## 🔹 **2. Revoke the write permission on `usdoi.txt` for the user, and verify**

### 💡 Hint:

Use `chmod u-w` to remove write access for the user.

### ✅ Solution:

```bash
chmod u-w usdoi.txt
ls -l usdoi.txt
```

New output:

```
-r--r--r-- 1 theia users 8121 May 31 16:45 usdoi.txt
```

The user (owner) no longer has **write** permission.

---

## 🔹 **3. What happens if you try to delete `usdoi.txt` after revoking write permissions?**

### 💡 Hint:

You don’t need write permission to delete a file — but you **do** need write permission in the **directory** it’s in.

### ✅ Solution:

Try deleting:

```bash
rm usdoi.txt
```

✅ It works!  
Even though you removed write permission **on the file**, you can still delete it because:

- You own the file
- You have **write permission in the directory**

> 🔍 Note: If you didn’t own the file, you could still delete it as long as:
>
> - You had **write** permission in the directory
> - You didn't own the file

---

## 🔹 **4. Create a new directory called `tmp_dir` in your home directory**

### 💡 Hint:

Use the `mkdir` command.

### ✅ Solution:

```bash
cd ~
mkdir tmp_dir
```

Now you have a new directory in your home folder.

---

## 🔹 **5. View the permissions of the newly created directory `tmp_dir`**

### 💡 Hint:

Use `ls -l` again to see directory permissions.

### ✅ Solution:

```bash
ls -l
```

Output will include something like:

```
drwxr-xr-x 2 theia users 4096 Apr 5 10:00 tmp_dir
```

This means:

- User: read, write, execute
- Group: read, execute
- Others: read, execute

---

## 🔹 **6. Revoke the user write permission for `tmp_dir`**

### 💡 Hint:

Use `chmod u-w` on the directory.

### ✅ Solution:

```bash
chmod u-w tmp_dir
ls -l
```

New output:

```
dr-xr-xr-x 2 theia users 4096 Apr 5 10:00 tmp_dir
```

User now only has **execute** and **read** — not **write**.

---

## 🔹 **7. Check whether you can create a subdirectory `sub_dir` inside `tmp_dir`**

### 💡 Hint:

Use `mkdir` to attempt creating a subdirectory.

### ✅ Solution 1:

```bash
mkdir tmp_dir/sub_dir
```

❌ Output:

```
mkdir: cannot create directory ‘tmp_dir/sub_dir’: Permission denied
```

### ✅ Solution 2 Explanation:

Even though you have **execute** (`x`) permission on `tmp_dir`, which allows you to **enter** the directory, you **don’t have write** (`w`) permission — so you **can't modify** its contents (like creating or deleting files or directories).

---

## 🧠 Summary Table

| Task                        | Command                                            |
| --------------------------- | -------------------------------------------------- |
| View file permissions       | `ls -l filename`                                   |
| Remove write from user      | `chmod u-w filename`                               |
| Delete a file               | `rm filename` _(requires write in directory)_      |
| Create a directory          | `mkdir dirname`                                    |
| View directory permissions  | `ls -l`                                            |
| Remove write from directory | `chmod u-w dirname`                                |
| Create subdirectory         | `mkdir dirname/subdir` _(fails without `w` + `x`)_ |

---

Great job working through these permission exercises! You're building strong skills in managing **file access control**, **user permissions**, and **directory behavior** in Linux.

---

# **Viewing File Content in Linux**

---

## **1. Introduction**

✅ Displaying full or partial contents of a file  
✅ Navigating large files page-by-page  
✅ Counting lines, words, and characters

These tools are especially useful when working with log files, scripts, configuration files, and other text-based data.

---

## **2. Commands to View File Contents**

### **A. `cat` – Concatenate and Print Entire File**

- **Purpose**: Print the entire contents of a file to the terminal.
- **Syntax**:

  ```bash
  cat <filename>
  ```

- **Example**:
  ```bash
  cat numbers.txt
  ```

> Outputs all lines from the file `numbers.txt`, from line 0 to 99 in this example.

- **Use Cases**:
  - Small files that fit on one screen.
  - Combining multiple files into one (e.g., `cat file1 file2 > combined.txt`)

> ⚠️ Not ideal for long files — output may scroll off-screen quickly.

---

### **B. `more` – View File One Page at a Time**

- **Purpose**: Scroll through a file page by page.
- **Syntax**:

  ```bash
  more <filename>
  ```

- **Example**:

  ```bash
  more numbers.txt
  ```

- **Navigation Keys**:
  - Press **Spacebar** to go to the next page.
  - Press **Enter** to scroll one line at a time.
  - Press **q** to quit and return to the command prompt.

> Ideal for reading long files without overwhelming the terminal.

---

### **C. `head` – View First Few Lines of a File**

- **Purpose**: Show the beginning portion of a file.
- **Syntax**:

  ```bash
  head <filename>
  ```

- **Default Behavior**:

  - Displays **first 10 lines** of the file.

- **Example**:

  ```bash
  head numbers.txt
  ```

  > Shows lines 0–9

- **Custom Line Count**:
  ```bash
  head -n 3 numbers.txt
  ```
  > Shows first 3 lines: 0, 1, 2

> Useful for checking headers, logs, or sample data quickly.

---

### **D. `tail` – View Last Few Lines of a File**

- **Purpose**: Show the end portion of a file.
- **Syntax**:

  ```bash
  tail <filename>
  ```

- **Default Behavior**:

  - Displays **last 10 lines** of the file.

- **Example**:

  ```bash
  tail numbers.txt
  ```

  > Shows lines 90–99

- **Custom Line Count**:

  ```bash
  tail -n 3 numbers.txt
  ```

  > Shows last 3 lines: 97, 98, 99

- **Real-world Use**:
  - Monitoring log files in real-time using:
    ```bash
    tail -f /var/log/syslog
    ```

---

## **3. Command to Analyze File Content: `wc`**

### **A. `wc` – Word Count**

- **Purpose**: Count **lines**, **words**, and **bytes (characters)** in a file.
- **Syntax**:

  ```bash
  wc <filename>
  ```

- **Example**:
  ```bash
  wc pets.txt
  ```

> Output:

```
7 7 28 pets.txt
```

- **Meaning**:
  - **7 lines**
  - **7 words**
  - **28 characters** (including newline characters)

> The character count is higher than expected because `wc` counts **newline characters** (`\n`) as well.

---

### **B. Options for Specific Counts**

| Option | Description                                | Example                          |
| ------ | ------------------------------------------ | -------------------------------- |
| `-l`   | Count only lines                           | `wc -l pets.txt` → `7 pets.txt`  |
| `-w`   | Count only words                           | `wc -w pets.txt` → `7 pets.txt`  |
| `-c`   | Count only characters (including newlines) | `wc -c pets.txt` → `28 pets.txt` |

> These options let you extract specific metrics without extra parsing.

---

## **4. Summary Table**

| Command     | Purpose                   | Example                 | Output Sample          |
| ----------- | ------------------------- | ----------------------- | ---------------------- |
| `cat`       | View entire file          | `cat numbers.txt`       | All lines from 0 to 99 |
| `more`      | View file page-by-page    | `more numbers.txt`      | Scrollable output      |
| `head`      | View first 10 lines       | `head numbers.txt`      | Lines 0–9              |
| `head -n X` | View first X lines        | `head -n 3 numbers.txt` | Lines 0–2              |
| `tail`      | View last 10 lines        | `tail numbers.txt`      | Lines 90–99            |
| `tail -n X` | View last X lines         | `tail -n 3 numbers.txt` | Lines 97–99            |
| `wc`        | Count lines, words, chars | `wc pets.txt`           | `7 7 28 pets.txt`      |
| `wc -l`     | Count only lines          | `wc -l pets.txt`        | `7 pets.txt`           |
| `wc -w`     | Count only words          | `wc -w pets.txt`        | `7 pets.txt`           |
| `wc -c`     | Count only characters     | `wc -c pets.txt`        | `28 pets.txt`          |

---

## **5. Final Tips**

- Use `cat` for small files or quick inspection.
- Use `more` for navigating larger files interactively.
- Use `head` and `tail` to inspect the start or end of a file efficiently.
- Use `wc` to get statistical information about your file’s content.
- Combine these commands with pipes (`|`) for advanced analysis:
  ```bash
  cat pets.txt | wc -l
  ```

---

# **Useful Commands for Wrangling Text Files in Linux**

---

## **1. Introduction**

✅ Sorting lines alphabetically  
✅ Removing duplicates  
✅ Searching for patterns  
✅ Extracting parts of lines  
✅ Merging lines from multiple files

These tools are essential for working with log files, CSV data, configuration files, and more.

---

## **2. Sorting File Content: `sort` Command**

### **Purpose**

Sort the lines of a file **alphabetically or numerically**.

### **Basic Syntax**

```bash
sort <filename>
```

### **Examples**

- Sort file alphabetically:

  ```bash
  sort pets.txt
  ```

  Output:

  ```
  cat
  cat
  cat
  cat
  cat
  dog
  dog
  ```

- Sort in reverse order:
  ```bash
  sort -r pets.txt
  ```
  Output:
  ```
  dog
  dog
  cat
  cat
  cat
  cat
  cat
  ```

> Tip: Use `sort -n` for numeric sorting if your file contains numbers.

---

## **3. Removing Duplicate Lines: `uniq` Command**

### **Purpose**

Filter out **consecutive duplicate lines** in a file.

### **Basic Syntax**

```bash
uniq <filename>
```

### **Example**

Given this content in `pets.txt`:

```
cat
dog
dog
cat
```

Running:

```bash
uniq pets.txt
```

Output:

```
cat
dog
cat
```

> Note: `uniq` only removes **duplicates that appear one after another**. To remove all duplicates regardless of position, first use `sort`, then `uniq`:

```bash
sort pets.txt | uniq
```

---

## **4. Searching for Patterns: `grep` Command**

### **Purpose**

Search for lines containing a specific **pattern** (e.g., word, phrase, regular expression).

### **Basic Syntax**

```bash
grep "pattern" <filename>
```

### **Examples**

- Search for lines containing "ch":

  ```bash
  grep "ch" people.txt
  ```

  Output:

  ```
  Dennis Ritchie
  Erwin Schrodinger
  ```

- Case-insensitive search:

  ```bash
  grep -i "ch" people.txt
  ```

  Output:

  ```
  Charles Babbage
  Dennis Ritchie
  Erwin Schrodinger
  ```

> `grep` supports regular expressions for advanced searches:

```bash
grep "^C" people.txt   # Find names starting with 'C'
```

---

## **5. Extracting Parts of Lines: `cut` Command**

### **Purpose**

Extract specific **characters or fields** from each line of a file.

### **Basic Syntax**

```bash
cut [options] <filename>
```

### **A. Character-Based Extraction**

- Extract characters 2 through 9:

  ```bash
  cut -c2-9 people.txt
  ```

  Example Input:

  ```
  Alan Turing
  Charles Babbage
  ```

  Output:

  ```
  lan Turin
  harles B
  ```

### **B. Field-Based Extraction**

Use `-d` to define a delimiter and `-f` to select a field.

- Extract last names (second field) from a space-separated file:

  ```bash
  cut -d' ' -f2 people.txt
  ```

  Output:

  ```
  Turing
  Babbage
  ```

> You can also extract multiple fields:

```bash
cut -d',' -f1,3 csvfile.csv
```

---

## **6. Merging Lines from Multiple Files: `paste` Command**

### **Purpose**

Combine lines from multiple files **side by side**, similar to columns in a table.

### **Basic Syntax**

```bash
paste <file1> <file2> <file3>
```

### **Example**

You have three files:

- `first.txt`:

  ```
  Alan
  Charles
  Dennis
  ```

- `last.txt`:

  ```
  Turing
  Babbage
  Ritchie
  ```

- `yob.txt`:
  ```
  1912
  1791
  1941
  ```

Run:

```bash
paste first.txt last.txt yob.txt
```

Output:

```
Alan    Turing    1912
Charles Babbage   1791
Dennis  Ritchie   1941
```

> By default, `paste` uses **tab** as the delimiter.

### **Custom Delimiter**

To use a comma instead:

```bash
paste -d',' first.txt last.txt yob.txt
```

Output:

```
Alan,Turing,1912
Charles,Babbage,1791
Dennis,Ritchie,1941
```

---

## **7. Summary Table**

| Command          | Purpose                                       | Example                                  |
| ---------------- | --------------------------------------------- | ---------------------------------------- |
| `sort`           | Sort lines alphabetically/numerically         | `sort pets.txt`                          |
| `sort -r`        | Reverse sort                                  | `sort -r pets.txt`                       |
| `uniq`           | Remove consecutive duplicate lines            | `uniq pets.txt`                          |
| `grep "pattern"` | Print lines matching a pattern                | `grep "ch" people.txt`                   |
| `grep -i`        | Case-insensitive search                       | `grep -i "ch" people.txt`                |
| `cut -cX-Y`      | Extract characters from X to Y                | `cut -c2-9 people.txt`                   |
| `cut -d' ' -f2`  | Extract second field using space as delimiter | `cut -d' ' -f2 people.txt`               |
| `paste`          | Merge lines from multiple files               | `paste first.txt last.txt yob.txt`       |
| `paste -d','`    | Merge with custom delimiter                   | `paste -d',' first.txt last.txt yob.txt` |

---

## **8. Final Tips**

- Combine commands using pipes (`|`) for powerful workflows:
  ```bash
  sort pets.txt | uniq
  ```
- Use `grep` with wildcards or regex for flexible searching.
- `cut` is great for parsing structured text like CSV or logs.
- `paste` helps you create reports or combine related datasets.

---

# 📄 Exercise 1 - Viewing File Contents with `cat`, `more`, and `less`

In this exercise, you learned how to **view and navigate file contents** in the terminal using three essential Linux commands:

- `cat` – for quick viewing and concatenation
- `more` – for basic scrolling through a file
- `less` – for advanced navigation (forward and backward)

These tools are especially useful when working with shell scripts, logs, configuration files, and other text-based data.

---

## 🔧 Step-by-Step Breakdown

### 🏁 Start by navigating to your home directory:

```bash
cd ~
```

### 🔍 Check what files exist:

```bash
ls
```

You should see a file named `entrypoint.sh`. `.sh` is the extension used for **shell scripts**, which are executable text files that contain Bash commands.

---

## ✅ 1.1 View File Content with `cat`

### Command:

```bash
cat entrypoint.sh
```

### What It Does:

- Displays the **entire contents** of the file at once
- Stops at the end and returns to the command prompt

> ⚠️ If the file is longer than your terminal window, you’ll only see the last part — it scrolls past too quickly to read everything.

### 💡 Use Cases:

- Quick inspection of small files
- Concatenating multiple files:
  ```bash
  cat file1.txt file2.txt > combined.txt
  ```

---

## ✅ 1.2 View File Content with `more`

### Command:

```bash
more entrypoint.sh
```

### What It Does:

- Shows one screen of text at a time
- Press **Spacebar** to go to the next page
- Type **q** to quit

### 🔍 Useful Info:

The first line:

```bash
#!/bin/bash
```

is called a **shebang** — it tells the system to use `/bin/bash` to interpret the script.

> 📌 You’ll learn more about writing shell scripts later in the course.

### 💡 Use Cases:

- Reading medium-sized files
- Viewing logs or configuration files from the command line

---

## ✅ 1.3 Scroll Through File Content with `less`

### Command:

```bash
less entrypoint.sh
```

### What It Does:

- Displays one screen of content
- Allows **scrolling forward and backward**
  - **↑ / ↓** keys: scroll line by line
  - **Page Up / Page Down**: scroll page by page
- Press **q** to exit

### 🆕 Why `less` Is Better Than `more`:

- You can move **up and down**, not just down
- You can search inside the file with `/search_term`
- It doesn’t automatically quit at the end

---

## 📋 Summary Table

| Command | Scrolling Direction   | Interactive | Exits Automatically | Best For                  |
| ------- | --------------------- | ----------- | ------------------- | ------------------------- |
| `cat`   | All at once           | No          | Yes                 | Small files, scripting    |
| `more`  | Forward only          | Limited     | Yes                 | Paging through files      |
| `less`  | Both forward/backward | Full        | No                  | Detailed inspection, logs |

---

## 🧠 Tips & Tricks

- Combine with pipes to view output:
  ```bash
  ls -l /etc | less
  ```
- Search inside `less`:
  - Type `/pattern` then press Enter
  - Press `n` to find next match
- Exit early: always press `q` to quit

---

Great job completing this exercise! You now know how to choose the best tool depending on the size and complexity of the file you're viewing.

---

# 📄 Exercise 2 - Viewing Text File Contents

## Using `head` and `tail` to View File Content

In this exercise, you learned how to **inspect specific parts of a text file** using two powerful Linux commands:

- `head` – to view the **beginning** of a file
- `tail` – to view the **end** of a file

These tools are especially useful for:

- Reading large log files
- Monitoring real-time updates (with `tail -f`)
- Extracting headers or footers from data files

---

## 🧾 Step-by-Step Instructions

### 🔧 Download and Navigate to Your Project Directory:

```bash
cd /home/project
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt
```

Verify the file was downloaded:

```bash
ls
```

You should see `usdoi.txt` listed.

---

## ✅ 2.1 Display the First N Lines with `head`

### Show the first 10 lines (default):

```bash
head usdoi.txt
```

This is helpful when viewing large documents like logs or configuration files where the most important info may be at the top.

### Show only the first 3 lines:

```bash
head -3 usdoi.txt
```

Example output:

```
When in the Course of human events, it becomes necessary for one people to dissolve the political bands which have connected them with another...
```

> 💡 Use `head` to quickly preview files without opening the entire contents.

---

## ✅ 2.2 Display the Last N Lines with `tail`

### Show the last 10 lines (default):

```bash
tail usdoi.txt
```

Useful for checking the end of logs or files where recent changes are appended.

### Show only the last 2 lines:

```bash
tail -2 usdoi.txt
```

Example output:

```
...and that government of the people, by the people, for the people shall not perish from the earth.
```

> 🚀 Pro Tip: Use `tail -f` to follow a log file in real time:

```bash
tail -f /var/log/syslog
```

---

## 📋 Summary Table

| Command   | Description                            | Example                   |
| --------- | -------------------------------------- | ------------------------- |
| `head`    | Displays the first 10 lines of a file  | `head filename`           |
| `head -N` | Displays the first N lines             | `head -3 filename`        |
| `tail`    | Displays the last 10 lines of a file   | `tail filename`           |
| `tail -N` | Displays the last N lines              | `tail -2 filename`        |
| `tail -f` | Follows the end of a file in real time | `tail -f /var/log/syslog` |

---

## 🧠 Why These Commands Matter

- **Efficiency**: Avoid opening huge files just to check the start or end.
- **Monitoring**: Track live updates in log files using `tail -f`.
- **Automation**: Use in scripts to extract key information from files.

---

## Great work! You now know how to **quickly inspect large text files**, which is essential for system administration, scripting, and data analysis.

---

# 📊 Exercise 3 - Getting Basic Text File Stats with `wc`

In this exercise, you learned how to use the **`wc`** (word count) command to get basic statistics about a text file — including the number of **lines**, **words**, and **characters**.

This is especially useful when:

- You're analyzing large text files
- You need to verify file contents before processing
- You're writing scripts that depend on file size or structure

---

## 🔧 Step-by-Step Breakdown

### Start by navigating to your project directory and using `wc`:

```bash
cd /home/project
wc usdoi.txt
```

### Example Output:

```
     21     268    1654 usdoi.txt
```

The output shows:

1. Number of **lines**
2. Number of **words**
3. Number of **characters**
4. File name

---

## ✅ View Specific Stats

### 🔢 Count Lines Only:

```bash
wc -l usdoi.txt
```

Useful for checking how many entries are in a list or log file.

---

### 📝 Count Words Only:

```bash
wc -w usdoi.txt
```

Great for content analysis or verifying document length.

---

### 🔤 Count Characters Only:

```bash
wc -c usdoi.txt
```

Tells you the total byte size of the file — useful for storage and transmission planning.

> 💡 Note: `wc -c` counts bytes, not just visible characters — so whitespace and punctuation are included.

---

## 📋 Summary Table

| Command          | Output                       |
| ---------------- | ---------------------------- |
| `wc filename`    | Lines, words, characters     |
| `wc -l filename` | Number of lines              |
| `wc -w filename` | Number of words              |
| `wc -c filename` | Number of bytes (characters) |

---

## 🧠 Why `wc` Is Useful

- **Automation**: Use in scripts to validate input data size
- **Analysis**: Get quick stats without opening the file
- **Debugging**: Check if a file has expected content structure

---

## You're doing great! With these tools, you can now **analyze text files efficiently** and extract meaningful insights from their content.

# 🧹 Exercise 4 - Basic Text Wrangling: Sorting Lines and Dropping Duplicates

In this exercise, you learned how to **clean up and organize text data** using two powerful Linux utilities:

- `sort` – to **alphabetically or numerically sort lines**
- `uniq` – to **remove consecutive duplicate lines**

These tools are essential for:

- Data cleaning
- Log file analysis
- Preparing input for scripts
- Removing redundant output

---

## 🔧 Step-by-Step Breakdown

### ✅ 4.1 Sort Lines Alphanumerically with `sort`

#### Display the lines of `usdoi.txt` sorted alphanumerically:

```bash
sort usdoi.txt
```

This command rearranges all the lines in alphabetical order (A–Z), making it easier to scan or analyze content.

#### Sort in reverse order (Z–A):

```bash
sort -r usdoi.txt
```

> 💡 This is useful when you want to see the "end" of an alphabetized list first — like viewing the latest entries in a log.

---

### ✅ 4.2 Remove Consecutive Duplicate Lines with `uniq`

#### First, download a new file:

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/module%201/zoo.txt
```

#### View the contents:

```bash
cat zoo.txt
```

You’ll notice some repeated animal names, especially `zebra`.

#### Remove **consecutive duplicates**:

```bash
uniq zoo.txt
```

This removes only lines that appear **one after another**, so:

```
zebra
zebra
lion
tiger
zebra
```

Becomes:

```
zebra
lion
tiger
zebra
```

Only the **first two zebras** are removed as duplicates — the last one stays because it's not directly after another zebra.

---

## 📋 Summary Table

| Command            | Description                            |
| ------------------ | -------------------------------------- | -------------------------------------------- |
| `sort filename`    | Sort lines alphabetically              |
| `sort -r filename` | Sort lines in reverse order            |
| `uniq filename`    | Remove **consecutive** duplicate lines |
| `sort file         | uniq`                                  | Sort then remove all duplicates (if grouped) |

---

## 🧠 Pro Tips

- To remove **all duplicate lines** regardless of order:

  ```bash
  sort zoo.txt | uniq
  ```

- Count how many times each line appears:

  ```bash
  sort zoo.txt | uniq -c
  ```

- Show only lines that appear **more than once**:

  ```bash
  sort zoo.txt | uniq -d
  ```

- Show only lines that appear **exactly once**:
  ```bash
  sort zoo.txt | uniq -u
  ```

---

## 🛠️ Real-World Use Cases

| Task                              | Command                      |
| --------------------------------- | ---------------------------- | ------------------------ | -------- | -------- | ----------- |
| Clean up a messy list of emails   | `sort emails.txt             | uniq > clean_emails.txt` |
| Count unique IP addresses in logs | `cut -d' ' -f1 access.log    | sort                     | uniq -c` |
| Find most frequently visited URLs | `awk '{print $7}' access.log | sort                     | uniq -c  | sort -nr | head -n 10` |

---

## Great job mastering these basic but powerful text processing tools! You're now equipped to **organize**, **clean**, and **analyze** textual data efficiently in Linux.

# 🧩 Exercise 5 - Basic Text Wrangling: Extracting Lines and Fields

In this exercise, you learned how to **filter lines** using patterns with `grep` and **extract specific parts of text** using the `cut` command.

These tools are essential for:

- Searching through logs
- Filtering data
- Processing structured files like CSVs
- Automating repetitive tasks in scripts

---

## 🔍 Step-by-Step Breakdown

### ✅ 5.1 Extract Lines Matching a Pattern with `grep`

#### Print all lines containing the word "people":

```bash
grep people usdoi.txt
```

This shows only the lines where the word `people` appears.

#### Print matching lines along with line numbers:

```bash
grep -n people usdoi.txt
```

#### Count how many lines contain the pattern:

```bash
grep -c people usdoi.txt
```

#### Ignore case (match both "People" and "people"):

```bash
grep -i people usdoi.txt
```

#### Show lines that **do not** contain the pattern:

```bash
grep -v login /etc/passwd
```

Useful for filtering out system-generated accounts from `/etc/passwd`.

#### Match only whole words:

```bash
grep -w people usdoi.txt
```

Prevents partial matches like `peoples` or `unpeople`.

---

### ✅ 5.2 Extract Fields from Lines Using `cut`

#### View first two characters of each line in `zoo.txt`:

```bash
cut -c -2 zoo.txt
```

#### View text starting from the second character:

```bash
cut -c 2- zoo.txt
```

> These options extract by **character position**, useful for fixed-width formats.

---

### 📥 Work with Delimited Files (e.g., CSV)

#### Download and view the file:

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/v4_new_content/labs/names_and_numbers.csv
cat names_and_numbers.csv
```

Sample content:

```
Name,Phone
Alice,555-1234
Bob,555-5678
Charlie,555-9012
```

#### Extract just the phone numbers (second field):

```bash
cut -d "," -f2 names_and_numbers.csv
```

- `-d ","` tells `cut` to split on commas
- `-f2` tells it to return the second field

Output:

```
Phone
555-1234
555-5678
555-9012
```

You can also extract multiple fields:

```bash
cut -d "," -f1,3 names_and_numbers.csv
```

Returns fields 1 and 3 — useful when skipping unnecessary columns.

---

## 📋 Summary Table

| Task                           | Command                                |
| ------------------------------ | -------------------------------------- |
| Find lines containing a word   | `grep pattern file`                    |
| Show line numbers              | `grep -n pattern file`                 |
| Count matches                  | `grep -c pattern file`                 |
| Case-insensitive search        | `grep -i pattern file`                 |
| Invert match (not containing)  | `grep -v pattern file`                 |
| Match whole word only          | `grep -w pattern file`                 |
| Extract characters by position | `cut -c START-END file`                |
| Extract fields by delimiter    | `cut -d "DELIM" -f FIELD_NUMBERS file` |

---

## 🧠 Why These Tools Matter

| Tool   | Use Case                                                       |
| ------ | -------------------------------------------------------------- |
| `grep` | Search, filter, and count patterns in text                     |
| `cut`  | Extract specific parts of text based on position or delimiters |

They're often used together in pipelines:

```bash
grep "New York" contacts.csv | cut -d "," -f2
```

This finds all entries for New York and extracts their phone numbers.

---

# 🧩 Exercise 6 - Basic Text Wrangling: Merging Lines as Fields

In this exercise, you learned how to use the **`paste`** command to **merge lines from multiple files side-by-side**, like combining columns in a spreadsheet.

This is especially useful when:

- You're working with related data stored in separate files
- You want to align rows for analysis or reporting
- You need to build structured output from flat files

---

## 🔧 Step-by-Step Breakdown

### ✅ Download an additional file:

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/module%201/zoo_ages.txt
```

You already have `zoo.txt`, which contains animal names. Now `zoo_ages.txt` has corresponding age data.

### ✅ Merge both files line-by-line using `paste`:

```bash
paste zoo.txt zoo_ages.txt
```

By default, `paste` uses a **Tab (`\t`)** character to separate merged fields.

Example Output:

```
lion	5
tiger	4
zebra	6
elephant	10
```

This makes it easy to combine related data into a single view.

---

### ✅ Change the Delimiter to Comma (`,`) for CSV-like Output:

```bash
paste -d "," zoo.txt zoo_ages.txt
```

Now the output looks like:

```
lion,5
tiger,4
zebra,6
elephant,10
```

> 💡 This is useful for creating CSV files or preparing data for scripts and databases.

You can also use other delimiters like space, colon, or semicolon:

```bash
paste -d " " zoo.txt zoo_ages.txt   # Space
paste -d ":" zoo.txt zoo_ages.txt  # Colon
```

---

## 📋 Summary Table

| Command                                 | Description                                      |
| --------------------------------------- | ------------------------------------------------ |
| `paste file1 file2`                     | Merge two files line-by-line using Tab delimiter |
| `paste -d "," file1 file2`              | Merge using comma as delimiter                   |
| `paste -s file.txt`                     | Paste all lines of a file into one line          |
| `paste -d ":" file1 file2 > merged.csv` | Save merged output to a new file                 |

---

## 🧠 Why `paste` Is Useful

| Use Case                            | Example                                        |
| ----------------------------------- | ---------------------------------------------- |
| Combine logs from different sources | `paste access.log user_agents.log`             |
| Build CSV files from parallel data  | `paste -d "," names.csv ages.csv > people.csv` |
| Align configuration values          | Match hostnames with IPs                       |
| Create input for scripts            | Generate formatted input for another tool      |

---

## 🛠️ Try It Out – Real-World Examples

#### Combine Names and Ages into One File:

```bash
paste -d "," zoo.txt zoo_ages.txt > animals.csv
```

Creates a new file `animals.csv` that's ready for import into Excel or a database.

#### Merge Multiple Files:

```bash
paste names.txt emails.txt phones.txt
```

Merges three files — one per column — ideal for building contact lists.

---

# 🛠️ **Practice Exercises – Text Processing in Linux**

These hands-on exercises help reinforce your knowledge of **file inspection**, **searching**, and **text manipulation** using essential Linux commands like `wc`, `grep`, `head`, `tail`, `cut`, and more.

---

## 🔧 Before You Begin

Make sure you're in your home directory:

```bash
cd ~
pwd
```

---

## 📝 Practice Exercise Solutions

### 1. **Display the number of lines in `/etc/passwd`**

#### ✅ Solution:

```bash
wc -l /etc/passwd
```

This shows how many user accounts exist on the system (each line in `/etc/passwd` represents a user).

---

### 2. **Display lines containing "not installed" in `/var/log/bootstrap.log`**

#### ✅ Solution:

```bash
grep "not installed" /var/log/bootstrap.log
```

This helps identify packages or services that failed to install during system boot.

---

### 3. **Find websites with "org" in them from `top-sites.txt`**

#### First, download the file:

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/top-sites.txt
```

#### ✅ Use `grep` to search for "org":

```bash
grep "org" top-sites.txt
```

This lists all URLs or domains that include "org".

#### 🔄 Alternative solution using case-insensitive match:

```bash
grep -i "org" top-sites.txt
```

Useful if you want to catch both "org" and "ORG", etc.

---

### 4. **Print the first 7 lines of `top-sites.txt`**

#### ✅ Solution:

```bash
head -7 top-sites.txt
```

This gives a quick preview of the top sites list.

---

### 5. **Print the last 7 lines of `top-sites.txt`**

#### ✅ Solution:

```bash
tail -7 top-sites.txt
```

Handy when you're interested in newer entries at the end of a list or log file.

---

### 6. **Print the first three characters of each line from `top-sites.txt`**

#### ✅ Solution:

```bash
cut -c -3 top-sites.txt
```

This extracts only the first 3 characters from every line — useful for fixed-width data or codes.

---

### 7. **Extract and view only the names from `names_and_numbers.csv`**

Assuming the file already exists:

```bash
cat names_and_numbers.csv
```

#### ✅ Solution:

```bash
cut -d "," -f1 names_and_numbers.csv
```

- `-d ","` tells `cut` to use comma as the delimiter
- `-f1` selects the **first field** — which is the name column

You can also skip the header if needed:

```bash
tail -n +2 names_and_numbers.csv | cut -d "," -f1
```

---

## 📋 Summary Table: Commands Used

| Task                      | Command                                    |
| ------------------------- | ------------------------------------------ |
| Count lines in a file     | `wc -l filename`                           |
| Search for text in a file | `grep "pattern" filename`                  |
| Print first N lines       | `head -N filename`                         |
| Print last N lines        | `tail -N filename`                         |
| Extract character range   | `cut -c START-END filename`                |
| Extract by delimiter      | `cut -d "DELIM" -f FIELD_NUMBERS filename` |

---

## 🧠 Why These Skills Matter

You now have the tools to:

- **Analyze logs**
- **Filter and extract data**
- **Process CSVs and structured files**
- **Build automation pipelines** using command-line tools

These are foundational skills for scripting, system administration, and data analysis in Linux.

---

## **Exercise 7 – Combining Commands with Pipes and Redirection**

In this exercise, you’ll learn how to:

- Combine multiple Linux commands using **pipes (`|`)**
- Redirect command output to files using `>` and `>>`
- Use input redirection with `<`
- Build powerful **command pipelines** that process data step-by-step

These skills are essential for:

- Automating repetitive tasks
- Processing logs or large datasets
- Writing shell scripts
- Becoming a more efficient Linux user

---

## 🔧 What is Piping?

The **pipe operator (`|`)** takes the **output of one command** and feeds it as **input to another**.

This lets you chain together small tools to build complex operations.

### Example:

```bash
ls -l | grep "Jan" | wc -l
```

This pipeline:

1. Lists all files (`ls -l`)
2. Filters only those modified in January (`grep "Jan"`)
3. Counts them (`wc -l`)

---

## 📥 Input and Output Redirection

You can also control where input comes from and where output goes using:

| Operator | Purpose                                | Example                        |
| -------- | -------------------------------------- | ------------------------------ |
| `>`      | Redirect output to a file (overwrites) | `ls > files.txt`               |
| `>>`     | Append output to a file                | `echo "New line" >> files.txt` |
| `<`      | Redirect input from a file             | `sort < names.txt`             |

### Example:

```bash
grep "error" /var/log/syslog > errors.txt
```

Saves all lines containing "error" from the system log into a new file.

---

## 💡 Hands-On Practice

Let’s go through some guided examples.

### ✅ 1. Chain `grep`, `sort`, and `uniq` to Analyze Log Data

#### Find unique IP addresses in an access log:

```bash
grep "Failed password" /var/log/auth.log | awk '{print $9}' | sort | uniq
```

- `grep`: filters for failed login attempts
- `awk`: extracts the IP address field
- `sort`: prepares for deduplication
- `uniq`: removes duplicates

> You'll learn about `awk` soon — it's a powerful text processing tool.

---

### ✅ 2. Save Command Output to a File

#### Save your list of running processes to a file:

```bash
ps -e > process_list.txt
```

Now view it:

```bash
cat process_list.txt
```

---

### ✅ 3. Count Words in a File Using a Pipeline

#### Count how many times each word appears in `usdoi.txt`:

```bash
tr ' ' '\n' < usdoi.txt | sort | uniq -c | sort -nr
```

What this does:

- `tr ' ' '\n'`: replaces spaces with newlines (puts each word on its own line)
- `sort`: sorts words alphabetically
- `uniq -c`: counts occurrences
- `sort -nr`: sorts numerically in reverse order

---

### ✅ 4. View Command Output One Page at a Time

Sometimes output fills your screen. Use `less` to page through it:

```bash
history | less
```

Use ↑ ↓ keys to scroll, and press `q` to quit.

---

## 📋 Summary Table: Pipes & Redirection

| Task                           | Command               |
| ------------------------------ | --------------------- | --------- |
| Pipe output to another command | `command1             | command2` |
| Redirect output to a file      | `command > file.txt`  |
| Append output to a file        | `command >> file.txt` |
| Read input from a file         | `command < file.txt`  |

---

## 🧠 Why This Matters

With pipes and redirection, you can:

- **Automate workflows** with simple, reusable components
- **Process large amounts of data** efficiently
- **Build custom scripts** that do exactly what you need

---

### 🎉 **Summary – Great Job Completing the Lab!**

You've just gained hands-on experience with some of the most essential **Linux text processing and file inspection tools**. These skills are fundamental for working efficiently in a Linux environment — whether you're managing logs, analyzing data, or writing shell scripts.

---

## 🔍 What You Learned

Here's a quick recap of the core commands and skills you practiced:

| Skill                                     | Command(s) Used       |
| ----------------------------------------- | --------------------- |
| **Viewing file contents**                 | `cat`, `more`, `less` |
| **Inspecting start/end of files**         | `head`, `tail`        |
| **Count lines, words, characters**        | `wc`                  |
| **Sort and deduplicate lines**            | `sort`, `uniq`        |
| **Search for patterns in files**          | `grep`                |
| **Extract specific fields or characters** | `cut`                 |
| **Merge files line-by-line**              | `paste`               |

---

## 💡 Why This Matters

These tools form the foundation of **text-based data manipulation** in Linux:

- They allow you to **quickly inspect and analyze** large files
- You can **filter**, **format**, and **combine** data using simple yet powerful utilities
- Together, they enable **pipeline-style scripting** (e.g., `grep | sort | uniq`) — a key part of Linux automation

---

## 🧠 Pro Tip: Combine Commands with Pipes!

Now that you know these individual tools, try combining them using the **pipe (`|`)** operator:

```bash
grep "error" /var/log/syslog | wc -l
```

> Counts how many error messages are in the system log.

Or:

```bash
cat top-sites.txt | tail -10 | grep "org" | sort
```

> Gets the last 10 sites, filters for "org", and sorts alphabetically.

---

# **Networking Commands in Linux**

---

## **1. Introduction**

This video introduces essential **Linux networking commands** that help you:

✅ View your network configuration  
✅ Test connectivity to remote servers  
✅ Retrieve data from URLs

These tools are invaluable for troubleshooting, automation, and interacting with web services.

---

## **2. `hostname` – Get or Set the Host Name**

### **Purpose**

Displays or sets the **hostname** of the machine — a unique identifier used on the network.

### **Basic Usage**

```bash
hostname
```

> Output:

```
my-linux-machine.local
```

- `.local` indicates your system uses **zeroconf/local domains** (e.g., Bonjour).

### **Options**

| Option        | Description                                 |
| ------------- | ------------------------------------------- |
| `hostname -s` | Show short hostname (without domain suffix) |
| `hostname -i` | Show IP address associated with the host    |

---

## **3. `ifconfig` – Interface Configuration**

### **Purpose**

Displays or configures **network interfaces** such as Ethernet (`eth0`) or Wi-Fi (`wlan0`).

> ⚠️ Note: `ifconfig` is deprecated in many modern Linux distros; use `ip addr` instead.

### **Basic Usage**

```bash
ifconfig
```

> Shows detailed information about all active interfaces including:

- **IP Address** (`inet`)
- **MAC Address** (`ether`)
- **Packets received/transmitted**
- **Error/dropped packet counts**

### **Example**

```bash
ifconfig eth0
```

> Shows details only for the Ethernet interface named `eth0`.

---

## **4. `ping` – Test Network Connectivity**

### **Purpose**

Tests whether a **host or IP address is reachable** by sending ICMP echo requests.

### **Basic Syntax**

```bash
ping <hostname_or_ip>
```

### **Example**

```bash
ping google.com
```

> Output:

```
PING google.com (142.251.41.78): 56 data bytes
64 bytes from 142.251.41.78: icmp_seq=0 ttl=119 time=10.4 ms
...
```

### **Useful Options**

| Option              | Description                                 |
| ------------------- | ------------------------------------------- |
| `ping -c <count>`   | Send a specific number of packets then stop |
| `ping -i <seconds>` | Interval between packets (in seconds)       |

> Example:

```bash
ping -c 5 google.com
```

> Returns 5 ping results and summary statistics:

- Number of packets transmitted and received
- Packet loss percentage
- Round-trip times (min/avg/max/stddev)

---

## **5. `curl` – Transfer Data from or to a URL**

### **Purpose**

A powerful command-line tool for transferring data using various protocols like HTTP, HTTPS, FTP, etc.

### **Basic Syntax**

```bash
curl <url>
```

### **Examples**

- Download HTML content from Google:

  ```bash
  curl http://www.google.com
  ```

- Save output to a file:
  ```bash
  curl -o google.html http://www.google.com
  ```

### **Common Uses**

- Testing API endpoints
- Downloading files/scripts
- Sending HTTP requests with custom headers/data

---

## **6. `wget` – Retrieve Files from Web URLs**

### **Purpose**

Downloads files from the web recursively and supports resuming broken downloads.

### **Basic Syntax**

```bash
wget <url>
```

### **Example**

Download a test file from W3.org:

```bash
wget https://www.w3.org/TR/2002/REC-xml-20021104/ISO-Latin-1-encoding.txt
```

### **Output Includes**

- Resolving host
- Connecting to server
- Sending HTTP request
- Saving file locally (with original name by default)

### **Useful Options**

| Option          | Description                          |
| --------------- | ------------------------------------ |
| `-O <filename>` | Specify custom output filename       |
| `-r`            | Recursive download (mirror websites) |
| `-c`            | Resume broken download               |

> Example:

```bash
wget -O iso.txt https://www.w3.org/TR/2002/REC-xml-20021104/ISO-Latin-1-encoding.txt
```

---

## **7. Summary Table of Networking Commands**

| Command                               | Purpose                        | Example                                    |
| ------------------------------------- | ------------------------------ | ------------------------------------------ |
| `hostname`                            | Display or set hostname        | `hostname` → `my-linux-machine.local`      |
| `hostname -s`                         | Show short hostname            | `hostname -s` → `my-linux-machine`         |
| `hostname -i`                         | Show IP address                | `hostname -i` → `192.168.1.100`            |
| `ifconfig`                            | Show network interface info    | `ifconfig` or `ifconfig eth0`              |
| `ping`                                | Test connectivity to a host    | `ping google.com`                          |
| `ping -c 5 google.com`                | Ping 5 times and exit          | `ping -c 5 google.com`                     |
| `curl`                                | Transfer data from or to a URL | `curl http://example.com`                  |
| `curl -o file.txt http://example.com` | Save output to a file          | Saves content to `file.txt`                |
| `wget`                                | Download files from a URL      | `wget http://example.com/file.txt`         |
| `wget -O custom_name.txt url`         | Download and rename file       | `wget -O data.txt http://example.com/data` |

---

## **8. Final Tips**

- Use `hostname` and `ifconfig` to quickly check your **machine's identity and network status**.
- Use `ping` to **test connection stability** to a website or IP address.
- Use `curl` for quick **data transfer** and testing APIs.
- Use `wget` for **downloading files**, especially when working offline or scripting.

---

## **9. Bonus: Modern Alternative to `ifconfig` – `ip` Command**

While `ifconfig` is widely known, it's being replaced by the more powerful `ip` command suite:

| Task                       | `ip` Equivalent            |
| -------------------------- | -------------------------- |
| Show IP addresses          | `ip addr show` or `ip a`   |
| Show routing table         | `ip route show` or `ip r`  |
| Bring up/down an interface | `sudo ip link set eth0 up` |

---

# 🌐 A Brief Introduction to Networking – Summary & Highlights

Great job reading through this foundational networking guide! This optional but valuable reading introduced you to **core concepts in computer networking**, helping you understand how computers communicate, share resources, and connect across networks like the Internet.

---

## 🎯 Learning Objectives Recap

After completing this reading, you are now able to:

✅ **Describe** computer networks, network resources, and network nodes  
✅ **Explain** the roles of **hosts**, **clients**, and **servers**  
✅ **Understand** what **packets** and **pings** are  
✅ **Differentiate between URLs and IP addresses**

---

## 🧩 Key Concepts Explained

### 🔹 Computer Networks

- A **computer network** is a collection of interconnected devices that can communicate and share resources.
- Examples:
  - **LAN (Local Area Network)** – small, localized network (e.g., home or office)
  - **WAN (Wide Area Network)** – covers large geographical areas (e.g., the internet)
  - **The Internet** – a global network of networks

> 💡 The internet is essentially a **network of computer networks**.

---

### 🔁 Hosts, Clients, and Servers

| Term       | Description                                                                       |
| ---------- | --------------------------------------------------------------------------------- |
| **Host**   | Any device on a network with an IP address. Can act as a **server** or **client** |
| **Client** | Requests services or data from a server                                           |
| **Server** | Provides services or data to clients (e.g., web servers, email servers)           |

> 💡 Many devices can switch roles — acting as both client and server when needed.

---

### 📦 Packets and Pings

#### What Is a Network Packet?

- A packet is a **formatted unit of data** sent over a network.
- Contains:
  - **Control information**: source, destination, routing info
  - **Payload**: actual data being transmitted

#### What Is `ping`?

- A utility used to test connectivity between two hosts
- Works by sending an **"echo request"** packet and waiting for a response
- Helps diagnose connection issues (e.g., "Can I reach Google's servers?")

Example command:

```bash
ping google.com
```

---

### 🌍 URLs and IP Addresses

#### What Is an IP Address?

- Stands for **Internet Protocol Address**
- A unique identifier assigned to each device connected to a network
- Used to **locate and communicate** with other devices
- Example IPv4 address: `192.168.1.1`
- Example IPv6 address: `2001:0db8:85a3::8a2e:0370:7334`

> 💡 When you use `ping`, it uses **IP addresses** to send and receive packets.

---

#### What Is a URL?

- Stands for **Uniform Resource Locator**
- Also known as a **web address**
- Identifies the location of a resource on the internet and how to access it

#### URL Format:

```
protocol://hostname/path
```

Example:

```
https://en.wikipedia.org/wiki/URL
```

Breakdown:

- **Protocol**: `https` – method to retrieve the resource
- **Hostname**: `en.wikipedia.org` – server where the resource lives
- **Path**: `/wiki/URL` – specific file/resource on the server

> 📌 URLs make it easier for humans to access resources without needing to remember complex IP addresses.

---

## 🧠 Why These Concepts Matter

Understanding these basics helps you:

- Troubleshoot network issues using commands like `ping`
- Understand how computers communicate over the internet
- Work more effectively with web-based tools and services
- Prepare for deeper learning about Linux networking commands

---

## ✅ Summary Table

| Concept              | Description                                                                |
| -------------------- | -------------------------------------------------------------------------- |
| **Computer Network** | Interconnected computers sharing resources                                 |
| **Network Resource** | Anything identifiable and accessible via a network (e.g., files, printers) |
| **Network Node**     | Any device participating in the network (computers, routers, etc.)         |
| **Host**             | A device that can be a client or server                                    |
| **Client**           | Requests data or services from a server                                    |
| **Server**           | Provides data or services to clients                                       |
| **Packet**           | Unit of data containing control info + payload                             |
| **Ping**             | Tests network connectivity by sending echo requests                        |
| **IP Address**       | Unique identifier for a device on a network                                |
| **URL**              | Human-readable address pointing to a web resource                          |

---

# 🧾 Exercise 1 – View Configuration Info About Your Network

In this exercise, you learned how to **view your system's network configuration**, including:

- Hostname
- IP address
- Network interface details using `hostname` and `ip`

This is essential for understanding how your machine connects to the network and communicates with other systems.

---

## 🔍 Overview of What You Learned

| Task                                              | Command             |
| ------------------------------------------------- | ------------------- |
| View system hostname                              | `hostname`          |
| View system IP address                            | `hostname -i`       |
| Show all network interfaces                       | `ip a` or `ip addr` |
| Show info about a specific interface (e.g., eth0) | `ip addr show eth0` |

---

## ✅ Step-by-Step Breakdown

### 🔹 1.1 Display Your System’s Hostname and IP Address

#### View the current **hostname**:

```bash
hostname
```

Example output:

```
theia-2c65847f
```

The **hostname** helps identify your machine on a network — especially useful in server environments.

#### View the system's **IP address**:

```bash
hostname -i
```

Example output:

```
172.17.0.2
```

> 💡 This shows the **IPv4 address** associated with your host.

---

### 🔹 1.2 Display Network Interface Configuration

Before running the `ip` command, you installed the `iproute2` package:

#### Update and install:

```bash
sudo apt update
sudo apt install iproute2
```

Now you can use the powerful `ip` command.

#### Show all network interfaces:

```bash
ip a
```

or

```bash
ip addr
```

This displays information like:

- Interface name (`lo`, `eth0`, etc.)
- IP addresses (`inet`, `inet6`)
- MAC address (`link/ether`)
- Status (`UP`, `DOWN`)

Example output line:

```
inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
```

Here, `172.17.0.2` is your **IPv4 address**.

#### Show configuration for a specific interface (like `eth0`):

```bash
ip addr show eth0
```

> 📌 `eth0` is typically the **primary Ethernet interface** used to connect to the network.

You'll see:

- The device status (`UP`)
- Its IPv4 and IPv6 addresses
- Broadcast and subnet mask info

---

## 📋 Summary Table: Useful Commands

| Purpose                              | Command             |
| ------------------------------------ | ------------------- |
| View system hostname                 | `hostname`          |
| View system IP address               | `hostname -i`       |
| List all network interfaces          | `ip a` or `ip addr` |
| View specific interface (e.g., eth0) | `ip addr show eth0` |

---

## 🧠 Why These Tools Matter

Understanding your **network configuration** helps with:

- Troubleshooting connectivity issues
- Configuring servers
- Monitoring network usage
- Writing scripts that depend on network state

The `ip` command is a modern replacement for older tools like `ifconfig`, and it offers more flexibility and control.

---

## 🛠️ Real-World Use Cases

| Task                                | Command                                                   |
| ----------------------------------- | --------------------------------------------------------- |
| Check if network is up              | `ip link show eth0`                                       |
| Find your public IP (from terminal) | `curl ifconfig.me`                                        |
| Monitor interface changes           | `ip monitor`                                              |
| Bring an interface up/down          | `sudo ip link set eth0 up` / `sudo ip link set eth0 down` |

---

# 🧪 Exercise 2 – Test Network Connectivity with `ping`

In this exercise, you learned how to use the **`ping`** command to test whether your system can successfully communicate with another device or website over the network.

This is a fundamental tool for:

- Checking internet connectivity
- Diagnosing network issues
- Testing server availability

---

## 🔍 Overview of What You Learned

| Task                                   | Command                    |
| -------------------------------------- | -------------------------- |
| Ping a host continuously               | `ping www.google.com`      |
| Ping a host a specific number of times | `ping -c 5 www.google.com` |

---

## ✅ Step-by-Step Breakdown

### 🔹 2.1 Test Connectivity to a Host Using `ping`

#### Ping Google continuously:

```bash
ping www.google.com
```

You’ll see output like:

```
64 bytes from 142.251.42.78: icmp_seq=1 ttl=115 time=15.3 ms
64 bytes from 142.251.42.78: icmp_seq=2 ttl=115 time=14.9 ms
...
```

Each line shows:

- The size of the response
- The IP address of the responding server
- Sequence number
- Time-to-live (TTL)
- Round-trip time in milliseconds

> ⚠️ To stop the ping process, press **Ctrl + C**

---

#### Ping a Host a Specific Number of Times

To limit the number of packets sent, use the `-c` option:

```bash
ping -c 5 www.google.com
```

This sends **exactly 5 packets**, then stops automatically.

Useful for:

- Scripting and automation
- Quick tests without manually stopping the command

---

## 📋 Summary Table

| Command                | Description                             |
| ---------------------- | --------------------------------------- |
| `ping hostname`        | Tests if a remote host is reachable     |
| `ping -c N hostname`   | Pings the host exactly N times          |
| `ping -c 5 google.com` | Sends 5 packets to google.com and stops |

---

## 🧠 Why This Matters

Using `ping` helps you quickly determine:

- Whether you have **internet access**
- If a **remote server is online**
- How fast your connection is (based on **response time**)
- If there’s packet loss or high latency

It's one of the most basic yet powerful tools in any Linux user's networking toolkit.

---

## 🛠️ Real-World Use Cases

| Scenario                      | Command                                    |
| ----------------------------- | ------------------------------------------ |
| Check if you're online        | `ping -c 4 google.com`                     |
| Troubleshoot slow connections | `ping google.com` (observe response times) |
| Test local network devices    | `ping 192.168.1.1`                         |
| Monitor server availability   | `ping -c 10 server.example.com`            |

---

# 📥 Exercise 3 – View or Download Data from a Server

In this exercise, you learned how to **retrieve data from remote servers** using two powerful command-line tools:

- `curl` – for transferring data and viewing content directly in the terminal
- `wget` – for downloading files (and even entire websites)

These tools are essential for:

- Fetching configuration files
- Downloading software or scripts
- Interacting with APIs
- Automating tasks that involve remote data

---

## 🔍 Overview of What You Learned

| Task                          | Command         |
| ----------------------------- | --------------- |
| View file contents from a URL | `curl [URL]`    |
| Download and save a file      | `curl -O [URL]` |
| Download a file using wget    | `wget [URL]`    |

---

## ✅ Step-by-Step Breakdown

### 🔹 3.1 Transfer Data from a Server Using `curl`

#### View file contents from a URL:

```bash
curl https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt
```

This displays the full text of the **U.S. Declaration of Independence** directly in your terminal.

> 💡 This is useful when you want to inspect remote files without saving them.

---

#### Save the file to your current directory:

```bash
curl -O https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt
```

Now you have a local copy named `usdoi.txt`.

> 📁 The `-O` option tells `curl` to save the file using its original filename.

---

### 🔹 3.2 Download Files Using `wget`

#### First, remove the file if it already exists:

```bash
rm usdoi.txt
```

#### Then download it again using `wget`:

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt
```

This downloads the file and saves it in your current directory.

> ⚙️ `wget` is especially useful because:
>
> - It works well in scripts
> - Supports recursive downloads (`-r`)
> - Can continue interrupted downloads (`-c`)
> - Doesn't require user interaction once started

---

## 📋 Summary Table: `curl` vs `wget`

| Feature                      | `curl`                      | `wget`                    |
| ---------------------------- | --------------------------- | ------------------------- |
| View content in terminal     | ✅ Yes                      | ❌ No                     |
| Save file with original name | ✅ With `-O`                | ✅ Yes                    |
| Recursive download           | ❌ No                       | ✅ Yes with `-r`          |
| Resume broken download       | ❌ By default               | ✅ With `-c`              |
| Works silently               | ❌ Noisy by default         | ✅ With `-q`              |
| Use case                     | API calls, quick inspection | File downloads, scripting |

---

## 🧠 Why These Tools Matter

With `curl` and `wget`, you can:

- **Automate downloads** in scripts
- **Fetch live data** from APIs or web services
- **Download large datasets** or software packages
- **Troubleshoot HTTP responses** and server connectivity

They're foundational tools for working with **networked resources** in Linux.

---

## 🛠️ Real-World Examples

### 🔽 Download a file silently with `wget`:

```bash
wget -q https://example.com/file.zip
```

### 🖥️ Download and display JSON from an API:

```bash
curl https://api.github.com/users/octocat
```

### 📂 Recursively download an entire website:

```bash
wget -r https://example.com
```

### 📥 Resume a partially downloaded file:

```bash
wget -c http://example.com/largefile.iso
```

---

## **Exercise 4 – Exploring DNS and Looking Up Domain Information**

In this exercise, you'll learn how to:

- Understand what **DNS** is and why it matters
- Use `nslookup` and `dig` to look up domain information
- Check **IP addresses**, **name servers**, and **mail servers** associated with a domain

These tools are essential for:

- Troubleshooting domain issues
- Checking website availability
- Understanding how domains resolve to IP addresses
- Debugging email delivery problems using MX records

---

## 🌐 What Is DNS?

**DNS (Domain Name System)** is like the phonebook of the internet.

It maps **human-readable domain names** (like `google.com`) to **machine-readable IP addresses** (like `172.217.174.78`), so your computer knows where to find a website or service.

### Key DNS Concepts:

| Term            | Meaning                                            |
| --------------- | -------------------------------------------------- |
| **A Record**    | Maps a domain name to an IPv4 address              |
| **AAAA Record** | Maps a domain to an IPv6 address                   |
| **CNAME**       | Alias record pointing one domain to another        |
| **MX Record**   | Specifies mail servers for a domain                |
| **NS Record**   | Identifies authoritative name servers for a domain |

---

## 🔍 Step-by-Step: Using `nslookup`

The `nslookup` command helps you query DNS servers to get domain-related information.

### ✅ View Basic DNS Info for a Website

```bash
nslookup google.com
```

This shows:

- The **IP address** of the domain
- The **DNS server** used to retrieve the info

---

### ✅ Look Up Mail Servers (MX Records)

```bash
nslookup -type=mx gmail.com
```

This lists the **mail exchange (MX) servers** responsible for receiving emails for `gmail.com`.

---

### ✅ Query Name Servers (NS Records)

```bash
nslookup -type=ns ibm.com
```

This shows which **name servers** are responsible for managing the domain’s DNS records.

---

## 🔎 Step-by-Step: Using `dig`

`dig` (**Domain Information Groper**) is a more detailed and powerful tool than `nslookup`. It gives you full control over DNS queries.

### ✅ View A Record for a Domain

```bash
dig google.com
```

Look for the **ANSWER SECTION**:

```
google.com.     299     IN      A       172.217.174.78
```

This shows the **IPv4 address** that `google.com` resolves to.

---

### ✅ Look Up MX Records with `dig`

```bash
dig MX gmail.com
```

Scroll down to the **ANSWER SECTION** to see which servers handle email for Gmail.

---

### ✅ Get All DNS Records for a Domain

```bash
dig ANY ibm.com
```

This fetches all available DNS records for `ibm.com`, including:

- A / AAAA
- CNAME
- MX
- NS
- TXT (used for SPF, DKIM, etc.)

> ⚠️ Some domains may restrict "ANY" queries for security reasons.

---

## 📋 Summary Table: Useful DNS Commands

| Task                           | Command                       |
| ------------------------------ | ----------------------------- |
| View basic DNS info            | `nslookup google.com`         |
| Look up MX records (for email) | `nslookup -type=mx gmail.com` |
| Look up name servers           | `nslookup -type=ns ibm.com`   |
| View A record                  | `dig google.com`              |
| View MX records                | `dig MX gmail.com`            |
| View all DNS records           | `dig ANY ibm.com`             |

---

## 🧠 Why This Matters

Understanding DNS helps you:

- Diagnose **domain resolution issues**
- Verify **email server settings**
- Configure **custom domains**
- Troubleshoot **website downtime**

Tools like `nslookup` and `dig` are invaluable for system administrators, developers, and anyone working with web services.

---

## 🛠️ Real-World Examples

| Scenario                            | Command                                                |
| ----------------------------------- | ------------------------------------------------------ |
| Check if a site resolves correctly  | `dig example.com`                                      |
| Find who handles a domain’s email   | `dig MX example.com`                                   |
| Debug DNS propagation after changes | `dig @8.8.8.8 example.com` _(use Google's public DNS)_ |
| Test local DNS cache                | `nslookup example.com` _(before and after flush)_      |

---

# 🛠️ **Practice Exercises – Networking in Linux**

These exercises will help reinforce your understanding of **network-related commands** in Linux. You'll be working with tools like `hostname`, `ping`, `ip`, `curl`, and `wget` to inspect network configuration, test connectivity, and transfer data.

---

## 🔧 Before You Begin

Make sure you're in the correct directory:

```bash
cd /home/project
pwd
```

You should see:

```
/home/project
```

Now let's go through each exercise step-by-step.

---

## ✅ 1. Display Your Host’s IP Address

### 💡 Hint:

Use the `hostname` command with an option that shows the IP address.

### ✅ Solution:

```bash
hostname -i
```

This displays your system’s internal **IPv4 address**, such as:

```
172.17.0.2
```

> This is useful for checking what IP address your machine is using on the local network.

---

## ✅ 2. Get Connectivity Stats on Your Connection to www.google.com

### 💡 Hint:

Use the `ping` command with a limited number of packets.

### ✅ Solution:

```bash
ping -c 5 www.google.com
```

This sends **5 ICMP echo requests** to Google's servers and returns stats like:

- Round-trip time (latency)
- Packet loss

Example output:

```
--- www.google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4005ms
rtt min/avg/max/mdev = 10.2/11.8/13.9/1.2 ms
```

> This helps determine if your system can reach external sites and how fast it does so.

---

## ✅ 3. View Info About Your Ethernet Adapter `eth0`

### 💡 Hint:

Use the `ip` command to show details about the network interface.

### ✅ Solution:

```bash
ip addr show eth0
```

This shows:

- Interface status (`UP`)
- IPv4 and IPv6 addresses
- MAC address
- Broadcast and subnet info

Look for the line starting with `inet` — this is your **IP address**.

Example:

```
inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
```

> This is helpful when troubleshooting or configuring network interfaces.

---

## ✅ 4. View the HTML Code for www.google.com’s Landing Page

### 💡 Hint:

Use `curl` to fetch and display remote content.

### ✅ Solution:

```bash
curl www.google.com
```

This displays the raw **HTML source code** of Google's homepage directly in your terminal.

> Tip: If the output looks messy, try saving it to a file instead (next step).

---

## ✅ 5. Download the HTML Code for www.google.com’s Landing Page

### 💡 Hint:

Use `wget` to download and save the page.

### ✅ Solution:

```bash
wget www.google.com
```

This saves the downloaded HTML as:

```
index.html
```

Verify the file exists:

```bash
ls -l
```

You’ll see something like:

```
-rw-r--r-- 1 user user 12345 Apr 5 10:00 index.html
```

> You now have a local copy of Google's home page!

---

## 📋 Summary Table

| Task                        | Command                    |
| --------------------------- | -------------------------- |
| Show host IP address        | `hostname -i`              |
| Test connectivity to Google | `ping -c 5 www.google.com` |
| View eth0 interface info    | `ip addr show eth0`        |
| View HTML of Google         | `curl www.google.com`      |
| Download Google's HTML      | `wget www.google.com`      |

---

# **File Archiving and Compression Commands in Linux**

---

## **1. Introduction**

✅ Understand the difference between **archiving** and **compression**  
✅ Create and extract **tarballs** (`.tar` files)  
✅ Compress and decompress using **gzip** and **zip**  
✅ Extract contents from **compressed archives**

These skills are essential for:

- Backing up data
- Transferring large collections of files
- Managing disk space

---

## **2. Key Concepts**

### **A. Archiving**

- **Definition**: Combines multiple files into a **single file** without reducing size.
- **Purpose**: For **portability and backup**.
- **Example Format**: `.tar`

### **B. Compression**

- **Definition**: Reduces file size by removing redundancy.
- **Purpose**: Saves **storage space**, speeds up **transfers**, and reduces **bandwidth usage**.
- **Common Tools**:
  - `gzip` – used with `.tar.gz` or `.tgz`
  - `zip` – used with `.zip`

---

## **3. Using `tar` – Tape ARchiver**

### **Purpose**

Create or extract **archive files** (called **tarballs**) that bundle directories and files.

### **Basic Syntax**

```bash
tar [options] [archive_name.tar] [files_or_directories]
```

### **Common Options**

| Option | Meaning                                             |
| ------ | --------------------------------------------------- |
| `-c`   | Create a new archive                                |
| `-f`   | Specify filename                                    |
| `-t`   | List contents of an archive                         |
| `-x`   | Extract files from archive                          |
| `-z`   | Filter through gzip (for compression/decompression) |

---

### **A. Creating a Tar Archive**

To archive a directory called `notes`:

```bash
tar -cf notes.tar notes/
```

> Creates `notes.tar`, containing all files in the `notes` directory.

---

### **B. Listing Contents of a Tar File**

To view what's inside `notes.tar`:

```bash
tar -tf notes.tar
```

---

### **C. Extracting Files from a Tar Archive**

To extract files:

```bash
tar -xf notes.tar
```

---

### **D. Compressing a Tar Archive with GZIP**

To compress `notes.tar` into a smaller `notes.tar.gz`:

```bash
tar -czf notes.tar.gz notes/
```

> This bundles and compresses the `notes` directory into a single compressed archive.

---

### **E. Extracting a `.tar.gz` File**

To extract both the archive and its compressed contents:

```bash
tar -xzf notes.tar.gz
```

> The `-z` option automatically handles **gzip compression**.

---

## **4. Using `zip` and `unzip`**

### **A. What is `zip`?**

- Combines **compression and archiving** in one step.
- Produces `.zip` files — widely supported across operating systems.

### **Creating a ZIP Archive**

To compress the `notes` folder into `notes.zip`:

```bash
zip -r notes.zip notes/
```

> The `-r` flag ensures **all subdirectories** are included.

---

### **Listing Contents of a ZIP File**

Use `unzip` to list contents:

```bash
unzip -l notes.zip
```

---

### **Extracting a ZIP File**

To extract the contents:

```bash
unzip notes.zip
```

> Automatically recreates the original directory structure.

---

## **5. Summary Table of Archiving & Compression Commands**

| Task                     | Command                           | Description                            |
| ------------------------ | --------------------------------- | -------------------------------------- |
| Create tar archive       | `tar -cf archive.tar folder/`     | Bundle files into a single `.tar` file |
| List tar contents        | `tar -tf archive.tar`             | View files inside `.tar`               |
| Extract tar archive      | `tar -xf archive.tar`             | Unpack `.tar` without compression      |
| Create compressed tar.gz | `tar -czf archive.tar.gz folder/` | Archive + gzip compression             |
| Extract tar.gz file      | `tar -xzf archive.tar.gz`         | Decompress and unpack `.tar.gz`        |
| Create zip archive       | `zip -r archive.zip folder/`      | Compress and bundle in `.zip` format   |
| List zip contents        | `unzip -l archive.zip`            | Show files inside `.zip`               |
| Extract zip file         | `unzip archive.zip`               | Uncompress and unpack `.zip`           |

---

## **6. Comparison: `tar` vs `zip`**

| Feature                    | `tar`                                   | `zip`                            |
| -------------------------- | --------------------------------------- | -------------------------------- |
| **Primary Use**            | Archiving (with optional compression)   | Archiving + built-in compression |
| **Compression Tool**       | Usually combined with `gzip` (`tar.gz`) | Built-in compression             |
| **Cross-Platform Support** | Limited on Windows                      | Widely supported                 |
| **Recursive by Default**   | Yes                                     | Requires `-r` for folders        |
| **Preserves Permissions**  | Yes (on Unix/Linux)                     | No (on Windows)                  |

---

## **7. Example Directory Structure**

Suppose you have this directory:

```
notes/
├── math/
│   ├── week1.txt
│   └── week2.txt
└── physics/
    ├── week1.txt
    └── week2.txt
```

You can compress it into:

- `notes.tar` (just archived)
- `notes.tar.gz` (archived + compressed)
- `notes.zip` (compressed archive)

And later extract it back to the same structure using the appropriate command.

---

## **8. Final Tips**

- Use `tar` when preserving permissions and working in Linux/Unix environments.
- Use `zip` for cross-platform compatibility (e.g., sharing with Windows users).
- Always double-check your file extensions:
  - `.tar` → just archived
  - `.tar.gz` or `.tgz` → archived + compressed
  - `.zip` → compressed archive
- Combine `tar` with `gzip` for efficient backups.
- Use `unzip` and `tar -tzf` to preview contents before extraction.

---

# 📦 Exercise 1 - File and Folder Archiving and Compression

In this exercise, you learned how to **package**, **compress**, and **extract** files using the Linux command line tools:

- `tar` – for creating `.tar` archives
- `zip` – for compressing into `.zip` format
- `unzip` – for extracting `.zip` files

These are essential skills for:

- Backing up data
- Transferring multiple files as a single package
- Saving disk space with compression
- Managing software distributions or logs

---

## 🔧 Step-by-Step Breakdown

### 🔹 1.1 Create and Manage File Archives with `tar`

#### Create a `.tar` archive of the `/bin` directory:

```bash
tar -cvf bin.tar /bin
```

- `-c` = create a new archive
- `-v` = show progress (verbose)
- `-f` = specify filename (`bin.tar`)

This creates a large file called `bin.tar`, which contains all files from the `/bin` directory.

---

#### List contents of the `.tar` archive:

```bash
tar -tvf bin.tar
```

This shows a detailed list of files inside the archive — useful for verifying contents before extraction.

---

#### Extract files from the `.tar` archive:

```bash
tar -xvf bin.tar
```

- `-x` = extract
- `-v` = show progress
- `-f` = specify filename

After extraction, you'll see a folder named `bin` in your current directory.

> Tip: Use `ls -l` to confirm it was extracted correctly.

---

### 🔹 1.2 Package and Compress Archive Files with `zip`

#### Create a `.zip` file of all `.conf` files in `/etc`:

```bash
zip config.zip /etc/*.conf
```

This bundles all configuration files ending in `.conf` into one compressed file: `config.zip`.

---

#### Create a compressed ZIP archive of an entire directory:

```bash
zip -ry bin.zip /bin
```

- `-r` = recursively include all files and subdirectories
- `-y` = store symbolic links as such (instead of following them)

This compresses the entire `/bin` directory into a portable `bin.zip` file.

---

### 🔹 1.3 Extract, List, or Test ZIP Archives with `unzip`

#### List contents of a `.zip` file:

```bash
unzip -l config.zip
```

This shows what’s inside the archive without extracting anything — helpful for previewing.

---

#### Extract all files from a `.zip` archive:

```bash
unzip -o bin.zip
```

- `-o` = overwrite existing files (useful if you run the command more than once)
- Automatically creates a `bin` directory containing the extracted files

---

## 📋 Summary Table

| Task                 | Command                           |
| -------------------- | --------------------------------- |
| Create tar archive   | `tar -cvf archive.tar directory/` |
| List tar contents    | `tar -tvf archive.tar`            |
| Extract tar archive  | `tar -xvf archive.tar`            |
| Zip specific files   | `zip archive.zip file1 file2`     |
| Zip entire directory | `zip -r archive.zip directory/`   |
| List zip contents    | `unzip -l archive.zip`            |
| Extract zip archive  | `unzip -o archive.zip`            |

---

## 🧠 Why This Matters

Understanding archiving and compression helps you:

- Bundle and share multiple files easily
- Save storage space
- Backup important directories
- Transfer data securely between systems

`tar` is commonly used in Linux environments for packaging, while `zip` offers cross-platform compatibility with Windows and macOS.

---

## 💡 Pro Tips

- Combine `tar` and `gzip` for compressed archives:
  ```bash
  tar -czvf archive.tar.gz directory/
  ```
- Use wildcards with zip:
  ```bash
  zip logfiles.zip *.log
  ```
- Exclude files when zipping:
  ```bash
  zip -r project.zip project/ -x "*.git*"
  ```

---

# 🎉 Module Summary & Highlights – Great Work!

You've successfully completed a comprehensive module that covers **essential Linux command-line skills**, from navigating the system and managing files to working with networks, processes, and archives.

Here's a clean, organized summary of what you’ve learned — your **Linux command cheat sheet** for future reference.

---

## 🔧 Shell & Terminal Basics

| Task                    | Command                       |
| ----------------------- | ----------------------------- |
| Start shell             | Default shell is Bash         |
| Display current user    | `whoami`                      |
| Show user ID info       | `id`                          |
| Get OS info             | `uname -a`                    |
| List directory contents | `ls`, `ls -l`                 |
| Change directories      | `cd directory_name`           |
| Show current path       | `pwd`                         |
| Find files              | `find /path -name "filename"` |

---

## 📁 File and Directory Management

| Task                     | Command                   |
| ------------------------ | ------------------------- |
| Create file              | `touch filename`          |
| Make directory           | `mkdir dirname`           |
| Copy file/dir            | `cp source destination`   |
| Move or rename           | `mv old new`              |
| Remove file              | `rm filename`             |
| Remove empty dir         | `rmdir dirname`           |
| View file content        | `cat filename`            |
| View first N lines       | `head -N filename`        |
| View last N lines        | `tail -N filename`        |
| Count lines/words/chars  | `wc`, `wc -l filename`    |
| Sort lines               | `sort filename`           |
| Remove duplicates        | `uniq filename`           |
| Search in files          | `grep "pattern" filename` |
| Extract fields           | `cut -d "," -f2 filename` |
| Merge files line-by-line | `paste file1 file2`       |

---

## 💾 Archiving and Compression

| Task                   | Command                            |
| ---------------------- | ---------------------------------- |
| Create `.tar` archive  | `tar -cvf archive.tar folder/`     |
| List `.tar` contents   | `tar -tvf archive.tar`             |
| Extract `.tar` archive | `tar -xvf archive.tar`             |
| Compress into `.zip`   | `zip -r archive.zip folder/`       |
| List `.zip` contents   | `unzip -l archive.zip`             |
| Extract `.zip` archive | `unzip archive.zip`                |
| Combine tar + gzip     | `tar -czvf archive.tar.gz folder/` |

---

## 🌐 Networking Tools

| Task                       | Command                                     |
| -------------------------- | ------------------------------------------- |
| View hostname              | `hostname`                                  |
| View IP address            | `hostname -i`                               |
| Inspect network interfaces | `ip addr` or `ip a`                         |
| Test connectivity          | `ping www.google.com`                       |
| Transfer data              | `curl https://example.com/file.txt`         |
| Download files             | `wget https://example.com/file.txt`         |
| Look up DNS records        | `nslookup example.com` or `dig example.com` |

---

## 🖥️ System Monitoring & Info

| Task              | Command          |
| ----------------- | ---------------- |
| Disk space        | `df -h`          |
| Running processes | `ps -e`, `top`   |
| Current date/time | `date`           |
| Print text/values | `echo "message"` |
| Read manual pages | `man command`    |

---

## 🔒 File Permissions and Ownership

| Task               | Command                                       |
| ------------------ | --------------------------------------------- |
| View permissions   | `ls -l`                                       |
| Change permissions | `chmod u+rwx filename`                        |
| Change ownership   | `chown user:group filename` _(requires root)_ |

---

## 🛠️ Text Processing & Data Wrangling

| Task                     | Command                   |
| ------------------------ | ------------------------- | ----- |
| Sort lines               | `sort filename`           |
| Remove duplicate lines   | `sort file                | uniq` |
| Extract patterns         | `grep "search" file`      |
| Cut out columns          | `cut -d "," -f1 file.csv` |
| Merge files side-by-side | `paste file1 file2`       |

---

## 🧠 Why This Matters

You now have a solid foundation in:

- **Navigating and managing files**
- **Searching and processing text**
- **Understanding and controlling file permissions**
- **Working with networked resources**
- **Archiving and compressing files**

These are core skills used daily by:

- **System administrators**
- **Developers**
- **Data engineers**
- **DevOps engineers**
- **Security analysts**

---

# 📄 Module 2 Cheat Sheet – Introduction to Linux Commands

This cheat sheet is your **go-to reference** for the most commonly used **Linux commands** in system navigation, file management, text processing, networking, and more.

---

## ❓ **Getting Information**

| Task                         | Command       |
| ---------------------------- | ------------- |
| Show current user            | `whoami`      |
| Display user/group ID info   | `id`          |
| Show OS and kernel info      | `uname -a`    |
| View command manual          | `man top`     |
| List all available man pages | `man -k .`    |
| Get help on a command        | `curl --help` |
| Show current date/time       | `date`        |

---

## 🧭 **Navigating and Working with Directories**

| Task                               | Command                   |
| ---------------------------------- | ------------------------- |
| List files by date (newest first)  | `ls -lrt`                 |
| Find `.sh` files in directory tree | `find -name "*.sh"`       |
| Show current working directory     | `pwd`                     |
| Create a new directory             | `mkdir new_folder`        |
| Move up one level                  | `cd ../`                  |
| Go to home directory               | `cd ~` or just `cd`       |
| Remove empty directory             | `rmdir temp_directory -v` |

---

## 🔍 **Monitoring System Performance**

| Task                           | Command                        |
| ------------------------------ | ------------------------------ |
| List running processes         | `ps`                           |
| List all processes             | `ps -e`                        |
| View real-time system stats    | `top`                          |
| Check disk space usage         | `df`                           |
| Show disk usage of directories | `du` _(not listed but useful)_ |

---

## 📁 **Creating, Copying, Moving, and Deleting Files**

| Task                  | Command                                    |
| --------------------- | ------------------------------------------ |
| Create an empty file  | `touch a_new_file.txt`                     |
| Copy a file           | `cp file.txt new_path/new_name.txt`        |
| Rename or move a file | `mv this_file.txt that_path/that_file.txt` |
| Delete a file         | `rm this_old_file.txt -v`                  |

---

## 🔐 **Working with File Permissions**

| Task                              | Command                             |
| --------------------------------- | ----------------------------------- |
| Make file executable for everyone | `chmod +x my_script.sh`             |
| Give owner execute permission     | `chmod u+x my_file.txt`             |
| Remove read from group & others   | `chmod go-r filename`               |
| Change file ownership             | `chown user:group file` _(as root)_ |

---

## 📖 **Displaying File and String Contents**

| Task                     | Command                   |
| ------------------------ | ------------------------- |
| View full file contents  | `cat my_shell_script.sh`  |
| View file page-by-page   | `more ReadMe.txt`         |
| View first N lines       | `head -10 data_table.csv` |
| View last N lines        | `tail -10 data_table.csv` |
| Print string or variable | `echo "I am $USERNAME"`   |

---

## 🧹 **Basic Text Wrangling**

### Sorting and Deduplication

| Task                     | Command                         |
| ------------------------ | ------------------------------- |
| Sort file alphabetically | `sort text_file.txt`            |
| Sort in reverse order    | `sort -r text_file.txt`         |
| Remove duplicate lines   | `uniq list_with_duplicates.txt` |

### Counting Lines/Words/Characters

| Task                       | Command                   |
| -------------------------- | ------------------------- |
| Count lines in a file      | `wc -l table_of_data.csv` |
| Count words in a file      | `wc -w my_essay.txt`      |
| Count characters in a file | `wc -m some_document.txt` |

### Searching with `grep`

| Task                                  | Command                                |
| ------------------------------------- | -------------------------------------- |
| Search case-insensitively for "hello" | `grep -iw hello a_bunch_of_hellos.txt` |
| List files containing "hello"         | `grep -l hello *.txt`                  |

### Merging Files with `paste`

| Task                     | Command                                                      |
| ------------------------ | ------------------------------------------------------------ |
| Merge files side-by-side | `paste first_name.txt last_name.txt phone_number.txt`        |
| Use comma as delimiter   | `paste -d "," first_name.txt last_name.txt phone_number.txt` |

### Extracting Data with `cut`

| Task                             | Command                       |
| -------------------------------- | ----------------------------- |
| Extract first field (CSV)        | `cut -d "," -f 1 names.csv`   |
| Extract bytes 2–5 from each line | `cut -b 2-5 my_text_file.txt` |
| Extract from byte 10 onward      | `cut -b 10- my_text_file.txt` |

---

## 📦 **Compression and Archiving**

| Task                           | Command                                                 |
| ------------------------------ | ------------------------------------------------------- |
| Create tar archive             | `tar -cvf my_archive.tar file1 file2`                   |
| Compress with zip              | `zip my_zipped_files.zip file1 file2`                   |
| Compress directory with zip    | `zip -r my_zipped_folders.zip dir1 dir2`                |
| Extract zip file               | `unzip my_zipped_file.zip`                              |
| Extract zip to specific folder | `unzip my_zipped_file.zip -d extract_to_this_directory` |

---

## 🌐 **Networking Commands**

| Task                              | Command               |
| --------------------------------- | --------------------- |
| Show hostname                     | `hostname`            |
| Test network connectivity         | `ping www.google.com` |
| Configure/view network interfaces | `ip`                  |
| Download content from URL         | `curl <url>`          |
| Download and save file            | `wget <url>`          |

---

## 🧠 Pro Tips

- Combine commands using pipes:
  ```bash
  grep "error" /var/log/syslog | wc -l
  ```
- Use wildcards to match patterns:
  ```bash
  ls *.txt
  ```
- Always double-check what you're about to delete:
  ```bash
  rm -i *.tmp
  ```

---

You're now equipped with a powerful set of tools to work confidently in the Linux environment. Whether you're managing servers, writing scripts, or analyzing logs — this cheat sheet will be your best companion.

---
