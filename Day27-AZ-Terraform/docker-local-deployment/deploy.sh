#!/bin/bash

# Set variables
ACR_NAME="prodr9acosacrr9acos"
ACR_LOGIN_SERVER="${ACR_NAME}.azurecr.io"
IMAGE_NAME="frontend"
TAG="latest"
PROJECT_DIR="$HOME/downloads/day27-az-terraform/docker-local-deployment"

# Navigate to project directory
cd "$PROJECT_DIR" || exit

# Log in to Azure Container Registry
az acr login --name "$ACR_NAME"

# Build and tag image
docker build -t "$ACR_LOGIN_SERVER/$IMAGE_NAME:$TAG" .

# Push image to ACR
docker push "$ACR_LOGIN_SERVER/$IMAGE_NAME:$TAG"

# Verify image tag in ACR
az acr repository show-tags --name "$ACR_NAME" --repository "$IMAGE_NAME"

# Export environment variables for Docker Compose
export PORT=3000
export CI_COMMIT_REF_SLUG=$TAG

# Start services with Docker Compose
docker-compose up -d
