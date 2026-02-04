---
title: .com.np Domain + Cloudflare + Netlify (Adding domain and subdomain to your netlify hosted project) - Full Configuration Guide
date: 2025-07-03
categories: [cloud]
tags:
  - Step-by-Step Guide
  - Netlify
  - Domain Configure
  - Hands on Lab
description: This guide shows Nepali citizens how to claim a free, lifetime .com.np domain from register.com.np, set up powerful DNS with Cloudflare, and seamlessly deploy web projects (including subdomains!) to Netlify. Go live, for free!
---




This guide shows Nepali citizens how to claim a free, lifetime .com.np domain from register.com.np, set up powerful DNS with Cloudflare, and seamlessly deploy web projects (including subdomains!) to Netlify. Go live, for free!

---

## How to Get Your Free Nepali Lifetime Domain (from `register.com.np`), Host it on Cloudflare, and Deploy to Netlify

Are you a Nepali citizen looking to establish your online presence with a personalized domain name, perhaps for your portfolio, blog, or a personal project? Did you know that the Nepali company **`register.com.np` offers a unique opportunity for Nepali citizens to register a domain name under their legal name (e.g., `yourname.com.np`) with lifetime validity, completely free of charge?**

This is an incredible benefit! However, once you have your domain, the next steps of connecting it to a powerful DNS service like Cloudflare and then linking it to a modern hosting platform like Netlify can seem a bit daunting. This guide will walk you through the entire process, step-by-step.

We'll cover:
1.  **Getting your free lifetime `.com.np` domain** from `register.com.np`.
2.  **Setting up Cloudflare** as your robust DNS manager.
3.  **Connecting your Cloudflare-managed domain to your Netlify project** for seamless deployment.

Let's dive in!

### Part 1: Registering Your Free Lifetime `.com.np` Domain (via `register.com.np`)

The process of acquiring your `yourname.com.np` domain is straightforward:

