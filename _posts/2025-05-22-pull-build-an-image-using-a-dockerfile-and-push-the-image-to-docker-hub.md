---
title: Pull, Build an image using a Dockerfile and Push the image to Docker Hub.
date: 2025-05-22
categories: [docker]
tags:
  - Containers and Containerization
  - Docker
  - Hands On Lab
description: Pull an image from Docker Hub and run it as a container. Build an image using a Dockerfile and Run the image as a container. Push the image to Docker Hub.
---


## **Pull an image from Docker Hub and run it as a container**

---

## 🧰 Prerequisites

- You have **Docker installed** on your machine.
  - Check with: `docker --version`
  - If not installed, follow the official Docker installation guide for your OS: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)
  ```
  sudo apt install docker.io -y
  ```

---

### ✅ Add user to the `docker` group for avoid typing sudo on every command.

Run the following command **once** with `sudo`:

```bash
sudo usermod -aG docker $USER
```

Then, **log out and log back in** (or reboot) for the group changes to take effect.

For immediately:

```bash
newgrp docker
```

---

### 🔹 Pull an Image from Docker Hub

Use the `docker pull` command:

```bash
docker pull hello-world
```

#### 💡 Explanation:

- `docker`: The main Docker CLI command.
- `pull`: Tells Docker to download an image from Docker Hub.
- `hello-world`: The name of the image to pull.

> This pulls the official `hello-world` image, which is small and used for testing Docker installations.

---

### 🔹  List Images on Your Machine

After pulling the image, check if it was successfully downloaded:

```bash
docker images
```

#### 💡 Output will look like this:

```
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    d1165f22117a   2 months ago   13.3kB
```

#### 💡 Explanation:

- `REPOSITORY`: Name of the image (`hello-world`)
- `TAG`: Version tag (default is `latest`)
- `IMAGE ID`: Unique identifier for the image
- `SIZE`: Size of the image

---

### 🔹 Run the Image as a Container

Now, run the image using the `docker run` command:

```bash
docker run hello-world
```

#### 💡 Explanation:

- `run`: Tells Docker to create and start a new container from the specified image.
- `hello-world`: The image to use for creating the container.

#### 💡 What Happens?

- Docker checks if the image exists locally.
- If yes (which it does), it starts a new container from that image.
- The container runs the default command defined in the image (in this case, prints a welcome message).

You should see output like:

