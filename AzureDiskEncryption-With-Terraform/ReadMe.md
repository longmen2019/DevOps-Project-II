```markdown
# Azure Disk Encryption with Terraform

This project provisions a Windows Server 2022 virtual machine in Azure using Terraform, with optional support for Azure Disk Encryption (ADE) and Trusted Launch security features. It demonstrates modular infrastructure design, dynamic subnet validation, and secure VM provisioning.

## 🚀 Features

- Deploys a Gen2 Windows Server 2022 Datacenter VM with Hotpatch support
- Configurable Trusted Launch: Secure Boot, vTPM, and zone selection
- Optional Azure Disk Encryption using customer-managed keys
- Dynamic subnet validation with naming convention enforcement
- Modular input structure for VM, networking, and encryption settings
- Supports platform-managed encryption fallback if Key Vault is omitted

## 📦 VM Configuration

| Setting                     | Value                                                              |
|-----------------------------|---------------------------------------------------------------------|
| VM Name                     | `eksdemo2`                                                         |
| Region                      | `North Europe`                                                     |
| Size                        | `Standard_B1s` (1 vCPU, 1 GiB RAM)                                 |
| Image                       | `Windows Server 2022 Datacenter: Azure Edition Hotpatch - Gen2`    |
| Architecture                | `x64`                                                              |
| Availability Zone           | `3`                                                                |
| Security Type               | Trusted Launch (Secure Boot + vTPM enabled)                        |
| Admin Username              | `demo22`                                                           |
| Public Inbound Ports        | `RDP`                                                              |
| OS Disk Type                | `Premium SSD LRS`                                                  |
| OS Disk Size                | `128 GiB`                                                          |
| OS Disk Caching             | `ReadWrite`                                                        |
| Ephemeral OS Disk           | `Disabled`                                                         |
| Hibernation                 | `Disabled`                                                         |

## 🌐 Networking

- Virtual Network: `eksdemo2-vnet`
- Subnet: `default (10.0.0.0/24)`
- Public IP: `eksdemo2-ip`
- Accelerated Networking: `Disabled`
- Load Balancer: Not attached

## 🔐 Disk Encryption (Optional)

To enable Azure Disk Encryption:
1. Create a Key Vault with purge protection and soft delete.
2. Create a Key Encryption Key (KEK).
3. Pass the following settings:

```hcl
settings = {
  KeyVaultURL         = azurerm_key_vault.this.vault_uri
  KeyVaultResourceId  = azurerm_key_vault.this.id
  KeyEncryptionKeyURL = azurerm_key_vault_key.this.id
  KekVaultResourceId  = azurerm_key_vault.this.id
  EncryptionOperation = "EnableEncryption"
  KeyEncryptionAlgorithm = "RSA-OAEP"
  VolumeType          = "All"
}
```

If no Key Vault is provided, platform-managed encryption will be used by default.

## 📐 Subnet Validation

The `subnet` variable enforces naming conventions when `address_prefixes` is omitted:

```hcl
variable "subnet" {
  type = object({
    id               = string
    address_prefixes = optional(list(string), null)
  })
  validation {
    condition     = var.subnet.address_prefixes == null ? can(regex(".*subnets/snet-[0-9]{2}-[a-zA-Z0-9]+$", var.subnet.id)) : true
    error_message = "If no address prefix is specified, the subnet name must match the pattern: snet-<number>-<suffix>."
  }
}
```

## 🛠️ Usage

```bash
terraform init
terraform apply -var-file="custom.tfvars" -auto-approve
```

Example `custom.tfvars`:

```hcl
subnet = {
  id               = "/subscriptions/<sub-id>/resourceGroups/windowvmdemo/providers/Microsoft.Network/virtualNetworks/vnet-demo/subnets/snet-01-app"
  address_prefixes = null
}
```

## 📁 Structure

```
├── main.tf
├── variables.tf
├── terraform.tfvars (or custom.tfvars)
├── modules/
│   ├── vm/
│   ├── network/
│   └── encryption/
└── README.md
```

## 🧠 Notes

- Ensure all resources are in the same region (`North Europe`)
- Use dynamic references (`azurerm_subnet.subnet.id`) to avoid hardcoded IDs
- Platform-managed encryption is enabled by default if ADE is skipped

## 📜 License

MIT License. See [LICENSE](LICENSE) for details.
```

