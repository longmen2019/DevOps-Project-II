

```markdown
# 🌐 Day27 Azure Terraform Deployment — Multi-Region, Scalable, Secure

This project provisions a full-stack, production-grade Azure environment using **Terraform**, designed for high availability, security, and automation. It includes containerized frontend and backend apps, geo-replicated container registries, VMSS-based compute, PostgreSQL with read replicas, and secure networking via NSGs, Bastion, and NAT Gateway.

## 🚀 Architecture Overview

- **Regions**: Canada Central, East US, North Europe
- **Core Components**:
  - Azure Container Registry (ACR) with replication
  - Virtual Machine Scale Sets (VMSS) for frontend and backend
  - Application Gateway (WAF v2) with health probes
  - Azure Database for PostgreSQL Flexible Server + replica
  - Azure Bastion for secure VM access
  - NAT Gateway for outbound traffic
  - Managed Identities and Key Vault for secure access
  - Private DNS zones for internal resolution
  - Network Security Groups (NSGs) for traffic control

## 🛠️ Technologies Used

- **Terraform** (modular, region-aware)
- **Docker** (frontend and backend containers)
- **Azure CLI / Portal** (for validation and manual patching)
- **GitLab CI/CD** (optional integration)

## 📦 Modules & Resources

| Resource Type                  | Region         | Description                              |
|-------------------------------|----------------|------------------------------------------|
| ACR + Replication             | Canada Central, East US, North Europe | Container image distribution |
| App Gateway                   | North Europe   | Routing + WAF                            |
| VMSS (Frontend & Backend)     | North Europe   | Scalable compute                         |
| PostgreSQL + Replica          | North Europe   | Database with HA                         |
| Bastion + NSGs + PIPs         | North Europe   | Secure access                            |
| NAT Gateway                   | North Europe   | Outbound traffic                         |
| Key Vault + Managed Identity  | North Europe   | Secrets and identity                     |
| Private DNS Zone              | Global         | Internal name resolution                 |
| Storage Account               | North Europe   | Terraform state                          |

## 🧪 Deployment Steps

1. Clone the repo:
   ```bash
   git clone https://github.com/longmen2019/DevOps-Project-II.git
   cd DevOps-Project-II/Day27-AZ-Terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review and apply the plan:
   ```bash
   terraform plan
   terraform apply
   ```

4. Validate:
   - App Gateway health probe status
   - VMSS instance connectivity
   - PostgreSQL replica sync
   - Bastion access and NSG rules

## 🧠 Lessons Learned

- Health probe failures often stem from NSG misalignment or incorrect app binding (`0.0.0.0`)
- Terraform imports for existing resources require precise naming and ID mapping
- Container registry replication improves image availability across regions

## 📁 Project Link

[GitHub Repository](https://github.com/longmen2019/DevOps-Project-II/tree/main/Day27-AZ-Terraform)

## 📌 Future Improvements

- Add monitoring via Azure Monitor and Log Analytics
- Integrate GitLab CI/CD pipeline for automated provisioning
- Refactor modules for reusability across environments

---

**Author**: [longmen2019](https://github.com/longmen2019)  
**License**: MIT
```
