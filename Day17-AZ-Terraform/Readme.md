

```markdown
# Azure App Service Deployment with Staging Slot

This Terraform configuration sets up an Azure App Service environment complete with a **resource group**, **app service plan**, **main web app**, **staging slot**, and **source control integration** for both environments.

## 💡 Overview

This project deploys:

- A resource group in `Canada Central`
- An App Service Plan (`Standard S1`)
- A web application with staging slot
- Source control integration from GitHub for both production and staging
- Automatic activation of the staging slot

## 🚀 Components

| Resource Type                   | Name                           | Description                                                 |
|--------------------------------|--------------------------------|-------------------------------------------------------------|
| Resource Group                 | `${prefix}-rg`                | Holds all resources                                         |
| App Service Plan              | `${prefix}-asp`               | Hosts the App Service                                       |
| App Service (Web App)         | `${prefix}-webapp`            | Primary production web application                          |
| App Service Slot              | `${prefix}-staging`           | Staging deployment slot                                     |
| Source Control (Main)        | GitHub `master` branch        | Connects main app to version-controlled code                |
| Source Control (Staging Slot)| GitHub staging branch         | Connects staging slot to isolated working branch            |
| Active Slot Configuration     | `${prefix}-staging`           | Makes staging slot active                                   |

## ⚙️ Usage

1. Update the `prefix` variable in `main.tf` if needed:
   ```hcl
   variable "prefix" {
     default = "day17-lm"
     type    = string
   }
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Preview the deployment:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## 🔗 Source Control Integration

- **Main App Repo**: [`awesome-terraform`](https://github.com/longmen2022/awesome-terraform) on the `master` branch
- **Staging Slot Repo**: Same repo but on `appServiceSlot_Working_DO_NOT_MERGE` branch

## 📌 Notes

- Ensure the GitHub repository is publicly accessible or properly authenticated.
- The staging slot is configured to be the active slot on deployment.

