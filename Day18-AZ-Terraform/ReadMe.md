

```markdown
# 🎯 Azure QR Code Generator – Terraform Deployment

This project provisions an Azure Linux Function App using Terraform to host a serverless QR code generation API. The function takes a URL input and returns a QR code image, storing it securely in Azure Blob Storage.

---

## 📦 What It Deploys

- **Resource Group**: `day18-rg` in *Canada Central*
- **Storage Account**: `longmenazureterraform` (Standard tier, locally redundant)
- **App Service Plan**: Linux-based, SKU `B1`
- **Linux Function App**: Node.js v18 runtime configured for QR code generation

---

## 🚀 QR Code API Endpoint

Once deployed, your Azure Function will expose an endpoint like:

```
https://<function-app-name>.azurewebsites.net/api/GenerateQRCode
```

### 🧪 Sample `curl` Request

```bash
curl -X GET https://example-linux-function-app-LM.azurewebsites.net/api/GenerateQRCode \
     -H "Content-Type: application/json" \
     -d '{"url":"https://www.thecloudopscommunity.org"}'
```

The function responds with a JSON payload:

```json
{
  "qr_code_url": "https://<your-storage-account>.blob.core.windows.net/qr-codes/example.png"
}
```

---

## 🔧 Prerequisites

- [Terraform](https://www.terraform.io/) ≥ 1.3
- Azure CLI authenticated
- [Azure Functions Core Tools](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local) installed
- Node.js ≥ 18 for local development

---

## 📁 Usage

### 1. Deploy Infrastructure

```bash
terraform init
terraform apply
```

### 2. Publish Function Code

```bash
func azure functionapp publish example-linux-function-app-LM
```

---

## 🌐 Tech Stack

- **Terraform** for infrastructure-as-code
- **Node.js & Azure Functions** for serverless execution
- **Azure Blob Storage** for hosting generated QR images
- **QRCode NPM Package** for image creation

---

## 🧼 Cleanup

```bash
terraform destroy
```

---

## 👨‍💻 Maintainer

Built by Longmen — architecting scalable QR-driven workflows into the cloud ☁️📷  
Let me know if you'd like a version with CI/CD integration or slot-based deployments!
```
