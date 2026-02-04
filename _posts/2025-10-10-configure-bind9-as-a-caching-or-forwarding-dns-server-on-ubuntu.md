---
title: Configure Bind9 as a Caching or Forwarding DNS Server on Ubuntu
date: 2025-10-10
categories: [DNS]
tags:
  - Hands On Lab
  - BIND9
description: Configure Bind as a Caching or Forwarding DNS Server on Ubuntu.
---


![output](/assets/img/Screenshot_20251013_155057.png)

Configuring BIND as a caching or forwarding DNS server on Ubuntu on my VPC with private ip.

## 1\. Installation

The first step is to install the BIND (Berkeley Internet Name Domain) package, which is named `bind9` on Ubuntu.

| Command | Explanation |
| :--- | :--- |
| `sudo apt update` | Updates the local list of available packages from the repositories. |
| `sudo apt install bind9 bind9utils -y` | Installs the **BIND9** DNS server software and the **`bind9utils`** package, which includes helpful tools like `named-checkconf` for configuration validation. The `-y` flag automatically confirms the installation. |
| `sudo ufw allow 53/udp` | Configures the **Uncomplicated Firewall (UFW)** to allow incoming traffic on **port 53 (UDP)**, which is the standard port for DNS queries. |

-----

## 2\. Configure the Main Options File

The primary configuration for caching and forwarding is done in the `/etc/bind/named.conf.options` file.

| Command | Explanation |
| :--- | :--- |
| `sudo nano /etc/bind/named.conf.options` | Opens the configuration file in the **nano** text editor with superuser privileges for editing. |

### Configuration Content

You will modify the file to include the IP addresses of your **forwarders** (public DNS servers) and an **Access Control List (ACL)** to define which clients are allowed to use your server.

**Example `named.conf.options`:**

```conf
// ====================================================================
// ACL DEFINITION
// Define the Access Control List (ACL) of clients permitted to query
// this DNS server for recursive lookups.
// ====================================================================
acl goodclients {
    // Allows the entire 10.10.1.x subnet access.
    10.10.1.0/24;
    // Allows queries originating from the server itself.
    localhost;
    // Allows queries from all locally configured networks on the server.
    localnets;
};

// ====================================================================
// GLOBAL OPTIONS
// ====================================================================
options {
    // Directory where BIND will store cache files.
    directory "/var/cache/bind";

    // Enable recursion: allows the server to query upstream servers 
    // on behalf of internal clients.
    recursion yes;

    // Define which clients are allowed to use recursion (the ACL defined above).
    allow-query { goodclients; };

    // Define the list of public DNS servers (forwarders) to send queries to.
    forwarders {
        8.8.8.8;
        8.8.4.4;
    };

    // Instruction to ONLY use the servers listed in 'forwarders'.
    // If the forwarders fail, the server will not attempt to resolve via root hints.
    forward only;

    // DNSSEC validation is enabled, automatically retrieving the trusted root key.
    dnssec-validation yes;

    // auth-nxdomain no: conform to RFC1035, returning NXDOMAIN only 
    // when explicitly confirmed by an authoritative server.
    auth-nxdomain no;    

    // listen-on-v6 { any; }: Instructs BIND to listen on all IPv6 interfaces.
    listen-on-v6 { any; };
};
```

### Key Directives Explained

| Directive | Purpose |
| :--- | :--- |
| `recursion yes;` | Allows the server to perform queries for external domains on behalf of clients. Required for a caching/forwarding server. |
| `forwarders {...};` | Specifies the upstream DNS servers (e.g., public or private ones) that your BIND server will send non-local queries to. |
| `forward only;` | Instructs BIND to *only* use the servers listed in `forwarders`. If they fail, BIND will not attempt to resolve the query via root servers. |
| `allow-query {...};` | Restricts which client IPs or networks can send DNS queries to your server, defined by the `acl goodclients`. This is a critical security measure. |
| `acl goodclients {...};` | Defines a custom group of IP addresses and networks. **`192.168.1.0/24`** is a **private DNS network** example, allowing all devices on that subnet. **`localhost`** is the server itself. |

