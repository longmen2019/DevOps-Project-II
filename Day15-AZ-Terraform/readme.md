

```markdown
# 🛠️ Azure Virtual Network & VM Infrastructure (Terraform)

This project provisions a secure and scalable Azure network and virtual machine deployment using Terraform. It supports multiple VNets, subnets, network interfaces, VM sizes, and virtual network peering, with Bastion access for secure remote management.

---

## 🚀 Features

- Two virtual networks (`vnet1`, `vnet2`) with isolated subnets
- Bidirectional VNet peering (`peer1to2`, `peer2to1`)
- Modular NIC creation (`main1`, `main2`) with lifecycle safety
- Two Ubuntu Linux VMs deployed with custom sizing
- Bastion host connectivity (requires separate module setup)
- Dynamic resource naming using a configurable `prefix` variable
- NSG and subnet compatibility for SSH/RDP and Bastion routing
- Subscription-aware provider setup

---

## 📦 Structure

| File            | Description                                  |
|-----------------|----------------------------------------------|
| `main.tf`       | Core VM and NIC resources                    |
| `network.tf`    | VNet, subnet, and peering definitions        |
| `provider.tf`   | Azure provider configuration and credentials |
| `variables.tf`  | Input variables for naming and customization |
| `outputs.tf`    | Optional outputs for infrastructure metadata |

---

## 🔐 Requirements

- Azure CLI authenticated (`az login`)
- Terraform ≥ 1.3.0
- AzureRM provider ≥ 4.0.0
- Valid subscription ID in `provider.tf` or set via env var:
  ```bash
  export ARM_SUBSCRIPTION_ID="your-subscription-id"
  ```

---

## 🧱 Usage

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

> Note: If pre-existing resources (e.g. subnets or VNets) conflict with your config, use `terraform import`:
> ```bash
> terraform import azurerm_virtual_network.vnet1 '/subscriptions/xxxx/resourceGroups/your-rg/providers/Microsoft.Network/virtualNetworks/vnet1'
> ```

---

## 📡 Bastion Host Notes

To connect via Bastion:
- Deploy the Bastion service in the same VNet as your target VM or establish VNet peering.
- Ensure NSGs allow TCP 22 (SSH) or 3389 (RDP) from Bastion subnet ranges.
- Bastion subnet must be named `AzureBastionSubnet` with at least a /27 CIDR block.

---

## 📚 Reference Resources

- 🧭 **Hub-and-Spoke Terraform Tutorial by Microsoft**:  
  [Azure Hub-Spoke VNet Architecture with Terraform](https://learn.microsoft.com/en-us/azure/developer/terraform/azurerm/hub-spoke-hub-network)

- 🎥 **Terraform Infrastructure Walkthrough**:  
  [YouTube — Azure Terraform Project Tutorial](https://www.youtube.com/watch?v=NFi4XIFSJqc)

These guides provide design patterns and live examples you can incorporate into this project to extend peering, manage routing, and secure VM access via Bastion and firewalls.

---

## 🧰 Troubleshooting

- 🧠 `SkuNotAvailable`: Change VM size to `Standard_D2as_v5`, `Standard_E2as_v5`, etc.
- 🔁 `NicInUse`, `NicReservedForAnotherVm`: Wait 180 seconds or detach NIC manually.
- ⚠️ `InvalidParameter`, `ResourceAlreadyExists`: Use `terraform import` to sync state.
- 🐞 `Provider produced inconsistent result`: Retry apply or upgrade AzureRM provider.

---

## 🎯 License

This project is for educational and internal deployment purposes. Contributions welcome!

