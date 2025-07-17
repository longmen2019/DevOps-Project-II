
```markdown
# 🚀 Azure Linux Function App Deployment with Terraform

This project uses [Terraform](https://www.terraform.io/) to provision a fully functional **Azure Linux Function App** including its required infrastructure components.

## 📦 What It Deploys

- **Resource Group**: `day18-rg` in Canada Central
- **Storage Account**: `longmenazureterraform` (Standard tier, locally redundant)
- **App Service Plan**: Linux-based `example-app-service-plan` with SKU `B1`
- **Linux Function App**: `example-linux-function-app-LM` configured with Node.js v18 runtime

## 🛠️ Prerequisites

- Azure CLI authenticated and configured
- Terraform ≥ 1.3 installed
- Azure subscription with sufficient permissions

## 📁 Project Structure

```plaintext
.
├── main.tf            # Core Terraform definitions
├── variables.tf       # (Optional) Variable definitions
├── outputs.tf         # (Optional) Output configuration
└── README.md          # Project documentation
```

## ⚙️ How to Deploy

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Preview the deployment**
   ```bash
   terraform plan
   ```

3. **Apply the configuration**
   ```bash
   terraform apply
   ```

4. **Confirm when prompted** to begin provisioning resources.

## 🌐 Function App Details

The Function App is pre-configured for Node.js 18. You can deploy your function code using [Azure Functions Core Tools](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local).

Example publish command:
```bash
func azure functionapp publish example-linux-function-app-LM
```

## 📋 Notes

- The storage account name must be globally unique.
- Default authentication is not configured—consider integrating with Entra ID for secure access.
- Be sure to clean up resources to avoid incurring unexpected costs:
  ```bash
  terraform destroy
  ```

## 👨‍💻 Author

Created and maintained by the CloudOps wizard behind longmen@docker 🧙‍♂️  
If you'd like to extend this with slot-based deployments, automated publishing, or role-based access control, enhancements are welcome!

```
