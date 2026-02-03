---
title: Installation of LAMP along with PHPMyAdmin on Debian in simple steps.
date: 2025-09-21
categories: [linux]
tags:
  - Linux
  - LAMP
  - Hands On Lab
description: set up a LAMP stack (Linux, Apache, MariaDB/MySQL, PHP) with phpMyAdmin on Debian step by step.
---


Set up a LAMP stack (Linux, Apache, MariaDB/MySQL, PHP) with phpMyAdmin on Debian step by step.

## 🔹 Install Apache Web Server

```bash
sudo apt install apache2 -y
```

Enable and start:

```bash
sudo systemctl enable apache2
sudo systemctl start apache2
```

Test: Open `http://192.168.63.132` in a browser. You should see the Apache default page.

![out](/assets/img/Screenshot_20250922_001138.png)

---

## 🔹 Install MariaDB (or MySQL)

```bash
sudo apt install mariadb-server -y
```

Secure the installation:

```bash
sudo mysql_secure_installation
```

* Set root password
* Remove anonymous users
* Disallow root login remotely
* Remove test database
* Reload privileges

👉 Login to test:

```bash
sudo mariadb -u root -p
```

* `mariadb` → start the MariaDB client (command-line tool)
* `-u root` → log in as the **root user**
* `-p` → ask for the password

---

## 🔹 Install PHP

```bash
sudo apt install php libapache2-mod-php php-mysql -y
```

* `libapache2-mod-php` → lets Apache run PHP files
* `php-mysql` → allows PHP to talk to MySQL/MariaDB

Check PHP version:

```bash
php -v
```
---

## 🔹 Install phpMyAdmin

```bash
sudo apt install phpmyadmin -y
```

During installation:

* Choose `apache2` when asked for web server.
* Select "Yes" to configure database for phpMyAdmin.
* Set a password for phpMyAdmin.


---

###  Enable phpMyAdmin in Apache

On Debian, the installer does **not** always add the config automatically. You need to enable it:

```bash
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/phpmyadmin.conf
```

That command creates a **symbolic link** so Apache knows about phpMyAdmin’s configuration.

* `ln -s` → makes a symlink (shortcut)
* `/etc/phpmyadmin/apache.conf` → the original phpMyAdmin config file
* `/etc/apache2/conf-enabled/phpmyadmin.conf` → where Apache looks for enabled configs

Then reload Apache:

```bash
sudo systemctl reload apache2
```

---

## 🔹 Access phpMyAdmin

Open in browser:

```
http://192.168.63.132/phpmyadmin
```

Login with MariaDB username/password.

![out](/assets/img/Screenshot_20250922_001847.png)

---


# Thank You