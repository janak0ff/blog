---
title: Django Todo App Deployment - EC2, Virtual Environments, and Docker
date: 2025-07-25
categories: [cloud]
tags:
  - aws
  - Hands On Lab
  - Django app
description: guiding you through deploying your Django todo app on an AWS EC2 instance, covering both traditional virtual environment setup and containerization with Docker.
---


## Add 2 Inbound rule to your EC2 instance.
  * **Rule: Custom TCP (Port 8000/7777):** We'll use this temporarily for testing the Django development server or Docker.
      * Type: `Custom TCP`
      * Port range: `8000` (for virtual env testing) and `7777` (for Docker testing).
      * Source type: `Anywhere`

![out](/assets/img/Screenshot_20250804_173244.png)

### 1\. Connect to Your EC2 Instance via SSH

  ```bash
  ssh -i ~/.ssh/aws-janak.pem  ubuntu@44.202.47.32
  ```
    

### 2\. Prepare the EC2 Server Environment

Once connected via SSH to your EC2 instance:

1.  **Update System Packages:**

    ```bash
    sudo apt update
    sudo apt upgrade -y
    ```

2.  **Install Essential Software:**

    ```bash
    sudo apt install python3.13 python3.13-venv -y
    ```
      * `python3.13-venv`: For creating isolated Python environments.
    

-----

## Deploying with a Python Virtual Environment 🐍


### 1\. Clone Your Django Project

  ```bash
  git clone https://github.com/shreys7/django-todo.git
  cd django-todo
  ```

### 2\. Create and Activate Virtual Environment (on EC2)

1.  **Create:**
    ```bash
    python3 -m venv venv
    ```
2.  **Activate:**
    ```bash
    source venv/bin/activate
    ```
    Your prompt should now show `(venv)` at the beginning, indicating the virtual environment is active.

![out](/assets/img/Screenshot_20250804_161105.png)

If you want to **Deactivate the current virtual environment(Dont do)**
```bash
deactivate
```
Ensure `(venv)` disappears from your prompt.

### 3\. Configure Django Settings

 **Install Core Django:**
  ```bash
  pip install django
  ```


You need to tell Django about your EC2 instance's public IP and prepare it for a production-like environment.

1.  **Open `settings.py`:**
    ```bash
    nano todoApp/settings.py
    ```
2.  **Set `DEBUG = False`:**
    **Never run with `DEBUG = True` in production\! It exposes sensitive information.**
3.  **Add your EC2 Public IP to `ALLOWED_HOSTS`:**
    Find `ALLOWED_HOSTS = []` and add your instance's public IP.
    ```python
    ALLOWED_HOSTS = ['44.202.47.32']
    # Example for all: ALLOWED_HOSTS = ['*']
    ```
    If you get a domain name later, add it here too: `['your_instance_public_ip', 'your-domain.com']`.
4.  **Configure `STATIC_ROOT`:**
    Ensure these lines are present (add `import os` at the top if missing):
    ```python
    import os
    # ... other settings ...
    ```
5.  **Save and Exit:** Press `Ctrl+X`, then `Y`, then `Enter`.

![out](/assets/img/Screenshot_20250804_161344.png)

### 6\. Prepare Database and Static Files

1.  **Collect Static Files:**
    ```bash
    python3 manage.py collectstatic
    ```
    Type `yes` when prompted. This gathers all static assets (CSS, JS, images) into the `staticfiles` folder.
1.  **Apply Migrations:**
    ```bash
    python3 manage.py makemigrations # Only needed if you made model changes
    python3 manage.py migrate
    ```
3.  **Create Superuser:**
    ```bash
    python3 manage.py createsuperuser
    ```
![out](/assets/img/Screenshot_20250804_171012.png)

### 7\. Test with Django's Development Server 

This is just to confirm your app runs before setting up production servers.

1.  **Run the server:**
    ```bash
    python3 manage.py runserver 0.0.0.0:8000
    ```
    You'll see warnings about it being a development server, which is expected.
2.  **Access in browser:** Open your browser and go to `http://44.202.47.32:8000/`.
    *If you get a `DisallowedHost` error, double-check that your EC2 Public IP is correctly added to `ALLOWED_HOSTS` in `settings.py`.*
    *Make sure **Port 8000** is open in your EC2 instance's Inbound Security Group.*

![out](/assets/img/Screenshot_20250804_170706.png)

### 8\. Run in Background with `nohup` (Temporary)

To keep the development server running even after you close your SSH session:

