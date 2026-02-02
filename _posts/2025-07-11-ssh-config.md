---
layout: post
title: "Simplify Your SSH Workflow with the ssh config"
date: 2025-07-11 11:18 +0545
categories: ["config"]
tags: ["ssh"]
author: sudiplun
excerpt: Learn how to use the SSH config file to create shortcuts for your remote connections and manage SSH keys for services like GitHub, reducing repetitive commands.
---

## What is the SSH Config File?

The SSH config file (`~/.ssh/config`) is a powerful tool that lets you define connection parameters for your SSH sessions. By creating aliases for your hosts, you can avoid typing long, repetitive commands.

### Example: Accessing a Virtual Machine

Consider the following command to access a local virtual machine:

```bash
ssh -i ~/.ssh/vm-debian luniox@127.0.0.1 -p 60022
```

Instead of typing this every time, you can create a shortcut in your `~/.ssh/config` file:

```bash
Host vm-debian
    HostName 127.0.0.1
    Port 60022
    User luniox
    IdentityFile ~/.ssh/vm-debian
```

Now, you can connect to your VM with a much simpler command:

```bash
ssh vm-debian
```

### Example: Managing GitHub SSH Keys

The SSH config can also simplify how you manage authentication for services like GitHub.

Previously, you might have needed to manually add your private key to the SSH agent in each new terminal session, like this:

`eval $(ssh-agent -s) && ssh-add ~/.ssh/github_private`

With the SSH config file, you can tell Git to automatically use the correct key for GitHub. Add the following to your `~/.ssh/config`:

```bash
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_private
    IdentitiesOnly yes
```

After setting this up, you no longer need to manually add the key to the agent for Git operations; SSH will handle it automatically.
