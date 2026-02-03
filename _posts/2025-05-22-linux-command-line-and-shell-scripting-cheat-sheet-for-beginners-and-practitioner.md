---
title: Linux Command Line and Shell Scripting Cheat Sheet for Beginners and Practitioner
date: 2025-05-22
categories: [linux]
tags:
  - cheatsheet
description: Introduction to Linux Commands -   Informational, Navigational, & Management Commands | Working with Text Files, Networking & Archiving Commands | Introduction to Shell Scripting 
---


# **Cheat Sheet: Introduction to Linux Commands and Shell Scripting**

This cheat sheet provides a quick reference for the most commonly used Linux commands and shell scripting concepts covered in this course.


## Introduction to Linux

| Command             | Syntax                             | Description                          | Example                         |
|---------------------|-------------------------------------|--------------------------------------|---------------------------------|
| List                | ls [OPTIONS] [FILE/DIRECTORY]       | List files and directories at path   | ls /home/user/documents         |
| Print Working Directory | pwd                             | Print present working directory      | pwd                             |
| Change Directory    | cd [DIRECTORY]                      | Change current directory             | cd /home/user/documents         |
| Super user do       | sudo [COMMAND]                      | Run command with superuser privileges | sudo apt update              |
| Text Editor         | nano [FILE]                         | Open file with Nano text editor      | nano myfile.txt                 |
| Terminal Clear      | clear                               | Clear terminal screen                | clear                           |
| History             | history                             | Show command history                 | history                         |
| Execute Previous    | !!                                  | Run last command again               | !!                              |

## Introduction to Linux Commands

### Informational, Navigational, & Management Commands

| Command             | Syntax                             | Description                          | Example                         |
|---------------------|-------------------------------------|--------------------------------------|---------------------------------|
| Who Am I            | whoami                             | Return username                      | whoami                          |
| User ID             | id                                 | Return current user or group ID      | id                              |
| System Information  | uname [OPTIONS]                    | Display system information           | uname -a                        |
| Manual Pages        | man [COMMAND]                      | Display manual page for a command    | man ls                          |
| Curl                | curl [OPTIONS] [URL]               | Transfer data from or to server      | curl https://some_website.com   |
| Date                | date [OPTIONS]                     | Display current date and time        | date                            |
| Cal                 | cal                                | Display calendar                     | cal                             |
| Find                | find [DIRECTORY] [OPTIONS]         | Find files and directories at path   | find /home/user -name '*.txt'   |
| Locate              | locate [FILENAME]                  | Quickly find files in indexed db     | locate bashrc                   |
| Make Directory      | mkdir [DIRECTORY]                  | Create new directory                 | mkdir myfolder                  |
| Remove Directory    | rmdir [DIRECTORY]                  | Remove empty directory               | rmdir myfolder                  |
| Process Status      | ps [OPTIONS]                       | Display process status               | ps -ef                          |
| Table of Processes  | top                                | Live system resource usage           | top                             |
| Disk Usage          | df [OPTIONS] [FILESYSTEM]          | Display disk space usage             | df -h                           |
| Create Empty File   | touch [FILE]                       | Create file or update timestamp      | touch myfile.txt                |
| Copy                | cp [SOURCE] [DESTINATION]          | Copy files/directories               | cp file.txt /tmp                |
| Move                | mv [SOURCE] [DESTINATION]          | Move/rename files/directories        | mv file.txt /tmp                |
| Remove              | rm [OPTIONS] [FILE/DIR]            | Remove files/directories             | rm -r temp_folder               |
| Change Mode         | chmod [MODE] [FILE]                | Change permissions                   | chmod u+x script.sh             |
| Change Owner        | chown [USER]:[GROUP] [FILE]        | Change file owner/group              | chown root:root config.cfg      |
| Kill Process        | kill [PID]                         | Terminate a process                  | kill 1234                       |
| Background Process  | command &                          | Run process in background            | sleep 10 &                      |
| Bring Foreground    | fg                                 | Bring background job to foreground   | fg                              |

## Working with Text Files, Networking & Archiving Commands

