

```markdown
# Azure Scalable Web Application Infrastructure

This Terraform configuration deploys a highly available and scalable web application environment on **Microsoft Azure**. It provisions core networking components, a load balancer, a virtual machine scale set with autoscaling, and a NAT Gateway for secure outbound connectivity.

---

## 📚 Table of Contents

- [Overview](#overview)
- [Deployed Azure Resources](#deployed-azure-resources)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Authenticate to Azure](#2-authenticate-to-azure)
  - [3. Initialize Terraform](#3-initialize-terraform)
  - [4. Plan the Deployment](#4-plan-the-deployment)
  - [5. Apply the Configuration](#5-apply-the-configuration)
- [Accessing the Application/VMs](#accessing-the-applicationvms)
- [Destroying Resources](#destroying-resources)
- [References](#references)

---

## 🧭 Overview

This project automates the deployment of a robust and scalable web application infrastructure on Azure. It’s designed to provide a foundational environment for hosting web services, ensuring high availability, network security, and automatic scaling capabilities.

### Key Features

- Resource Group container
- Isolated Virtual Network & Subnet
- Network Security Group rules (HTTP, HTTPS, SSH)
- Public IP for external access
- Azure Load Balancer
- Ubuntu-based VM Scale Set with autoscaling
- NAT Gateway for secure outbound traffic

---

## 🛠️ Deployed Azure Resources

| Resource Type | Name | Description |
|---------------|------|-------------|
| `azurerm_resource_group` | `terraform-tutorial` | Logical container (in `westus3`) |
| `azurerm_virtual_network` | `terraformvnet` | Private network with `10.0.0.0/16` |
| `azurerm_subnet` | `subnet` | Subnet within VNet (`10.0.0.0/20`) |
| `azurerm_network_security_group` | `myNSG` | Allows ports `80`, `443`, `22` |
| `azurerm_subnet_network_security_group_association` | — | Links `myNSG` to `subnet` |
| `azurerm_public_ip` | `lb-publicIP`, `natgw-publicIP` | For Load Balancer and NAT Gateway |
| `azurerm_nat_gateway` | `nat-Gateway` | Outbound internet access |
| `azurerm_nat_gateway_*_association` | — | Connects NAT Gateway to Public IP & Subnet |
| `azurerm_lb` | `myLB` | Distributes inbound traffic |
| `azurerm_lb_backend_address_pool` | `myBackendAddressPool` | Targets VMs in VMSS |
| `azurerm_lb_probe` | `http-probe` | Health checks on port 80 |
| `azurerm_lb_rule` | `http` | Routes traffic to backend pool |
| `azurerm_lb_nat_rule` | `ssh` | Enables SSH access (Ports 50000–50119) |
| `azurerm_orchestrated_virtual_machine_scale_set` | `vmss-terraform` | Ubuntu VMs, autoscaling |
| `azurerm_monitor_autoscale_setting` | `autoscale` | Autoscaling VMSS |
| `random_pet` | `lb_hostname` | Generates hostname for LB |

---

## ✅ Prerequisites

Make sure you have the following:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- An active Azure Subscription

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository_url>
cd Day14-AZ-Terraform
```

### 2. Authenticate to Azure

```bash
az login
```

Then set your subscription ID:

```powershell
$env:ARM_SUBSCRIPTION_ID = "62f3fe91-0f4a-4014-86d4-0e429ed8234b" # Windows
export ARM_SUBSCRIPTION_ID="62f3fe91-0f4a-4014-86d4-0e429ed8234b" # macOS/Linux
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan the Deployment

```bash
terraform plan
```

This shows what will be created—expect `18 to add, 0 to change, 0 to destroy`.

### 5. Apply the Configuration

```bash
terraform apply --auto-approve
```

This starts provisioning the Azure resources.

---

## 🌐 Accessing the Application/VMs

### Web Application Access

If your VMSS instances run a web server on port 80, you can navigate to:

```
http://<LoadBalancer_Public_IP>
```

### SSH Access to VMSS Instances

You can connect to a VM via NAT:

```bash
ssh -i <your_ssh_private_key> azureuser@<LoadBalancer_Public_IP> -p 50000
```

Replace `<your_ssh_private_key>` with your local private key path.

---

## 🧨 Destroying Resources

To remove everything:

```bash
terraform destroy --auto-approve
```

**⚠️ Warning:** This permanently deletes all resources deployed via this configuration.

---

## 📎 References

- [Terraform Azure VMSS Tutorial](https://developer.hashicorp.com/terraform/tutorials/it-saas/azure-virtual-machine-scale-sets)
