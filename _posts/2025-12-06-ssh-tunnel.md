---
layout: post
title: "SSH Tunnels - scenarios bases"
date: 2025-12-06 12:28 +0545
categories: ["ssh"]
tags: ["cli"]
author: sudiplun
excerpt:
---

**scenarios**
on remote server vm where no public ip is assign. where we can ssh into it and setup zabbix-server. zabbix web port is run on remote localhost:80 now i have to access on client via shh tunnels - local port forwarding
</br>
user have to run an SSH command on their client machine

```bash
ssh -L [LocalPort]:localhost:80 [user]@[remote_server_ip]
# ssh -L 8080:localhost:80 root@10.14.13.11
```

browser `localhost:8080` on client machine.

---

**scenarios**

- recently i setup archlinux with hyprland on friend's laptop where have to changes. we are on different private network to able me to access his laptop i use public access remote server(vm).</br>
  Here how via SHH Tunnels - Remote Port forwarding.

```bash
# run on client(friend's shell)
ssh -N -R <remote-address>:<remote_port>:<local_address>:<local_port> user@remote_public_ssh_server
# ssh -R 222:localhost:22 root@103.12.43.14
```

now `ssh friend@103.12.43.14 -p 222` bring to friend laptop shell.
