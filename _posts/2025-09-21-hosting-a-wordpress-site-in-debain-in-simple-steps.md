---
title: Hosting a WordPress site in Debain in simple steps.
date: 2025-09-21
categories: [linux]
tags:
  - Linux
  - LAMP
  - Wordpress
  - Hands On Lab
description: Hosting a WordPress site in Debain in simple steps.
---


simple step-by-step guide to host a WordPress site on Debian:

[Setup LAMP stack (Linux, Apache, MariaDB/MySQL, PHP) with phpMyAdmin on Debian](https://blogs.janakkumarshrestha0.com.np/posts/linux/installation-of-lamp-along-with-phpmyadmin-on-debian/)

---

##  Steps to Host WordPress blog inside `/var/www/html/blog` in Debain Linux

### 1. Download WordPress

```bash
cd /var/www/html/blog
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xvzf latest.tar.gz
sudo mv wordpress/* .
sudo rm -rf wordpress latest.tar.gz
```
![out](/assets/img/Screenshot_20250922_012506.png)

---

### 2. Create Database for WordPress

```bash
sudo mariadb -u root -p
```

Inside MariaDB:

```sql
CREATE DATABASE wp_blog;
CREATE USER 'janak'@'localhost' IDENTIFIED BY 'janak0ff';
GRANT ALL PRIVILEGES ON wp_blog.* TO 'janak'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

![out](/assets/img/Screenshot_20250922_012342.png)

---

### 3. Configure WordPress

```bash
sudo cp wp-config-sample.php wp-config.php
sudo nano wp-config.php
```

Update:

```php
define( 'DB_NAME', 'wp_blog' );
define( 'DB_USER', 'janak' );
define( 'DB_PASSWORD', 'janak0ff' );
define( 'DB_HOST', 'localhost' );
```

---

### 4. Fix Permissions

```bash
sudo chown -R www-data:www-data /var/www/html/blog
sudo chmod -R 755 /var/www/html/blog
```

---

### 5. Install WordPress

Now open your browser:

 `http://192.168.63.132/blog`

Follow the setup wizard (site title, admin username, password).


![out](/assets/img/Screenshot_20250922_012135.png)
![out](/assets/img/Screenshot_20250922_012234.png)

---

# Thank You