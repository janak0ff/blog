---
title: Expose Your Localhost app to the Internet with Custom domain using Cloudflare Tunnel
date: 2025-05-21
categories: [cloud]
tags:
  - Setup Guide
  - cloudflare
  - local app to cloud
  - Hands on Lab
description: You’ll expose your local site (like your localhost site) directly through your own domain using cloudflared, without needing ngrok at all.
---


Since you **can’t use a custom domain with the free ngrok plan**, but your domain is hosted on **Cloudflare**, here’s a **fully free, reliable alternative**:

---

## Use **Cloudflare Tunnel** — 100% FREE, allows custom domains

You’ll expose your localhost app **directly through your own domain** using `cloudflared`.

---

### Goal:

To expose your local app (e.g. running on `http://localhost:3000`) to:

```
https://subdomain.yourdomain.com
```

e.g.

```
https://local.janakkumarshrestha0.com.np
```

---

### Step-by-Step: Use Cloudflare Tunnel with Custom Domain

#### 1. **Make sure your domain is on Cloudflare**

- Go to [https://dash.cloudflare.com](https://dash.cloudflare.com)
- Ensure your `.com.np` domain is added and uses Cloudflare's nameservers.

---

#### 2. **Install cloudflared on your machine**

For Debian/Ubuntu-based systems:

```bash
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
```

---

#### 3. **Authenticate cloudflared with Cloudflare**

```bash
cloudflared tunnel login
```

This opens a browser. Log in to your Cloudflare account and authorize.

---

#### 4. **CCreate a new tunnel. You can name it whatever you like**

```bash
cloudflared tunnel create mytunnel
```

This will generate a `credentials-file` and `tunnel ID` inside `/home/USERNAME/.cloudflared/`.

---

#### 5. **Create a config file**

Create the file:

```bash
sudo mkdir -p /etc/cloudflared
sudo nano /etc/cloudflared/config.yml
```

Paste this, replacing the values:

```yaml
tunnel: YOUR_TUNNEL_ID
credentials-file: /home/YOUR_USERNAME/.cloudflared/YOUR_TUNNEL_ID.json

ingress:
  - hostname: local.janakkumarshrestha0.com.np
    service: http://localhost:3000
  - service: http_status:404
```

Replace:

- `YOUR_TUNNEL_ID` with your actual tunnel ID
- `YOUR_USERNAME` with your Linux username
- `service` with your running any application on http://localhost:PORR_NO
- `local.janakkumarshrestha0.com.np` with the custom subdomain you want

---

#### 6. **Route DNS through the tunnel**

```bash
cloudflared tunnel route dns mytunnel local.janakkumarshrestha0.com.np
```

Cloudflare will automatically add the correct DNS record (`CNAME`).

---

#### 7. **Start the tunnel**

```bash
cloudflared tunnel run mytunnel
```

---

### DONE! Your local site is now live at:

```
https://local.janakkumarshrestha0.com.np
```

---

### Optional: Auto-start the tunnel at boot

You can enable the tunnel as a system service:

```bash
sudo cloudflared service install
sudo systemctl start cloudflared
sudo systemctl enable cloudflared
sudo systemctl status cloudflared
```

---

###  Secure with Access Rules (Optional)

You can protect your tunnel with Cloudflare Access (Google login, OTP, etc.) — all free.

---
