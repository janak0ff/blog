---
title: Make your localhost app live on the internet using ngrok.
date: 2025-05-21
categories: [cloud]
tags:
  - Step-by-Step Guide
  - ngrok
  - local app to cloud
  - Hands on Lab
description: Make your locally hosted any app to internet by using ngrok
---


To make your local Node.js app live on the internet using **ngrok**, follow these steps:

### ✅ Prerequisites:

- Your Node.js app should already be running (e.g., on port `3000` or any other port).
- ngrok installed on your machine.

---

### 🔧 Step-by-Step Guide:

#### 1. **Install ngrok (if not already installed):**

```bash
npm install -g ngrok
```

Or download from: [https://ngrok.com/download](https://ngrok.com/download)

---

#### 2. **Start your Node.js app locally**

For example:

```bash
node app.js
```

Let’s assume it runs on `http://localhost:3000`

---

#### 3. **Sign up for a free ngrok account:**

Go to:
👉 [https://dashboard.ngrok.com/signup](https://dashboard.ngrok.com/signup)

---

#### 4. **Verify your email (if prompted)**

---

#### 5. **Get your authtoken:**

After login, go to:
👉 [https://dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)

You’ll see something like:

```

ngrok config add-authtoken 2S6abc123XYZ....

```

---

#### 6. **Copy and run the command in your terminal:**

```bash
ngrok config add-authtoken YOUR_AUTHTOKEN_HERE
```

> Replace `YOUR_AUTHTOKEN_HERE` with your actual token

---

#### 7. **Now start ngrok again:**

```bash
ngrok http 3000
```

You should now see:

```
Forwarding                    https://abcd1234.ngrok.io -> http://localhost:3000
```

### Click on Visit Site

✅ You're live on internet!