```
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

---

### 🔹 List Running Containers

To see containers currently running:

```bash
docker ps
```

But since `hello-world` exits immediately after printing the message, it won't show up here.

#### To see **all containers**, including stopped ones:

```bash
docker ps -a
```

#### 💡 Output will look like:

```
CONTAINER ID   IMAGE         COMMAND    ...   STATUS                     NAMES
abc123xyz      hello-world   "/hello"   ...   Exited (0) 10 seconds ago   youthful_banach
```

---

### 🔹 Optional: Remove the Container

If you want to clean up:

```bash
docker rm abc123xyz
```

Replace `abc123xyz` with your actual container ID or name.

---

### 🔹 Optional: Remove the Image

To remove the image from your system:

```bash
docker rmi hello-world
```

---

## 📌 Summary of Commands

| Command                 | Description                                   |
| ----------------------- | --------------------------------------------- |
| `docker pull <image>`   | Downloads an image from Docker Hub            |
| `docker images`         | Lists all images on your system               |
| `docker run <image>`    | Runs an image as a container                  |
| `docker ps`             | Lists running containers                      |
| `docker ps -a`          | Lists all containers (including stopped ones) |
| `docker rm <container>` | Removes a specific container                  |
| `docker rmi <image>`    | Removes a specific image                      |

---

## 🎯 Example with Another Image (nginx Web Server)

Let’s try something more practical — running a real web server:

```bash
docker run -d -p 8080:80 nginx
```

#### 💡 Explanation:

- `-d`: Run container in **detached mode** (in background)
- `-p 8080:80`: Map port 8080 (your computer) to port 80 (inside the container)
- `nginx`: Official NGINX image

Now open your browser and go to:  
👉 [http://localhost:8080](http://localhost:8080)  
You should see the NGINX welcome page!

---

### If you're encountering this port error:

```
Bind for 0.0.0.0:8080 failed: port is already allocated
```

### 🔍 What does this mean?

This error occurs because **port `8080` on your machine is already being used by another process**, so Docker can't bind to it.

---

## ✅ Step-by-Step Fix

### 🪛 Find the Process Using Port 8080

Run this command in your terminal:

```bash
sudo lsof -i :8080
```

Or if you don't have `lsof`, use:

```bash
sudo netstat -tulpn | grep :8080
```

#### Example Output:

```
COMMAND   PID   USER    FD   TYPE DEVICE SIZE/OFF NODE NAME
node    12345   user   20u  IPv6 123456      0t0  TCP *:8080 (LISTEN)
```

Here, the process with **PID 12345** is using port 8080.

---

### 🚫 Stop the Conflicting Process

Use the `kill` command with the PID from above:

```bash
sudo kill -9 12345
```

> Replace `12345` with the actual PID you found.

⚠️ Be careful not to kill important system processes. Make sure you know what the process is before killing it.

---

### ▶️  Try Running the Docker Command Again

Now try starting NGINX again:

```bash
docker run -d -p 8080:80 nginx
```

It should now work and return a container ID like:

```
a14767df4f989392399558bee003840abe43350569edbe2c121ca304a683f1af
```

You can verify it's running with:

```bash
docker ps
```

And visit [http://localhost:8080](http://localhost:8080) in your browser.

---

## 🔄 Alternative: Use a Different Host Port

If you don’t want to stop the existing service using port 8080, you can map NGINX to a different port on your host — for example, `8000`:

```bash
docker run -d -p 8000:80 nginx
```

Then open:

👉 [http://localhost:8000](http://localhost:8000)

---

## 🧹 Optional: Clean Up Unused Containers/Ports

To avoid future conflicts, clean up unused containers:

```bash
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
```

> ⚠️ This will remove all running/stopped containers! Only do this if you’re okay with that.

---



## Build an image using a Dockerfile and Run the image as a container

---

## 📁 Create a Project Directory

Open your terminal and create a new folder for your project:

```bash
mkdir my-docker-app
cd my-docker-app
```

This will be the working directory where you’ll create your `Dockerfile` and application files.

---

## 📄  Create a Simple Application

For this example, we'll create a very simple **Python web app** using Flask.

### 🔹 Create a file named `app.py`:

```bash
nano app.py
```

Now paste the following code:

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Docker!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
```

This is a basic Flask app that responds with `"Hello from Docker!"` when accessed via a browser.

---

## 🐳  Create a Dockerfile

A `Dockerfile` is a script containing instructions to build a Docker image.

Create the Dockerfile:

```bash
nano Dockerfile
```

Now paste the following code:

```Dockerfile
# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy only the application file
COPY app.py /app/

# Install Flask directly
RUN pip install --no-cache-dir flask

# Expose the Flask default port
EXPOSE 5000

# Optional environment variable
ENV NAME="Docker"

# Run the application
CMD ["python", "app.py"]
```

---

## 🏗️ Build the Docker Image

From inside your project directory (`my-docker-app`), run:

```bash
docker build -t my-flask-app .
```

#### 💡 Explanation:

- `docker build`: Command to build an image.
- `-t my-flask-app`: Tags the image with a name (`my-flask-app`).
- `.`: Tells Docker to use the current directory as the build context (where it looks for files like `Dockerfile`, `app.py`, etc.).

You’ll see output showing each step being executed — downloading Python, installing Flask, copying files, etc.

---

## ▶️ Run the Container

Once the image is built, run it as a container:

```bash
docker run -d -p 5000:5000 my-flask-app
```

#### 💡 Explanation:

- `-d`: Run the container in **detached mode** (in background).
- `-p 5000:5000`: Map port `5000` on your host to port `5000` in the container.
- `my-flask-app`: The image to run.

---

## 🌍 Test the App

Open your browser and go to:

