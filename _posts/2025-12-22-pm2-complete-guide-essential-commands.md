---
title: PM2 Complete Guide & Essential Commands
date: 2025-12-22
categories: [utils]
tags:
  - Node.js
  - PM2
description: PM2 Complete Guide & Essential Commands.
---

# Complete Guide to PM2: Theory, Installation & Essential Commands

If you run Node.js applications on a Linux server, you need a process manager that keeps your app running 24/7, restarts automatically on crashes, handles logs, and survives system reboots.
**PM2** is the most popular tool for that.

This guide covers everything:
✔ What PM2 is
✔ Why developers use it
✔ How to install it
✔ How to start/stop/manage apps
✔ All essential PM2 commands you need daily
✔ Setting up PM2 to run applications on system startup
✔ Advanced ecosystem configuration

---

##  What is PM2?

**PM2 (Process Manager 2)** is a production-grade process manager for Node.js applications. It ensures your app:

* Stays running **even after crashes**
* Automatically restarts after **server reboot**
* Runs multiple apps concurrently
* Monitors CPU & RAM usage
* Provides live logs
* Supports zero-downtime reloads

PM2 is widely used in MERN, MEAN, Express.js APIs, Next.js, Vite, and other Node-based applications.

---

## 🧠 How PM2 Works (Simple Theory)

PM2 sits between your app and the operating system:

```
User → PM2 → Node.js App → System
```

Key responsibilities:

### 1️⃣ **Process Management**

PM2 starts your app and keeps it alive.
If the app crashes, PM2 restarts it instantly.

### 2️⃣ **Monitoring**

PM2 monitors CPU/RAM and gives you live dashboards.

### 3️⃣ **Logging**

It merges stdout and stderr logs:

```
~/.pm2/logs/
```

### 4️⃣ **Auto-Restart on Boot**

PM2 generates a startup script so your app launches after reboot.

### 5️⃣ **Clustering (Optional)**

PM2 can run your app in multiple instances to use all CPU cores:

```sh
pm2 start app.js -i max
```

---

# 🛠️ Installing PM2

You only need Node.js + npm installed.

### Install globally:

```sh
npm install -g pm2
```

Check version:

```sh
pm2 -v
```

You're ready to use PM2.

---

# 🚀 Starting Apps with PM2

### Start a Node.js app:

```sh
pm2 start app.js
```

### Start with a custom name:

```sh
pm2 start app.js --name api
```

### Start an app using an npm script (React, Vite, Next.js, MERN frontend)

```sh
pm2 start npm --name frontend -- run dev
```

### Start MERN backend:

```sh
pm2 start npm --name backend -- run dev
```

### Start with environment variables:

```sh
pm2 start app.js --env production
```

### Start in cluster mode (using all CPU cores):

```sh
pm2 start app.js -i max
```

---

# 📌 Essential PM2 Commands (Cheat Sheet)

The most complete list for practical usage:

---

## 🔵 Process Management

### Start:

```sh
pm2 start app.js
pm2 start npm --name frontend -- run dev
```

### Stop:

```sh
pm2 stop app
pm2 stop all
```

### Restart:

```sh
pm2 restart app
pm2 restart all
```

### Reload (zero-downtime restart for cluster mode):

```sh
pm2 reload app
```

### Delete (stop + remove from PM2):

```sh
pm2 delete app
pm2 delete all
```

### Pause (stop accepting new connections):

```sh
pm2 pause app
```

### Resume:

```sh
pm2 resume app
```

---

## 🔵 Monitoring & Logs

### List running apps:

```sh
pm2 list
pm2 ls
```

### Show process details:

```sh
pm2 show app
```

### Detailed info:

```sh
pm2 describe app
```

### View logs:

```sh
pm2 logs
pm2 logs app
```

### View last 200 lines:

```sh
pm2 logs --lines 200
```

### Stream logs in real-time:

```sh
pm2 logs --raw
```

### Clear logs:

```sh
pm2 flush
pm2 flush app  # specific app
```

### Real-time monitoring dashboard:

```sh
pm2 monit
```

### Generate process list in JSON format:

```sh
pm2 jlist
```

