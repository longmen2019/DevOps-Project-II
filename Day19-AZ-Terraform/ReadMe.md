

```markdown
# 🚀 Day19 Azure Terraform VM Provisioning

This project provisions an Ubuntu Linux virtual machine in Azure using Terraform. It automates network setup, SSH authentication, Nginx installation, and file transfer, showcasing modular design and infrastructure-as-code principles.

---

## 📦 Features

- Provisioning via `azurerm_linux_virtual_machine`
- SSH key-based authentication
- Static public IP assignment
- Nginx installation and custom welcome page
- File upload using Terraform's `file` provisioner
- Deployment timestamp tracking with `null_resource`
- Output of VM public IP after deployment

---

## 🧱 Prerequisites

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- Azure subscription with appropriate permissions
- SSH key pair (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)
- File: `configs/sample.config` must exist locally

---

## ⚙️ How to Use

1. Clone the repo and navigate to the project folder:
   ```bash
   git clone https://github.com/yourusername/day19-az-terraform.git
   cd day19-az-terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Preview the deployment:
   ```bash
   terraform plan
   ```

4. Apply the changes:
   ```bash
   terraform apply
   ```

5. Access your VM:
   ```bash
   ssh -i ~/.ssh/id_rsa azureuser@<vm_public_ip>
   ```

6. View the Nginx welcome page:
   ```
   http://<vm_public_ip>
   ```

---

## 📁 File Structure

```
.
├── main.tf                   # Terraform config
├── configs/
│   └── sample.config         # Configuration file to upload
├── variables.tf              # Input variables (optional split)
└── README.md
```

---

## 🌐 Output

```hcl
output "vm_public_ip" {
  value = azurerm_public_ip.vm_ip.ip_address
}
```

Use this IP address to connect via SSH or HTTP after provisioning.

---

## 🙌 Credits

Built during the **#28DaysOfAZTerraform** challenge to demonstrate automated VM setup in Azure.  
Authored by Long, powered by Terraform and Azure.

---

## 🛡️ License

MIT License. See [LICENSE](LICENSE) for details.
```