| Command             | Syntax                             | Description                          | Example                         |
|---------------------|-------------------------------------|--------------------------------------|---------------------------------|
| Concatenate         | cat [FILE]                         | Show file contents                   | cat file.txt                    |
| More                | more [FILE]                        | Display file one screen at time      | more file.txt                   |
| Less                | less [FILE]                        | Enhanced paginator                   | less largefile.log              |
| Head                | head -n [N] [FILE]                 | First N lines of file                | head -5 file.txt                |
| Tail                | tail -n [N] [FILE]                 | Last N lines of file                 | tail -5 file.txt                |
| Tail Follow         | tail -f [FILE]                     | Follow file changes live             | tail -f /var/log/syslog         |
| Echo                | echo [STRING]                      | Print message to console             | echo "Hello"                    |
| Sort                | sort [FILE]                        | Sort file lines                      | sort file.txt                   |
| Unique              | uniq [FILE]                        | Remove duplicate adjacent lines      | uniq sorted.txt                 |
| Word Count          | wc [OPTIONS] [FILE]                | Count lines/words/chars              | wc -l file.txt                  |
| Grep                | grep "PATTERN" [FILE]              | Search pattern in file               | grep "error" logfile.log        |
| Paste               | paste file1 file2                  | Merge files side-by-side             | paste file1.txt file2.txt       |
| Cut                 | cut -d':' -f1 [FILE]               | Remove sections of lines             | cut -d':' -f1 /etc/passwd       |
| Tar                 | tar -czvf [ARCHIVE] [DIR]          | Compress directory as tar.gz         | tar -czvf archive.tar.gz dir/   |
| Untar               | tar -xzvf [ARCHIVE]                | Extract tar.gz archive               | tar -xzvf archive.tar.gz        |
| Zip                 | zip [ARCHIVE.zip] [FILES]          | Create zip archive                   | zip backup.zip file1 file2      |
| Unzip               | unzip [ARCHIVE.zip]                | Extract zip archive                  | unzip backup.zip                |
| Hostname            | hostname                           | Print system hostname                | hostname                        |
| Ping                | ping [HOST]                        | Check host connectivity              | ping google.com                 |
| IP Addressing       | ip addr                            | Display IP addresses                 | ip addr                         |
| Curl                | curl [URL]                         | Download data                        | curl https://example.com        |
| Wget                | wget [URL]                         | Download file                        | wget https://example.com/file   |
| Nslookup            | nslookup [DOMAIN]                  | Query DNS                            | nslookup google.com             |
| Netstat             | netstat -tuln                      | Show open ports                      | netstat -tuln                   |

## Introduction to Shell Scripting

| Command             | Syntax                             | Description                          | Example                         |
|---------------------|-------------------------------------|--------------------------------------|---------------------------------|
| Shebang             | #!/bin/bash                        | Declare shell interpreter            | #!/bin/bash                     |
| Pipe                | command1 \| command2                | Send output to next command          | ls \| grep ".sh"                |
| Redirect Out        | command > file                     | Redirect stdout                      | echo "Hello" > hello.txt        |
| Append Out          | command >> file                    | Append stdout                        | echo "Again" >> hello.txt       |
| Redirect Error      | command 2> error.txt               | Redirect stderr                      | ls x 2> err.txt                 |
| Redirect Both       | command > out.txt 2>&1             | Redirect both stdout and stderr      | ./script.sh > all.log 2>&1      |
| Which               | which bash                         | Path of executable                   | which bash                      |
| Bash                | bash script.sh                     | Run Bash script                      | bash script.sh                  |
| Set Variables       | VAR=value                          | Assign variable                      | name="Janak"                    |
| Read                | read VAR                           | Read input                           | read name                       |
| Export              | export VAR                         | Export variable                      | export name                     |
| Test condition      | test condition                     | Evaluate condition                   | test -f file.txt                |
| If statement        | if [ condition ]; then ... fi      | Conditional execution                | if [ -f file ]; then echo yes; fi |
| Loops (for)         | for var in list; do ... done       | Loop through list                    | for i in 1 2 3; do echo $i; done |
| Loops (while)       | while [ cond ]; do ... done        | Repeat while condition true          | while true; do echo Hi; done    |
| Crontab Editor      | crontab -e                         | Open cron editor                     | crontab -e                      |
| List Cron Jobs      | crontab -l                         | List user cron jobs                  | crontab -l                      |


---