-----

## 3\. Configuration Validation and Restart

After saving the configuration file, you must check for syntax errors before restarting the service.

| Command | Explanation |
| :--- | :--- |
| `sudo named-checkconf` | Checks the overall BIND configuration files for **syntax errors**. If it returns no output, the syntax is correct. |
| `sudo systemctl restart bind9` | Restarts the BIND service to apply the new configuration. |
| `sudo systemctl status bind9` | Checks the status of the service to ensure it is **running** without errors. Look for the `Active: active (running)` message. |

-----

## 4\. Configuring Clients to Use the New Server

For your internal devices to benefit from the caching and forwarding, they must be configured to use your BIND server's IP address (e.g., **`192.168.1.50`**) as their primary DNS server.

### Temporary Client Configuration

This is best for quick testing on a client machine.

| Command | Explanation |
| :--- | :--- |
| `sudo nano /etc/resolv.conf` | Edits the file responsible for listing DNS servers. Note: Changes here are often **lost after reboot** or a network change. |

**Example `resolv.conf` content:**

```conf
# Comment out any existing nameserver lines
# nameserver 127.0.0.53 

// Set your BIND server's internal IP address
nameserver 10.10.1.20
```

-----

## 5\. Testing the Server

Use the `hostmane -I` and `dig` command from your client machine to test resolution and confirm it's using your server.

| Command | Explanation |
| :--- | :--- |
| `dig janakkumarshrestha0.com.np` | Queries the DNS server configured in your client's `/etc/resolv.conf` (which should be your BIND server at `10.10.1.20`) for the IP address of the domain `janakkumarshrestha0.com.np`. This confirms client-side resolution. |
| `hostname -I` | Displays all the **private IP addresses** currently assigned to the server's network interfaces (e.g., `10.10.1.20`). This is a quick way to confirm the local machine's identifier without parsing `ifconfig` or `ip addr`.  |

```bash
~ > hostname -I                   
10.10.1.125 
~ > 
~ > dig janakkumarshrestha0.com.np

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> janakkumarshrestha0.com.np
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 27741
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 1d5a81745293f43b0100000068eccd44471fd49ea494d57f (good)
;; QUESTION SECTION:
;janakkumarshrestha0.com.np.    IN      A

;; ANSWER SECTION:
janakkumarshrestha0.com.np. 300 IN      A       104.21.20.41
janakkumarshrestha0.com.np. 300 IN      A       172.67.191.82

;; Query time: 59 msec
;; SERVER: 10.10.1.20#53(10.10.1.20) (UDP)
;; WHEN: Mon Oct 13 09:5
```

### Caching Test

Run the `dig` command twice. The first query will show a **high query time** as your server forwards the request. The second query for the exact same domain should show a query time of **0 msec** or very close to it, proving that the answer was served from the server's **cache**.

```bash
~ > dig janakkumarshrestha0.com.np

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> janakkumarshrestha0.com.np
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 50236
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: dc20b4eff868227f0100000068eccd49b12406a2f2b5b8df (good)
;; QUESTION SECTION:
;janakkumarshrestha0.com.np.    IN      A

;; ANSWER SECTION:
janakkumarshrestha0.com.np. 295 IN      A       104.21.20.41
janakkumarshrestha0.com.np. 295 IN      A       172.67.191.82

;; Query time: 1 msec
;; SERVER: 10.10.1.20#53(10.10.1.20) (UDP)
;; WHEN: Mon Oct 13 09:58:33 UTC 2025
;; MSG SIZE  rcvd: 115

~ > 
```

-----
- Reference : [How To Configure Bind as a Caching or Forwarding DNS Server on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-caching-or-forwarding-dns-server-on-ubuntu-14-04#prerequisites-and-goals)