---
layout: post
title: "Running a PHP and MariaDB App with Nginx on Linux from Scratch"
date: 2025-06-21 18:18 +0545
categories: ["webserver"]
tags: ["nginx", "php", "php-fpm", "mariadb"]
author: sudiplun
excerpt: A step-by-step guide to setting up a basic PHP application with a MariaDB database, served by Nginx on a Linux system.
---

This guide will walk you through setting up a simple web application powered by PHP and MariaDB, with Nginx as the web server on a Linux machine. This is a common stack for web development, often referred to as a LEMP stack (Linux, Nginx, MariaDB/MySQL, PHP).

## 1. Prerequisites: Install Required Packages

First, you need to install all the necessary software. The specific packages may vary slightly between Linux distributions.

**For Debian/Ubuntu systems:**

```bash
sudo apt update
sudo apt install nginx php-fpm php-mysql mariadb-server
```

## 2. Running Required Services

Once the packages are installed, you need to start the services and enable them to launch on boot.

```bash
# Start the services
sudo systemctl start nginx
sudo systemctl start mariadb
sudo systemctl start php-fpm # The service name might vary, e.g., php8.3-fpm

# Enable the services to start at boot
sudo systemctl enable nginx
sudo systemctl enable mariadb
sudo systemctl enable php-fpm
```

## 3. Configure MariaDB

Out of the box, MariaDB is not secure. Let's secure the installation and create a database and user for our application.

First, run the security script:

```bash
sudo mysql_secure_installation
```

Follow the prompts to set a root password, remove anonymous users, disallow remote root login, and remove the test database.

Next, log in to MariaDB as the root user and create a database and user for your app.

```bash
sudo mysql -u root -p
```

Now, execute the following SQL commands:

```sql
-- Create a new database
CREATE DATABASE test_app_db;

-- Create a new user and set a password
CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'your_strong_password';

-- Grant all privileges on the new database to the new user
GRANT ALL PRIVILEGES ON test_app_db.* TO 'testuser'@'localhost';

-- Apply the changes
FLUSH PRIVILEGES;

-- Exit MariaDB
EXIT;
```

## 4. Nginx Virtual Host Configuration

Nginx uses "server blocks" (similar to Apache's "virtual hosts") to manage individual sites. Let's create one for our test application.

Create a new configuration file for your site in `/etc/nginx/sites-available/`:

```bash
sudo nano /etc/nginx/sites-available/test.com
```

Paste the following configuration into the file. This tells Nginx how to handle requests for `test.com` and how to process PHP files.

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name test.com www.test.com;

    # Set the root directory for your project
    root /var/www/html/test;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    # Pass PHP scripts to FastCGI server
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        # Make sure the socket path matches your PHP-FPM version
        fastcgi_pass unix:/run/php/php-fpm.sock; # e.g., /run/php/php8.3-fpm.sock
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    # Deny access to .htaccess files
    location ~ /\.ht {
        deny all;
    }
}
```

Now, enable the site by creating a symbolic link to the `sites-enabled` directory:

```bash
sudo ln -s /etc/nginx/sites-available/test.com /etc/nginx/sites-enabled/
```

Test the Nginx configuration for syntax errors and restart the service:

```bash
sudo nginx -t
sudo systemctl restart nginx
```

## 5. Create a Sample PHP Application

Finally, let's create a simple PHP file to test our database connection.

First, create the project directory defined in our Nginx config:

```bash
sudo mkdir -p /var/www/html/test
sudo chown -R $USER:$USER /var/www/html/test # Temporarily take ownership
```

Now, create an `index.php` file:

```bash
nano /var/www/html/test/index.php
```

Paste the following PHP code. **Remember to replace the database credentials with the ones you created in Step 3.**

```php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PHP & MariaDB Test</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f4f9; color: #333; }
        .container { max-width: 600px; margin: 50px auto; padding: 20px; background: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .status { padding: 15px; border-radius: 5px; font-weight: bold; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
    <div class="container">
        <h1>PHP to MariaDB Connection Test</h1>
        <?php
        $servername = "localhost";
        $username = "testuser"; // <-- Your MariaDB username
        $password = "your_strong_password"; // <-- Your MariaDB password
        $dbname = "test_app_db"; // <-- Your database name

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            die("<div class='status error'>Connection failed: " . htmlspecialchars($conn->connect_error) . "</div>");
        }
        echo "<div class='status success'>Connected successfully to MariaDB!</div>";
        $conn->close();
        ?>
    </div>
</body>
</html>
```

After saving, restore ownership to the web server user so Nginx can read the files:

```bash
sudo chown -R www-data:www-data /var/www/html/test
```

_(Note: The user/group might be `nginx:nginx` on some systems)._

## 6. Testing

To test this locally, you can add an entry to your `/etc/hosts` file to point `test.com` to your local machine:

```
127.0.0.1   test.com
```

Now, open a web browser and navigate to `http://test.com`. You should see a success message indicating that your PHP application has successfully connected to the MariaDB database.
