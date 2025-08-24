
```markdown
# AKS Upgrade & Deployment Workflow

This repository contains infrastructure and application deployment configurations for managing an Azure Kubernetes Service (AKS) cluster using Terraform and `kubectl`. It includes automated scaling, image upgrades, and cluster version upgrades.

## 📦 Contents

- `sampleapp.yaml` — Kubernetes manifest for deploying the sample app
- `terraform.tfstate` — Terraform state file (do not edit manually)
- AKS upgrade and node pool management scripts

## 🚀 Prerequisites

- Azure CLI (`az`)
- Terraform (`>=1.3`)
- `kubectl` configured with AKS credentials
- An active Azure subscription with sufficient vCPU quota

## 🔧 Setup Instructions

### 1. Authenticate with Azure
```bash
az login
```

### 2. Get AKS Credentials
```bash
az aks get-credentials \
  --resource-group rg-sharing-haddock \
  --name cluster-one-mallard \
  --overwrite-existing
```

### 3. Verify Cluster Access
```bash
kubectl get nodes
```

## 📈 Deploy Sample App

```bash
kubectl apply -f sampleapp.yaml
kubectl get svc
```

## ⚙️ Enable Autoscaling

```bash
kubectl autoscale deployment nginx-deployment \
  --cpu-percent=50 \
  --min=3 \
  --max=10
```

## 🔄 Upgrade AKS Cluster

```bash
az aks upgrade \
  --resource-group rg-sharing-haddock \
  --name cluster-one-mallard \
  --kubernetes-version 1.31.1
```

## 🛠 Upgrade Node Pool Image

Ensure surge settings are compatible:
```bash
az aks nodepool update \
  --resource-group rg-sharing-haddock \
  --cluster-name cluster-one-mallard \
  --name agentpool \
  --max-surge 1
```

Then upgrade the node image:
```bash
az aks nodepool upgrade \
  --resource-group rg-sharing-haddock \
  --cluster-name cluster-one-mallard \
  --nodepool-name agentpool \
  --node-image-only
```

## 🧠 Notes

- System node pools require surge nodes for upgrades.
- Quota issues may block upgrades; request increases via [Azure Quotas](https://learn.microsoft.com/en-us/azure/quotas/view-quotas).
- Use Terraform for reproducible infrastructure provisioning.

## 📜 License

MIT License. See `LICENSE` file for details.