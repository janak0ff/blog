---
title: Terraform - Complete step-by-step process to create a (VM) on Azure and SSH under student pack subscription.
date: 2025-06-07
categories: [terraform]
tags:
  - terraform
  - azure
  - Hands On Lab
description: Making a Linux virtual machine on Microsoft Azure using Terraform. From setting up providers and creating a resource group to configuring networking components and managing SSH authentication using azure CLI & GUI
---



**step-by-step guide** to generate the required values for using Terraform with Microsoft Azure:

---

## ✅ Install Required Tools

You’ll need to install the following tools on your local machine:

### 1. **Terraform**

* Go to: [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)
* Download and install Terraform for your operating system.
* After installation, verify with:

  ```bash
  terraform -v
  ```

### 2. **Azure CLI**

* Go to: [https://learn.microsoft.com/en-us/cli/azure/install-azure-cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
* Install the Azure CLI for your OS.
* After installation, check it:

  ```bash
  az version
  ```

---

## ✅  Log in to Azure

Login to your Azure account using Azure CLI:

```bash
az login
```

A browser window will open asking you to log in with your student pack credentials.

You can list your subscription:

```bash
az account show
```

---


## ⚙️ Get the `azure_subscription_id` and `azure_tenant_id`

Run this command:

```bash
az account show --query "{subscriptionId:id, tenantId:tenantId}"
```

**Output:**

```json
{
  "subscriptionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenantId": "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"
}
```

✅ Copy the values for:

* `azure_subscription_id`
* `azure_tenant_id`

### Get Azure Subscription ID via GUI
![output](/_imgs/post/azure-subscription-id.png)

1. **Go to Azure Portal**
   👉 Visit: [https://portal.azure.com](https://portal.azure.com)
   Log in with your Azure account.

2. **Open 'Subscriptions' Panel**

   * Click on the **search bar** at the top.
   * Type **"Subscriptions"** and click on the result.

3. **View Subscription Details**

   * You’ll see a list of your subscriptions.
   * Each subscription will show the **Subscription name** and the **Subscription ID**.

4. **Copy the Subscription ID**

   * Click on the subscription name to open its details.
   * The **Subscription ID** will be visible in the overview pane.
   * Click the **copy icon** 📋 next to it to copy.

---


## 🛠️  Create a Service Principal (SP) / App registrations

This SP will be used by Terraform to authenticate.

```bash
az ad sp create-for-rbac --name terraform-janak --role="Contributor" --scopes="/subscriptions/<subscription-id>"
```

Replace `<subscription-id>` with the actual value

**Output:**

```json
{
  "appId": "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz",
  "displayName": "terraform-sp",
  "password": "********-****-****-****-************",
  "tenant": "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"
}
```

✅ Save:

* `azure_client_id = appId`
* `azure_client_secret = password`
* `azure_tenant_id = tenant` (same as before)

---
### GUI Methods: **Step-by-step guide** to get your **Azure Client ID**, **Client Secret**, and **Tenant ID** from the **Azure Portal (GUI)** using **App Registrations**:

---

#### **Step 1: Go to App Registrations**

1. Click on the **Search bar** at the top.
2. Type **“App registrations”** and select it.
3. Click **“+ New registration”**.

![output](/_imgs/post/terra-azure-app-reg.png)

#### **Step 2: Register the Application**

1. **Name** your app (e.g., `terraform-janak`).
2. Leave the default **Supported account types** as **Single tenant** (or your choice).
3. Redirect URI: leave empty
4. Click **“Register”**.

---

### 🔹 Step 3: Get the IDs

![output](/_imgs/post/terraform-janak-idss.png-)

#### ✅ **Client ID** (`azure_client_id`)

* Go to the **Overview** tab.
* Copy the value labeled **“Application (client) ID”**.

#### ✅ **Tenant ID** (`azure_tenant_id`)

* In the same **Overview** tab.
* Copy the value labeled **“Directory (tenant) ID”**.

---

### 🔹 Step 4: Create a Client Secret

![output](/_imgs/post/Certificates-secrets-terra-azure.png)

1. In the left menu, click **“Certificates & secrets”**.
2. Under **Client secrets**, click **“+ New client secret”**.
3. Add a **description** (e.g., `anything`), choose an expiration (e.g., 6 or 12 months).
4. Click **“Add”**.
5. **Copy the value immediately** shown under "Value" – this is your **`azure_client_secret`**.
   ⚠️ You won’t be able to view it again once you leave the page.

---


## 👮  Confirm Role Assignment 

You can check if the role was properly assigned:

```bash
az role assignment list --assignee <appId>
```

Assign Contributor role:

```bash
az role assignment create \
  --assignee <app-id> \
  --role "Contributor" \
  --scope /subscriptions/<subscription-id>

```

---
### GUI Methods: Assign Permissions to the App

To give your app permissions to deploy resources:

1. Go to **Subscriptions** → Select your subscription.
2. Click **“Access control (IAM)”**.
3. Click **“+ Add” > “Add role assignment”**.
4. Under the **Privileged administrator roles** choose: **Contributor**
5. Assign access to: **User, group, or service principal**
6. Select Members: search for your app name (`Terraform-janak`) and select it.
![output](/_imgs/post/Screenshot_20250614_191748.png)
7. Click **Save**.
![output](/_imgs/post/Screenshot_20250614_191950.png)

---

## 📌 Summary of Values

You now have:

| Variable                | Description                |
| ----------------------- | -------------------------- |
| `azure_subscription_id` | Your Azure subscription ID |
| `azure_client_id`       | appId                      |
| `azure_client_secret`   | password                   |
| `azure_tenant_id`       | Azure tenant ID            |

---


### ✅ Generate SSH Key (If not)


```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```



## ✅ Configure Terraform Directory

1. Create a new project folder:

   ```bash
   mkdir terraform-azure
   cd terraform-azure
   ```

2. Create a file named `main.tf`:

   ```bash
   nano main.tf
   ```

Paste the following into `main.tf` (you can edit names later):

```hcl
# ------------------------------
# Specify the required provider
# ------------------------------
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Ensures you're using version 4.x of the Azure provider
    }
  }
}

# -----------------------------------------
# Configure the Azure provider credentials
# -----------------------------------------
provider "azurerm" {
  features {}

  # These variables will be passed via CLI, environment, or tfvars
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

# -------------------------------
# Create a new Azure Resource Group
# -------------------------------
resource "azurerm_resource_group" "janak-azure" {
  name     = "Janak-res"  # Resource group name
  location = "westeurope"             # Azure region
}

# ---------------------------
# Create a Virtual Network
# ---------------------------
resource "azurerm_virtual_network" "janak-azure" {
  name                = "janak-azure-network"            # Name of the VNet
  address_space       = ["10.0.0.0/16"]              # CIDR block
  location            = azurerm_resource_group.janak-azure.location
  resource_group_name = azurerm_resource_group.janak-azure.name
}

# ----------------------
# Create a Subnet inside the VNet
# ----------------------
resource "azurerm_subnet" "janak-azure" {
  name                 = "internal"                                # Subnet name
  resource_group_name  = azurerm_resource_group.janak-azure.name
  virtual_network_name = azurerm_virtual_network.janak-azure.name
  address_prefixes     = ["10.0.2.0/24"]                          # Subnet IP range
}

# ----------------------------
# Create a Static Public IP Address
# ----------------------------
resource "azurerm_public_ip" "janak-azure" {
  name                = "janak-azure-public-ip"
  location            = azurerm_resource_group.janak-azure.location
  resource_group_name = azurerm_resource_group.janak-azure.name
  allocation_method   = "Static"       # IP will not change
  sku                 = "Standard"     # Standard SKU supports NSG and zones
  sku_tier            = "Regional"     # Tier of the SKU
}

# -------------------------------
# Create a Network Security Group (NSG)
# -------------------------------
resource "azurerm_network_security_group" "janak-azure" {
  name                = "janak-azure-nsg"
  location            = azurerm_resource_group.janak-azure.location
  resource_group_name = azurerm_resource_group.janak-azure.name

  # Allow inbound SSH (port 22) from anywhere
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# -----------------------------------------------------
# Associate NSG with the network interface of the VM
# -----------------------------------------------------
resource "azurerm_network_interface_security_group_association" "janak-azure" {
  network_interface_id      = azurerm_network_interface.janak-azure.id
  network_security_group_id = azurerm_network_security_group.janak-azure.id
}

# ----------------------------
# Create a Network Interface
# ----------------------------
resource "azurerm_network_interface" "janak-azure" {
  name                = "janak-azure-nic"
  location            = azurerm_resource_group.janak-azure.location
  resource_group_name = azurerm_resource_group.janak-azure.name

  # IP configuration for the NIC
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.janak-azure.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.janak-azure.id
  }
}

# ----------------------------
# Create a Linux Virtual Machine
# ----------------------------
resource "azurerm_linux_virtual_machine" "janak-azure" {
  name                  = "Janak-azure-terraform"                        # Name of the VM
  resource_group_name   = azurerm_resource_group.janak-azure.name
  location              = azurerm_resource_group.janak-azure.location
  size                  = "Standard_B1s"                        # Free-tier eligible size
  admin_username        = "janak_azure"                          # SSH login username
  network_interface_ids = [azurerm_network_interface.janak-azure.id]

  # SSH Key-based authentication
  admin_ssh_key {
    username   = "janak_azure"
    public_key = file("~/.ssh/id_rsa.pub")                    # Path to public SSH key
  }

  disable_password_authentication = true                      # Force key-only login

  # OS Disk configuration
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Use latest Ubuntu 22.04 LTS image
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
```

2. Create a file named `output.tf`:

  ```hcl
  output "public_ip" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_public_ip.janak-azure.ip_address
  }
  ```
3. Create a file named `variables.tf`:

    ```hcl
    variable "azure_subscription_id" {
      type = string
    }
    variable "azure_client_id" {
      type = string
    }
    variable "azure_client_secret" {
      type = string
    }
    variable "azure_tenant_id" {
      type = string
    }
    ```
4. Create a file named `terraform.tfvars` and  replace your own keys:
    ```hcl
    azure_subscription_id = "bf97eca7-bcbd-41ce-bc31-9c5d6fds84f2073" #subscription id
    azure_client_id        = "2c6e5db5-620e-4b07-8b9a-904sfs45f297d41"  #app registration
    azure_tenant_id       = "69c13822-3598-4d4d-aae2-f142dsfs0ad786ab" #tenant id
    azure_client_secret   = "UbB8Q~3GxAWrF67k1LdsdfvUzk72b2DBV~rgTkAkOaad" #secret value
    ```
---

## ✅ Initialize and Apply Terraform

### 1. **Initialize Terraform** in your project directory:

```bash
terraform init
```

### 2. **Preview the actions** Terraform will take:

```bash
terraform plan
```

### 3. **Apply the configuration**:

```bash
terraform apply
```

Confirm when prompted by typing `yes`.

![output](/_imgs/post/using-terraform-to-create-azurevm.png)
---

## ✅ SSH to newly created azure VM

```bash
ssh -i ~/.ssh/id_rsa janak_azure@51.136.100.152
```

Use your own your USERNAME & IP

![output](/_imgs/post/ssh-to-azure-vm-terra.png)

---
![output](/_imgs/post/Screenshot_20250614_192245.png)

---

## ✅ Clean Up (To Save Free Credits)

When you're done, destroy the resources:

```bash
terraform destroy
```
![output](/_imgs/post/terra-az-destroy.png)


---
## 📚 **References:**

* 🎥 [Deploy Azure VM using Terraform | YouTube Tutorial](https://www.youtube.com/watch?v=ZoB5cG_zakM)
* 📘 [Terraform Azurerm Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
