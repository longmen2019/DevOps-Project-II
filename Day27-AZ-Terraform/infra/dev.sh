#!/bin/bash

# Exit if any command fails
set -e

# Define variables
RG_NAME="three-tier-app-rg-prod"
LOCATION="northeurope"
STORAGE_ACCOUNT="tfstate$(date +%s)"  # Globally unique name with timestamp
CONTAINER_NAME="vhds-lm"

echo "📦 Creating Resource Group: $RG_NAME..."
az group create --name "$RG_NAME" --location "$LOCATION"

echo "🗄️ Creating Storage Account: $STORAGE_ACCOUNT..."
az storage account create \
  --name "$STORAGE_ACCOUNT" \
  --resource-group "$RG_NAME" \
  --location "$LOCATION" \
  --sku Standard_LRS

echo "🔐 Retrieving Storage Account Key..."
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group "$RG_NAME" \
  --account-name "$STORAGE_ACCOUNT" \
  --query "[0].value" -o tsv)

echo "🪣 Creating Blob Container: $CONTAINER_NAME..."
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT" \
  --account-key "$ACCOUNT_KEY" \
  --public-access off

echo "✅ All resources created successfully!"