### Display process metrics:

```sh
pm2 show app
```

---

## 🔵 System Startup Configuration

One of PM2's most powerful features is keeping your applications running after system reboots. Here's how to set it up:

### Step 1: Generate startup script

```sh
pm2 startup
```

This command will output a command you need to run with sudo. Example output:
```
[PM2] Init System found: systemd
[PM2] To setup the Startup Script, copy/paste the following command:
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u yourusername --hp /home/yourusername
```

**Copy and run the command it shows!**

### Step 2: Save current process list

After starting your applications, save the current PM2 process list:

```sh
pm2 save
```

This creates a dump file at `~/.pm2/dump.pm2`

### Step 3: Verify startup configuration

Check if startup is configured:

```sh
pm2 startup status
```

### Step 4: Update saved processes

If you add or remove applications, save the new configuration:

```sh
pm2 save
```

### Step 5: Disable startup (if needed)

```sh
pm2 unstartup
```

### Step 6: Manual restoration

If you need to restore saved processes without a reboot:

```sh
pm2 resurrect
```

### Important Notes:

1. **User-specific**: The startup script runs for the specific user who set it up
2. **PATH issues**: If you get "command not found" after reboot, ensure Node.js is in the system PATH
3. **Test reboot**: Always test with `sudo reboot` on a staging server first
4. **Multiple users**: Each user needs their own PM2 instance and startup configuration

---

## 🔵 Cluster Mode

### Start in cluster mode with max instances:

```sh
pm2 start app.js -i max
```

### Start with specific number of instances:

```sh
pm2 start app.js -i 4
```

### Scale up/down cluster:

```sh
pm2 scale app +2  # Add 2 instances
pm2 scale app -1  # Remove 1 instance
pm2 scale app 4   # Set to exactly 4 instances
```

### Reload cluster (zero downtime):

```sh
pm2 reload app
```

---

## 🔵 Environment Management

### Set environment variables:

```sh
pm2 start app.js --env production
```

### List environments:

```sh
pm2 env
```

### Get environment for specific app:

```sh
pm2 show app
```

### Update environment variables:

```sh
pm2 restart app --update-env
```

---

## 🔵 Maintenance Commands

### Completely kill PM2 daemon:

```sh
pm2 kill
```

### Update PM2 to latest version:

```sh
pm2 update
```

### Get PM2 version:

```sh
pm2 --version
```

### Show PM2 help:

```sh
pm2 --help
```

### Generate a sample ecosystem file:

```sh
pm2 init
```

---

## 🔵 Advanced Log Management

### Disable logging for an app:

```sh
pm2 start app.js --no-logs
```

### Merge logs from all instances:

```sh
pm2 start app.js --merge-logs
```

### Specify log file location:

```sh
pm2 start app.js --log /var/log/myapp.log
```

### Set log file size limit:

```sh
pm2 start app.js --max-memory-restart 200M
```

---

# 🎯 Bonus: Use PM2 with an Ecosystem File

For production deployments, use an ecosystem file for better configuration management.

### Generate an ecosystem file:

```sh
pm2 init
```

### Example ecosystem.config.js (MERN stack):

```javascript
module.exports = {
  apps: [
    // Backend API (Express.js)
    {
      name: "backend",
      script: "npm",
      args: "run start",
      cwd: "./backend",
      instances: "max",  // Use all CPU cores
      exec_mode: "cluster",
      env: {
        NODE_ENV: "development",
        PORT: 5000,
        MONGODB_URI: "mongodb://localhost:27017/mernapp"
      },
      env_production: {
        NODE_ENV: "production",
        PORT: 5000,
        MONGODB_URI: "mongodb://production-db:27017/mernapp"
      },
      log_date_format: "YYYY-MM-DD HH:mm Z",
      error_file: "/var/log/backend-error.log",
      out_file: "/var/log/backend-out.log",
      merge_logs: true,
      max_memory_restart: "1G",
      watch: false,  // Set to true for development auto-restart
      ignore_watch: ["node_modules", "logs"]
    },
    
    // Frontend (React/Next.js)
    {
      name: "frontend",
      script: "npm",
      args: "run start",
      cwd: "./frontend",
      instances: 1,
      env: {
        NODE_ENV: "development",
        PORT: 3000,
        REACT_APP_API_URL: "http://localhost:5000"
      },
      env_production: {
        NODE_ENV: "production",
        PORT: 3000,
        REACT_APP_API_URL: "https://api.yourdomain.com"
      },
      error_file: "/var/log/frontend-error.log",
      out_file: "/var/log/frontend-out.log",
      max_memory_restart: "512M"
    }
  ]
};
```