👉 [http://localhost:5000](http://localhost:5000)

You should see:

```
Hello from Docker!
```

![Output-Dockerfile](/_imgs/post/Build-image-Dockerfile.png)

🎉 You've successfully built a Docker image and run a web app inside a container!

---

## 🗑️ Optional: Clean Up

To stop and remove the container:

```bash
docker stop <container_id>
docker rm <container_id>
```

Use `docker ps` to find the container ID.

---

## 📋 Summary of Key Commands

| Command                                                 | Description                                                     |
| ------------------------------------------------------- | --------------------------------------------------------------- |
| `docker build -t <image-name> .`                        | Builds a Docker image using the Dockerfile in current directory |
| `docker run -d -p <host-port>:<container-port> <image>` | Runs a container from the image                                 |
| `FROM <base-image>`                                     | Base image to start from (e.g., Python, Ubuntu)                 |
| `WORKDIR /path`                                         | Sets the working directory inside the container                 |
| `COPY . /app`                                           | Copies files from local machine to container                    |
| `RUN <command>`                                         | Runs a shell command during image build                         |
| `EXPOSE <port>`                                         | Documents which port the container listens on                   |
| `CMD ["cmd", "arg1"]`                                   | Default command to run when container starts                    |

---

## ✅ Bonus Tip: Best Practices

- Always use `.dockerignore` to exclude unnecessary files (like `__pycache__`, `.git`, `venv`, etc.)
- Avoid installing unnecessary dependencies
- Use multi-stage builds for more complex apps (advanced topic)

---

## **Push the docker image to Docker Hub**

---

## 🔐 Log in to Docker Hub

In your terminal, run:

```bash
docker login
```

You’ll be prompted to enter your **Docker Hub username and password**.

#### Example:

```bash
Username: your-dockerhub-username
Password: **********
Login Succeeded
```

✅ If successful, you’re now logged in and ready to push images.

---

## 🏗️ Tag Your Image with Docker Hub Username

Before pushing an image to Docker Hub, you need to **tag it with your Docker Hub username**, like this:

```bash
docker tag my-flask-app your-dockerhub-username/my-flask-app
```

> Replace `your-dockerhub-username` with your actual Docker Hub username.

#### 💡 Explanation:

- `docker tag`: Renames or tags an existing image.
- `my-flask-app`: The local image name you built earlier.
- `your-dockerhub-username/my-flask-app`: The new name for Docker Hub.

You can verify the tagging by running:

```bash
docker images
```

You should see both `my-flask-app` and `your-dockerhub-username/my-flask-app` listed.

---

## 🚀  Push the Image to Docker Hub

Now push your image:

```bash
docker push your-dockerhub-username/my-flask-app
```

This uploads the image to Docker Hub.

#### Example Output:

```
The push refers to repository [docker.io/your-dockerhub-username/my-flask-app]
...
Pushed
latest: digest: sha256:... size: ...
```

![Output-docker image push to docker hub](/_imgs/post/docker-image-pull-to-dockerhub.png)

✅ Success! Your image is now available on Docker Hub.

---

## 🌍 Test Pulling Your Image from Docker Hub

To confirm everything works, stop and remove your local image:

```bash
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi your-dockerhub-username/my-flask-app
docker rmi my-flask-app
```

Then pull it back from Docker Hub:

```bash
docker pull your-dockerhub-username/my-flask-app
```

And run it:

```bash
docker run -d -p 5000:5000 your-dockerhub-username/my-flask-app
```

Go to [http://localhost:5000](http://localhost:5000) — you should still see:

```
Hello from Docker!
```

🎉 You’ve successfully pushed your image to Docker Hub and pulled it again!

---

## 📋 Summary of Key Commands

| Command                                      | Description                    |
| -------------------------------------------- | ------------------------------ |
| `docker login`                               | Log in to Docker Hub           |
| `docker tag <local-image> <username>/<repo>` | Tag image for Docker Hub       |
| `docker push <username>/<repo>`              | Upload image to Docker Hub     |
| `docker pull <username>/<repo>`              | Download image from Docker Hub |

---

## 📝 Optional: Add a Tag (e.g., Version)

Instead of always using `latest`, you can version your image:

```bash
docker tag my-flask-app your-dockerhub-username/my-flask-app:v1.0
docker push your-dockerhub-username/my-flask-app:v1.0
```

Then pull with:

```bash
docker pull your-dockerhub-username/my-flask-app:v1.0
```

---

## 🧼 Bonus: Clean Up Local Images

To free up space:

```bash
docker images prune -a
```

Or just remove specific images:

```bash
docker rmi your-dockerhub-username/my-flask-app
```

---
