---
layout: post
title: "Handful sql command"
date: 2025-12-01 11:28 +0545
categories: ["database"]
tags: ["mariadb", "mysql"]
author: sudiplun
excerpt:
---

### handful sql command

**user management**
```mysql
-- change user password
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
-- remove user from db
DROP USER 'username'@'host';
-- See all the mysql user with host
SELECT User, Host FROM mysql.user;
-- change user host
RENAME USER 'old_username'@'old_host' TO 'new_username'@'new_host';
-- all from 10.0.0.0/24 subnet
RENAME USER 'zabbix'@'localhost' TO 'zabbix'@'10.0.0.*';

```

### Create a database with a character set and allow users to access it using the newly created user.

```mysql
CREATE DATABASE nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloudUser'@'localhost' IDENTIFIED BY 'newpassword';
-- Apply the changes
FLUSH PRIVILEGES;
```