### Start all apps from ecosystem file:

```sh
pm2 start ecosystem.config.js
```

### Start with production environment:

```sh
pm2 start ecosystem.config.js --env production
```

### Stop all apps from ecosystem file:

```sh
pm2 stop ecosystem.config.js
```

### Delete all apps from ecosystem file:

```sh
pm2 delete ecosystem.config.js
```

### Reload all apps (zero downtime):

```sh
pm2 reload ecosystem.config.js
```

---

# 🔧 Common Issues & Solutions

### Issue 1: PM2 not starting on reboot
**Solution**: 
```sh
# Remove existing startup
pm2 unstartup

# Recreate with correct user
pm2 startup

# Run the displayed command with sudo
# Save current processes
pm2 save
```

### Issue 2: Applications not running after PM2 save
**Solution**: Ensure paths are absolute in your start commands or ecosystem file.

### Issue 3: Permission denied errors
**Solution**: 
```sh
# Check PM2 logs
pm2 logs

# Run PM2 with correct permissions
sudo chown -R $USER:$USER ~/.pm2
```

### Issue 4: Environment variables not loading
**Solution**: Use ecosystem file with env_production section and start with:
```sh
pm2 start ecosystem.config.js --env production
```

### Issue 5: Memory leaks causing crashes
**Solution**: Set memory limits:
```sh
pm2 start app.js --max-memory-restart 500M
```

---

# 📊 PM2 Monitoring & Metrics

### Install PM2 monitoring module:

```sh
pm2 install pm2-logrotate  # Automatically rotate logs
pm2 install pm2-server-monit  # Server monitoring
```

### Setup log rotation (prevents disk space issues):

```sh
pm2 set pm2-logrotate:max_size 10M  # Max log file size
pm2 set pm2-logrotate:retain 30     # Keep last 30 files
pm2 set pm2-logrotate:compress true # Compress rotated logs
```

### Monitor key metrics:

```sh
# Real-time dashboard
pm2 monit

# Show app metrics
pm2 show app

# Generate metrics in JSON
pm2 jlist
```

---

# 🧾 Summary

PM2 is a must-have tool for running production Node.js applications. It keeps apps alive, handles logs, manages restarts, and offers monitoring — all while being extremely easy to use.

### What you learned:

✔ What PM2 is and how it works  
✔ How to install PM2 globally  
✔ How to manage applications (start, stop, restart, delete)  
✔ How to monitor logs and performance  
✔ **How to configure auto-start on system reboot**  
✔ How to use ecosystem files for complex setups  
✔ How to run applications in cluster mode  
✔ How to handle common issues  
✔ Every essential PM2 command for daily operations  

### Pro Tips:

1. **Always use ecosystem files** for production deployments
2. **Set up log rotation** to prevent disk space issues
3. **Test auto-start** configuration on a staging server
4. **Use cluster mode** for Node.js applications to maximize CPU usage
5. **Monitor memory usage** and set appropriate limits
6. **Save your configuration** after any changes with `pm2 save`

Use this guide as your go-to reference whenever you deploy MERN or Node.js apps to production. With PM2 properly configured, your applications will run reliably 24/7, surviving crashes and system reboots automatically.

---

## 📚 Additional Resources

- [PM2 Official Documentation](https://pm2.keymetrics.io/docs/usage/quick-start/)
- [PM2 GitHub Repository](https://github.com/Unitech/pm2)
- [Node.js Production Best Practices](https://nodejs.org/en/docs/guides/nodejs-production-best-practices/)
- [Linux Systemd for Node.js Services](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-20-04)

Now you're equipped to run your Node.js applications in production with confidence! 🚀