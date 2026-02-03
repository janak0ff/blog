---
title: Schedule Tasks with Precision with Cron Jobs
date: 2025-05-21
categories: [linux]
tags:
  - Cron Jobs
description: Cron Jobs Cheat Sheet, Email Notification from Cron Jobs, Send Cron Job Emails via Gmail SMTP
---


# 📅 **Cron Jobs Cheat Sheet: Schedule Tasks with Precision**

## 🛠️ **Cron Syntax Format**

```
* * * * * /path/to/command arg1 arg2
│ │ │ │ │
│ │ │ │ └───── Day of the Week (0 - 7) (Sunday = 0 or 7)
│ │ │ └──────── Month (1 - 12)
│ │ └──────────── Day of the Month (1 - 31)
│ └──────────────── Hour (0 - 23)
└──────────────────── Minute (0 - 59)
```

## 🔁 **Special Time Strings**

| String      | Meaning              | Equivalent To |
| ----------- | -------------------- | ------------- |
| `@reboot`   | Run once, at startup | -             |
| `@yearly`   | Once a year          | `0 0 1 1 *`   |
| `@annually` | Same as `@yearly`    | `0 0 1 1 *`   |
| `@monthly`  | Once a month         | `0 0 1 * *`   |
| `@weekly`   | Once a week          | `0 0 * * 0`   |
| `@daily`    | Once a day           | `0 0 * * *`   |
| `@midnight` | Same as `@daily`     | `0 0 * * *`   |
| `@hourly`   | Once an hour         | `0 * * * *`   |

---

## 📋 **Common Cron Job Examples**

### 📂 File & Directory Tasks

| Task                                   | Cron Schedule  | Command                              |
| -------------------------------------- | -------------- | ------------------------------------ |
| Backup `/home` daily at 2 AM           | `0 2 * * *`    | `tar -czf /backup/home.tar.gz /home` |
| Clean tmp folder every day at midnight | `0 0 * * *`    | `rm -rf /tmp/*`                      |
| Sync files every 10 minutes            | `*/10 * * * *` | `rsync -av /source /destination`     |

---

### 💾 System Maintenance

| Task                               | Cron Schedule  | Command                            |
| ---------------------------------- | -------------- | ---------------------------------- |
| Update package list daily at 1 AM  | `0 1 * * *`    | `sudo apt update`                  |
| Reboot system every Sunday at 4 AM | `0 4 * * 0`    | `sudo reboot`                      |
| Monitor disk usage every 30 min    | `*/30 * * * *` | `df -h >> /var/log/disk_usage.log` |

---

### 🧪 Script Execution

| Task                                     | Cron Schedule | Command                         |
| ---------------------------------------- | ------------- | ------------------------------- |
| Run a script at 3 PM every day           | `0 15 * * *`  | `/home/user/myscript.sh`        |
| Run script on the first day of the month | `0 0 1 * *`   | `bash /path/to/monthly_task.sh` |
| Run every 5 minutes                      | `*/5 * * * *` | `/home/user/script.sh`          |

---

### 📈 Logging & Monitoring

| Task                                        | Cron Schedule | Command                             |
| ------------------------------------------- | ------------- | ----------------------------------- |
| Append date to file every Sunday at 6:15 PM | `15 18 * * 0` | `date >> /home/user/sundays.txt`    |
| Log user sessions daily at midnight         | `0 0 * * *`   | `who >> /var/log/user_sessions.log` |

---

### 📧 Email Notification

To send output to your email, add this to the top of your crontab:

```bash
MAILTO="your_email@example.com"
```

Example:

```cron
0 9 * * * /path/to/backup.sh
```

---

## ⚙️ **Crontab Commands**

| Command                | Description                           |
| ---------------------- | ------------------------------------- |
| `crontab -e`           | Edit current user's crontab           |
| `crontab -l`           | List current user's crontab           |
| `crontab -r`           | Remove current user's crontab         |
| `crontab -u [user] -l` | List another user's crontab (as root) |
| `crontab -u [user] -e` | Edit another user's crontab (as root) |

---


## 📬 **Step-by-Step Guide: Email Notification from Cron Jobs**

### ✅ 1. **Install a Mail Transfer Agent (MTA)**

You need an MTA like **`mailutils`** or **`sendmail`**:

* **Ubuntu/Debian:**

  ```bash
  sudo apt update
  sudo apt install mailutils
  ```

* **CentOS/RHEL/Fedora:**

  ```bash
  sudo yum install mailx
  ```

* **Arch Linux:**

  ```bash
  sudo pacman -S mailutils
  ```

---