1.  **Stop the current `runserver`** (if running) by pressing `Ctrl+C`.
2.  **Run with `nohup`:**
    ```bash
    nohup python3 manage.py runserver 0.0.0.0:8000 &
    ```
    You'll see a message about output being redirected to `nohup.out`. You can check it with `tail -f nohup.out`.
    *To stop it later: `ps aux | grep 'runserver' | grep -v 'grep'` to find the PID, then `kill <PID>`.*

![out](/assets/img/Screenshot_20250804_175254.png)
-----

## Part 3: Containerizing with Docker

Docker provides a consistent and isolated environment for your app, making deployments more reliable.

### 1\. Create Dockerfile and .dockerignore

  * Your `.dockerignore` file should exclude unnecessary files like `venv/`, `__pycache__/`, `.git/`, `db.sqlite3`, etc.
  ```dockerignore
  # .dockerignore
  venv/
  __pycache__/
  *.pyc
  .git/
  .gitignore
  .DS_Store
  nohup.out
  db.sqlite3
  ```
  * Your `Dockerfile` should look something like this (you've already confirmed you have it):
    ```dockerfile
    # Use an official Python runtime as a parent image
    FROM python:3

    # Set the working directory in the container
    WORKDIR /app

    # Install Django (ideally from requirements.txt, but using direct install for this example)
    RUN pip install django==5.2.4

    # Copy the entire Django project into the container
    # The .dockerignore file will prevent unwanted files like 'venv/' from being copied
    COPY . .

    # Run database migrations
    RUN python3 manage.py migrate

    # Expose the port that the Django development server will listen on
    EXPOSE 7777

    # Define the command to run the application
    # We'll use port 8001 for the Dockerized version to distinguish it
    CMD ["python3","manage.py", "runserver", "0.0.0.0:7777"]
    ```
 
### 2\. Build the Docker Image

On your **EC2 instance**, in your project's root:

```bash
sudo docker build -t django-todo-app .
```

  * This command reads your `Dockerfile` and creates a Docker image named `django-todo-app`.

### 3\. Run the Docker Container

To run your app in a Docker container in the background:

```bash
sudo docker run -d -p 7777:7777 django-todo-app
```

  * `-d`: Runs the container in "detached" (background) mode.
  * `-p 7777:7777`: Maps port 8001 on your EC2 instance (host) to port 8001 inside the container.

### 4\. Verify and Access Your Dockerized App

1.  **Check if the container is running:**
    ```bash
    sudo docker ps
    ```
    You should see your `django-todo-app` container listed with a `Status` of "Up...".

![out](/assets/img/Screenshot_20250804_172754.png)

2.  **Access in browser:** Ensure **Port 8001** is open in your EC2 Security Group. Then, open your web browser and go to `http://44.202.47.32:7777/todos/`.

![out](/assets/img/Screenshot_20250804_172945.png)

-----
###  Prepare Your Local Project for Deployment


1.  **Generate `requirements.txt` (on your LOCAL machine):**
      * Navigate to your project's root on your local machine.
      * If you have a local virtual environment, activate it.
      * Run:
        ```bash
        pip freeze > requirements.txt
        ```
![out](/assets/img/Screenshot_20250804_174944.png)   

###  Install Dependencies

1.  **Install from `requirements.txt`:**
    ```bash
    pip install -r requirements.txt
    ```
    *If `pip` command doesn't work directly (e.g., `Command 'pip' not found`), use `python3 -m pip install -r requirements.txt` instead.*
-----

![out](/assets/img/Screenshot_20250804_175444.png)

-----

## What's Next for Production?

While your app is now accessible, remember the warnings about using the Django development server. For a truly production-ready setup, you would:

1.  **Replace `runserver` with Gunicorn:** Update your `Dockerfile`'s `CMD` to use Gunicorn.
2.  **Implement Nginx as a Reverse Proxy:** Configure Nginx on your EC2 instance to serve static files directly and forward dynamic requests to Gunicorn. This is crucial for performance and security.
3.  **Use a Production Database:** Migrate from SQLite to a robust database like PostgreSQL, ideally using AWS RDS for managed services.
4.  **Set up HTTPS (SSL/TLS):** Secure your application with an SSL certificate (e.g., using Certbot with Let's Encrypt).
5.  **Environment Variables:** Store sensitive data (like Django's `SECRET_KEY`, database credentials) using environment variables or AWS Secrets Manager, not directly in `settings.py`.
