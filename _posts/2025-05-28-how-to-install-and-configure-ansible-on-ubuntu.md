---
title: How To Install and Configure Ansible on Ubuntu.
date: 2025-05-28
categories: [ansible]
tags:
  - Ansible
  - Hands On Lab
description: Install and configure Ansible on Ubuntu, set up communication with virtual machines (VMs) as managed nodes, and execute your first automation playbooks.
---


## What is Ansible?

Ansible is an open-source automation engine that automates provisioning, configuration management, application deployment, intra-service orchestration, and much more. It's popular because it's:

  * **Agentless:** No software needs to be installed on the managed nodes (the machines you want to control).
  * **Simple:** Uses YAML for playbooks, which is human-readable.
  * **Powerful:** Can automate complex multi-tier application deployments.

## Step 1: Install Ansible on Ubuntu

You'll install Ansible on your "control node" – this is the machine you'll use to run Ansible commands and playbooks.


 **Install Ansible:**

```bash
sudo apt update
sudo apt install ansible -y
```
 

   
   
## Step 2: Configure SSH for Agentless Communication

[Follow this guide](https://blog.janakkumarshrestha0.com.np/posts/ssh-to-your-vm-shell/)

## Step 3: Configure the Ansible Inventory File

The inventory file (usually `/etc/ansible/hosts` or a custom file) tells Ansible which servers it can manage.

1.  **Open the default inventory file for editing:**

    ```bash
    sudo nano /etc/ansible/hosts #if dir not exit, create it
    ```

2.  **Add your managed nodes:**
    You can organize your servers into groups. This is incredibly useful for targeting specific sets of servers with your playbooks.

    **Example `hosts` file:**

    ```ini
    # This is the default ansible 'hosts' file.
    #
    # It should be in an INI format. Lines beginning with '#' are comments.

    # --- Start Local VM Configuration ---
    [local_vms]
    192.168.253.100 ansible_user=janak # Replace 'janak' with your VM's username
    ```

    
    **Explanation for VM entry:**
    * `[local_vms]`: A new group for your local VMs.
    * `192.168.253.100`: The IP address of your VM.
    * `ansible_user=janak`: Specifies the SSH username to connect with on this VM. **Change `janak` to the actual username you use on your VM.**

    **If using password authentication (not recommended for general use):**
    You would add `ansible_password=<your_vm_password>` to the line, but storing passwords directly in inventory is insecure. Instead, use `--ask-pass` or Ansible Vault.


---

## Step 4: Test Ansible Connectivity (Ad-Hoc Commands)

Before running playbooks, it's good practice to ensure Ansible can communicate with your nodes using ad-hoc commands.

1.  **Ping all hosts:**

    ```bash
    ansible all -m ping
    ```

      * `all`: Targets all hosts defined in your inventory.
      * `-m ping`: Uses the built-in `ping` module to test connectivity.

    

2.  **Run a command on a specific group (e.g., local_vms):**

    ```bash
    ansible local_vms -a "uptime"
    ```

      * `local_vms`: Targets only the hosts in the `local_vms` group.
      * `-a "uptime"`: Executes the `uptime` command on the remote hosts.

    You'll see the uptime output for each web server.

## Step 5: Create Your First Playbook

Playbooks are YAML files that define a set of tasks to be executed on your managed nodes.

1.  **Create a new file for your playbook:**

    ```bash
    nano first_playbook.yml
    ```

2.  **Add the following content to the file:**
    This playbook will:

      * Ensure the `nginx` web server is installed.
      * Ensure the `ufw` firewall is installed.
      * Start and enable `nginx` and `ufw` services.
      * Allow HTTP traffic through `ufw`.
      * Create a simple `index.html` file in the web root.

    <!-- end list -->

    ```yaml
    ---
    - name: Configure Webserver
      hosts: webservers # This playbook will run on hosts in the 'webservers' group
      become: yes       # This allows tasks to be run with sudo privileges

      tasks:
        - name: Ensure Nginx is installed
          ansible.builtin.apt:
            name: nginx
            state: present
            update_cache: yes

        - name: Ensure UFW (Uncomplicated Firewall) is installed
          ansible.builtin.apt:
            name: ufw
            state: present

        - name: Start and enable Nginx service
          ansible.builtin.service:
            name: nginx
            state: started
            enabled: yes

        - name: Start and enable UFW service
          ansible.builtin.service:
            name: ufw
            state: started
            enabled: yes

        - name: Allow HTTP traffic through UFW
          community.general.ufw:
            rule: allow
            port: '80'
            proto: tcp
            state: enabled
          when: ansible_os_family == "Ubuntu" # This task only runs on Ubuntu-based systems

        - name: Create a simple index.html file
          ansible.builtin.copy:
            content: "<h1>Hello from Ansible!</h1>"
            dest: /var/www/html/index.html
            owner: www-data
            group: www-data
            mode: '0644'
    ```

    **Explanation of the Playbook:**

      * `---`: Indicates the start of a YAML file.
      * `- name: Configure Webserver`: A descriptive name for the playbook.
      * `hosts: webservers`: Specifies that this playbook will run on the hosts in the `webservers` group from your inventory.
      * `become: yes`: This is crucial\! It tells Ansible to use `sudo` (become root) for the tasks that require elevated privileges (like installing packages, starting services, and writing to `/var/www/html`).
      * `tasks:`: A list of tasks to be executed.
      * `- name: ...`: A descriptive name for each task.
      * `ansible.builtin.apt:`: This is a module. Ansible has thousands of modules for various tasks. The `apt` module is used for managing packages on Ubuntu/Ubuntu systems.
          * `name: nginx`: The name of the package to manage.
          * `state: present`: Ensures the package is installed.
          * `update_cache: yes`: Updates the `apt` package cache before installing.
      * `ansible.builtin.service:`: Manages system services.
          * `name: nginx`: The service name.
          * `state: started`: Ensures the service is running.
          * `enabled: yes`: Ensures the service starts automatically on boot.
      * `community.general.ufw:`: Manages UFW firewall rules.
          * `when: ansible_os_family == "Ubuntu"`: This is a conditional statement. The UFW task will only run if the operating system family of the managed node is Ubuntu (which Ubuntu is). This makes your playbooks more robust.
      * `ansible.builtin.copy:`: Copies files from the control node to the managed node, or creates files with specified content.
          * `content: "<h1>Hello from Ansible!</h1>"`: The content to put in the file.
          * `dest: /var/www/html/index.html`: The destination path on the remote server.
          * `owner: www-data`, `group: www-data`, `mode: '0644'`: Sets file ownership and permissions.

3.  **Save and exit nano.**

## Step 6: Run Your Playbook

Now, let's execute your first Ansible playbook\!

1.  **Run the playbook:**

    ```bash
    ansible-playbook first_playbook.yml # -K for vm's authentication
    ```

    You'll see output that shows each task being executed.

    ![output](/_imgs/post/Screenshot_20250531_114909.png)

    

2.  **Verify the changes:**

     To confirm the playbook's effects, you can now check your VM:

    **Open a web browser** and navigate to `http://192.168.253.100`. You should see the "Hello from Ansible!" message.

    ![output](/_imgs/post/Screenshot_20250531_114727.png)
    
    * **SSH into your VM** (`ssh janak@192.168.253.100`) and verify:
    * **Nginx status:** `sudo systemctl status nginx` (It should be active/running).
    * **UFW status:** `sudo ufw status` (It should show port 80 allowed).
    * **Index file content:** `cat /var/www/html/index.html` (It should display "Hello from Ansible!").

## Next Steps and Important Concepts

  [Refrence DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04)
  [How to Use Ansible: A Reference Guide](https://www.digitalocean.com/community/cheatsheets/how-to-use-ansible-cheat-sheet-guide)

  * **Idempotence:** Ansible is designed to be idempotent. This means you can run the same playbook multiple times, and it will only make changes if the system is not in the desired state. If Nginx is already installed and running, Ansible won't try to install or start it again, resulting in `ok` status for those tasks.
  * **Modules:** Explore more Ansible modules\! There are modules for managing users, services, packages, files, databases, cloud resources, and much more. You can find them in the [Ansible documentation](https://docs.ansible.com/ansible/latest/collections/index.html).
  * **Variables:** Variables allow you to make your playbooks more flexible. Instead of hardcoding values, you can define them as variables.
  * **Roles:** For larger, more complex projects, organize your playbooks into roles. Roles provide a standardized directory structure for tasks, handlers, templates, and variables.
  * **Conditionals (`when`):** As seen with the UFW example, `when` statements allow you to run tasks only if certain conditions are met.
  * **Handlers:** Handlers are tasks that are triggered by other tasks. For example, if you change a configuration file, you might want to restart a service. You'd notify a handler to restart the service.
  * **Vault:** For sensitive data (passwords, API keys), use Ansible Vault to encrypt your variables and files.
  * **Ansible Galaxy:** A hub for sharing and finding Ansible roles.
