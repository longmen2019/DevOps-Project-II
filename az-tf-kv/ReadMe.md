## 🚀 Azure VM with Key Vault Integration — Terraform Project

This project provisions a secure, modular Azure infrastructure using Terraform. It deploys a virtual machine with system-assigned managed identity, network resources, and a Key Vault containing secrets accessible by the VM.

---

### 📦 Modules Included

- **Resource Group**: Creates the container for all resources
- **Virtual Network & Subnet**: Defines the network topology
- **Public IP**: Allocates a static IP for VM access
- **Network Interface**: Connects the VM to the subnet and public IP
- **Virtual Machine**: Deploys a Linux VM with managed identity
- **Key Vault**: Stores secrets and grants access to the VM identity
- **Key Vault Secret**: Creates a named secret inside the Key Vault

---

### 🔐 Security Highlights

- Uses **system-assigned managed identity** for the VM
- Key Vault access is granted via **Terraform-managed access policies**
- Secrets are **not hardcoded** into the VM — they are securely retrieved at runtime

---

### 📁 File Structure

```
.
├── main.tf                 # Root module wiring all submodules
├── variables.tf            # Input variables for root module
├── outputs.tf              # Root-level outputs (optional)
├── dev.tfvars              # Environment-specific variable values
├── modules/
│   ├── virtual_machine/
│   ├── keyvault/
│   ├── keyvault_secret/
│   ├── network_interface/
│   ├── public_ip/
│   ├── subnet/
│   └── vnet/
```

---

### ⚙️ Usage

#### 1. Initialize Terraform
```bash
terraform init
```

#### 2. Plan with environment variables
```bash
terraform plan -var-file="dev.tfvars"
```

#### 3. Apply the configuration
```bash
terraform apply -var-file="dev.tfvars"
```

---

### 🧪 Optional: Test Secret Retrieval

If needed, SSH into the VM and run a Python script that uses Azure SDK to fetch secrets from Key Vault using the VM’s identity.

---

### 📌 Requirements

- Terraform ≥ 1.3
- Azure CLI authenticated
- Permissions to create resources in the target subscription

---

### 🧠 Notes

- VM image can be Ubuntu or RHEL — configurable via `publisher`, `offer`, and `sku`
- Key Vault secret name and value are passed via variables
- All modules are reusable and environment-agnostic