Follow this guide:- [How to Register .com.np Domain in 2025 (Updated Method)](https://www.youtube.com/watch?v=-4Lr5yeFw48)

1.  **Visit `register.com.np`:** Go to the official website: `https://register.com.np/`
2.  **Check Domain Availability:** Use their search tool to see if your desired domain (e.g., `golden-medovik-b184db.com.np`) is available. Remember, these domains are typically granted based on your legal name.
3.  **Follow Registration Steps:** The website will guide you through the registration process. You'll likely need to provide official identification documents (like your Nepali Citizenship Certificate) to verify your identity and legal name.
4.  **Verification and Activation:** After submission, `register.com.np` will review your application. Once approved, your domain will be registered and become active. They will also provide you with initial nameservers (which you'll soon change to Cloudflare's).

**Congratulations! You now own a lifetime, free `.com.np` domain.**

![output](/_imgs/post/Screenshot_20250727_185259.png)

### Part 2: Hosting Your Domain on Cloudflare (for Advanced DNS Management)

While `register.com.np` provides basic DNS, Cloudflare offers a free plan with powerful features like a Content Delivery Network (CDN), DDoS protection, SSL/TLS encryption, and advanced DNS management. This makes it an ideal choice for hosting your domain's DNS.

#### Step 2.1: Changing Nameservers at `register.com.np`

This is the **first crucial step** to integrate Cloudflare. You need to tell `register.com.np` that Cloudflare will be managing your domain's DNS.

1.  **Sign Up for Cloudflare:** If you don't have one, create a free account at `https://www.cloudflare.com/`.
2.  **Add Your Site:** In your Cloudflare dashboard, click "Add a Site" and enter your new `.com.np` domain (e.g., `ishworishrestha.com.np`).
3.  **Select a Plan:** Choose the "Free" plan.
4.  **Review DNS Records (Cloudflare):** Cloudflare will scan your domain's existing DNS records. Just click "Continue." You'll configure the important ones later.
5.  **Get Cloudflare Nameservers:** Cloudflare will then present you with two specific nameservers (e.g., `bryce.ns.cloudflare.com` and `paityn.ns.cloudflare.com`). **Make a note of these!**

![out](/_imgs/post/Screenshot_20250727_185601.png)

6.  **Log in to `register.com.np`:** Access your domain management portal at `https://register.com.np/userdomain/YOUR_DOMAIN_ID/edit` (or navigate through their dashboard).
7.  **Update Nameservers:** Locate the "Name server" section. You'll see fields for "Primary name server" and "Secondary name server."
    * **Replace the existing nameservers** with the two Cloudflare nameservers you copied.
    * **Example from your screenshot:** You would update `bryce.ns.cloudflare.com` and `paityn.ns.cloudflare.com` here.
    * Click "Edit DNS" or "Save Changes."

![out](/_imgs/post/Screenshot_20250727_185706.png)

8.  **Verify Nameservers in Cloudflare:** Go back to your Cloudflare dashboard. It might take some time (up to a few hours, but usually faster) for the nameserver changes to propagate. Cloudflare will eventually detect the change and show your domain as "Active."

![out](/_imgs/post/Screenshot_20250727_160536.png)

### Part 3: Linking Your Cloudflare-Managed Domain to Your Netlify Project

Now that Cloudflare is managing your domain's DNS, you can connect it to your Netlify project. This is done by adding specific DNS records in Cloudflare.

#### Step 3.1: Add Your Custom Domain in Netlify

1.  **Deploy Your Project to Netlify:** Ensure your project is already deployed and visible on a Netlify-generated URL (e.g., `golden-medovik-b184db.netlify.app`).

![out](/_imgs/post/Screenshot_20250727_161003.png)

2.  **Go to Netlify Domain Management:**
    * Log in to your Netlify dashboard (`https://app.netlify.com/`).
    * Navigate to your specific project (e.g., `golden-medovik-b184db`).
    * In the left sidebar, click on **"Domain management."**
3.  **Add Your Custom Domain:**
    * Under "Production domains," click **"Add domain."** and **"Add a domain you already own."**
    * Enter your `.com.np` domain (e.g., `ishworishrestha.com.np`) and click "Verify."
    * Click  `Add domain`

    ![out](/_imgs/post/Screenshot_20250727_185911.png)

    * Your domain will show "Awaiting External DNS" here.

    ![out](/_imgs/post/Screenshot_20250727_185954.png)

    * Click on both `Awaiting External DNS` and note a value like `ishworishrestha.com.np ALIAS apex-loadbalancer.netlify.com` and `www CNAME golden-medovik-b184db.netlify.app.`

    

4.  **Get Netlify DNS Instructions:**
    * Netlify will prompt you to update nameservers or configure DNS. **Crucially, do NOT update nameservers at your registrar again; you've already pointed them to Cloudflare.**
    * Instead, look for the option to configure DNS records *manually* or click on the "Awaiting External DNS" status for your domain.
    * You will see instructions. **Netlify will provide a target for your apex (root) domain, which is typically `apex-loadbalancer.netlify.com`, and your site's Netlify subdomain (e.g., `golden-medovik-b184db.netlify.app`) for the `www` subdomain.**

#### Step 3.2: Add DNS Records in Cloudflare

This is where you tell Cloudflare to direct traffic for your domain to your Netlify project.

1.  **Go to Cloudflare DNS Records:**
    * Log in to your Cloudflare dashboard.
    * Select your `ishworishrestha.com.np` domain.
    * Go to **"DNS" > "Records."**

2.  **Add CNAME for the Root Domain (`ishworishrestha.com.np`):**
    * **Type:** `CNAME`
    * **Name:** `@` (Cloudflare recognizes this as your root domain)
    * **Target:** `apex-loadbalancer.netlify.com`
    * **Proxy status:** Make sure the cloud icon is **orange (Proxied)**. This ensures Cloudflare's CDN and security features work.
    * Click **"Save."**

    *Why CNAME to `apex-loadbalancer.netlify.com`?* This is the recommended and most robust method. It points your domain to Netlify's dynamic load balancer, so if Netlify changes its underlying IPs, your site will continue to work without manual updates.

3.  **Add CNAME for the `www` Subdomain (`www.ishworishrestha.com.np`):**
    * **Type:** `CNAME`
    * **Name:** `www`
    * **Target:** Your unique Netlify-generated subdomain (e.g., `golden-medovik-b184db.netlify.app`). You can find this on your Netlify project's domain management page.
    * **Proxy status:** Make sure the cloud icon is **orange (Proxied)**.
    * Click **"Save."**

  **Summary of what your Cloudflare DNS records for `ishworishrestha.com.np` should look like:**

| Type  | Name                 | Content                         | Proxy Status |
| :---- | :------------------- | :------------------------------ | :----------- |
| CNAME | `@`                  | `apex-loadbalancer.netlify.com` | Proxied (Orange Cloud) |
| CNAME | `www`                | `golden-medovik-b184db.netlify.app`    | Proxied (Orange Cloud) |
| (Any existing records like MX, TXT, NS will remain) | ... | ... | ... |

![out](/_imgs/post/Screenshot_20250727_210443.png)

4.  **Clean Up (Optional but Recommended):**
    * If you had any existing `A` records for your root domain (like `ishworishrestha.com.np` pointing to an IP address) from previous attempts, **delete them now**. The CNAME to `apex-loadbalancer.netlify.com` replaces that.

### Part 4: Ensure SSL (HTTPS) Works

- **On Netlify**:

  - Go to **Site settings → Domain Management → HTTPS**
  - Enable **Automatic HTTPS (Let’s Encrypt)** if not already

- **On Cloudflare**:

  - Go to **SSL/TLS → Overview**
  - Set SSL mode to **Full** or **Full (Strict)**


### Part 5: Verify and Go Live!

1.  **Wait for DNS Propagation:** After adding these records in Cloudflare, it usually takes a few minutes to an hour for the changes to propagate globally.
2.  **Check Netlify Status:** Go back to your Netlify project's "Domain management" section. The "Awaiting External DNS" status for `ishworishrestha.com.np` and `www.ishworishrestha.com.np` should eventually change to "DNS Verified" or "Ready." Netlify will then automatically provision an SSL certificate for your custom domain, making your site secure (`https://`).

![out](/_imgs/post/Screenshot_20250727_210623.png)

3.  **Test Your Domain:** Open your browser and type in `ishworishrestha.com.np` and `www.ishworishrestha.com.np`. Both should now lead to your Netlify-hosted project!

![out](/_imgs/post/Screenshot_20250727_210705.png)



---

##  Adding subdomain to Netlify hosted project.


1. Go to your site on [Netlify](https://app.netlify.com/)
2. Navigate to:
   `Site settings → Domain Management → Add a domain -> Add a domain you already own`
3. Click **Add a domain you already own”**
4. Enter your sub domain:
   `ai.ishworishrestha.com.np`
5. Click **Verify**, then **Add domain**

---

###  Point DNS from Cloudflare to Netlify

1. Go to your domain in [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Go to the **DNS** tab
3. Add a new **CNAME** record:

   | Type  | Name | Target                  | TTL  | Proxy |
   | ----- | ---- | ----------------------- | ---- | ----- |
   | CNAME | ai | `object-detection-0ff.netlify.app.` | Auto | ✅ ON |

   - Replace `object-detection-0ff.netlify.app.` with your actual Netlify subdomain (found on your Netlify dashboard).
   - `Name` is `ai`, not the full domain.

---

###  Verify Domain Ownership with Netlify via Cloudflare (if needed)

**Netlify needs to verify** that you **own the domain** `ishworishrestha.com.np` before it allows you to add a subdomain like `ai.ishworishrestha.com.np`.

`ai.ishworishrestha.com.np` is an alias of `object-detection-0ff.netlify.app` and has its traffic proxied through Cloudflare.

To verify ownership using **Cloudflare DNS**, follow these steps:

---

#### Copy TXT Record from Netlify

From Netlify:

- **Host**: `netlify-challenge`
- **Value**: `your-value`

---

#### Add TXT Record in Cloudflare

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Select your domain: `yourdomain.com.np`
3. Go to the **DNS** tab
4. Click **“Add record”**
5. Choose:

   - **Type**: `TXT`
   - **Name (Host)**: `netlify-challenge`
   - **Content (Value)**: `your-value`
   - TTL: Auto

6. Click **Save**

---

###  STEP 5: Test Your Domain

![out](/_imgs/post/Screenshot_20250727_213803.png)


 [https://ai.ishworishrestha.com.np/](https://ai.ishworishrestha.com.np/)

![out](/_imgs/post/Screenshot_20250727_214017.png)

---


### Conclusion

By following these steps, you've successfully leveraged `register.com.np` for a free lifetime domain, utilized Cloudflare for advanced DNS and CDN benefits, and connected it all seamlessly to your Netlify-hosted project. You now have a professional, fast, and secure online presence.

---