### ✍️ 2. **Set the `MAILTO` Variable in Your Crontab**

Open your crontab:

```bash
crontab -e
```

At the top, add:

```bash
MAILTO="your_email@example.com"
```

Then write a cron job below it. For example:

```cron
MAILTO="your_email@example.com"
0 5 * * * /home/user/backup.sh
```

This will send **standard output (stdout)** and **standard error (stderr)** of `backup.sh` to your email.

---

### 📁 3. **Ensure Your Script Produces Output**

Only scripts that generate **output** will trigger emails.

Example script:

```bash
#!/bin/bash
echo "Backup started at $(date)"
tar -czf /backup/home.tar.gz /home
echo "Backup completed."
```

---

### 🔧 4. **Test It**

Create a simple script:

```bash
echo -e '#!/bin/bash\necho "Test email from cron at $(date)"' > ~/testcron.sh
chmod +x ~/testcron.sh
```

Add to crontab:

```cron
MAILTO="your_email@example.com"
*/2 * * * * /home/yourusername/testcron.sh
```

Check your email after 2–3 minutes.

---

## 🛠 Troubleshooting

| Problem               | Solution                                                                                         |                                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------- |
| Not receiving mail    | Check your **spam folder**. Also try running the command manually and verify it produces output. |                                                                                                |
| Cron not sending mail | Ensure `mailutils` is installed. Try \`echo "body"                                               | mail -s "Subject" [your\_email@example.com](mailto:your_email@example.com)\` to test manually. |
| External SMTP needed  | Use tools like `msmtp`, `sSMTP`, or configure `postfix` with Gmail SMTP.                         |                                                                                                |

---



## 📬 Step-by-Step: Send Cron Job Emails via Gmail SMTP

---

### ✅ 1. **Create an App Password in Gmail**

> Gmail no longer allows direct login from less secure apps. You must use an **App Password**.

#### Steps:

1. Go to [https://myaccount.google.com/](https://myaccount.google.com/)
2. Enable **2-Step Verification** if not already enabled.
3. Go to **Security > App passwords**
4. Generate a new password (select "Other", name it `cronmail`, click "Generate")
5. Copy the 16-character password — **you’ll need this soon**

---

### ✅ 2. **Install `msmtp` and `msmtp-mta`**

* **Debian/Ubuntu:**

  ```bash
  sudo apt install msmtp msmtp-mta
  ```

* **Arch Linux:**

  ```bash
  sudo pacman -S msmtp
  ```

* **Fedora/RHEL:**

  ```bash
  sudo dnf install msmtp
  ```

---

### ✅ 3. **Configure `msmtp`**

Create a config file:

```bash
mkdir -p ~/.config/msmtp
nano ~/.config/msmtp/config
```

Paste this into the file (replace with your Gmail info):

```ini
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        ~/.config/msmtp/msmtp.log

account        gmail
host           smtp.gmail.com
port           587
from           your_email@gmail.com
user           your_email@gmail.com
password       your_app_password

account default : gmail
```

Replace `your_email@gmail.com` and `your_app_password` accordingly.

> 🛡 **Important**: Secure the file!

```bash
chmod 600 ~/.config/msmtp/config
```

---

### ✅ 4. **Set `msmtp` as the Mailer**

Ensure `mail` command uses `msmtp`. Create or edit this file:

```bash
nano ~/.mailrc
```

Add:

```bash
set sendmail="/usr/bin/msmtp"
set use_from=yes
set realname="Your Name"
set from=your_email@gmail.com
```

---

### ✅ 5. **Test the Setup**

Run this command:

```bash
echo "This is a test from msmtp" | mail -s "Test Email" your_email@gmail.com
```

Check your Gmail inbox!

---

### ✅ 6. **Add to Crontab**

Edit your crontab:

```bash
crontab -e
```

Add this:

```cron
MAILTO="your_email@gmail.com"
* * * * * echo "Hello from cron at $(date)"
```

Check if you receive an email every minute.

---

### 🛠️ Troubleshooting

| Issue                            | Fix                                                                            |
| -------------------------------- | ------------------------------------------------------------------------------ |
| No email received                | Check Gmail spam folder. Check `~/.config/msmtp/msmtp.log` for logs.           |
| TLS errors                       | Make sure `ca-certificates` package is installed and path to certs is correct. |
| Cron output not triggering email | Ensure the command **prints output** (stdout or stderr).                       |

---


## 🧠 **Tips**

* Use **full paths** to commands and scripts.
* Redirect output to a log:
  `command >> /path/to/logfile.log 2>&1`
* Test cron expressions with:
  [https://crontab.guru](https://crontab.guru)

---
