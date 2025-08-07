
variable "location" {
  description = "Azure region for resources"
  type        = string
  
}

variable "environment" {
    type = string
    default = "prod"
  
}

variable "secondary_location" {
  description = "Secondary Azure region for disaster recovery"
  type        = string

}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string  
  default = "value"
}

# Network variables
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
  
}

variable "public_subnet_prefixes" {
  description = "Address prefixes for public subnets (frontend)"
  type        = list(string)
  
}

variable "private_subnet_prefixes" {
  description = "Address prefixes for private subnets (backend)"
  type        = list(string)
  
}

variable "database_subnet_prefixes" {
  description = "Address prefixes for database subnets"
  type        = list(string)
  
}

variable "bastion_subnet_prefix" {
  description = "Address prefix for Azure Bastion subnet"
  type        = string
  
}

variable "appgw_subnet_prefix" {
  description = "Address prefix for Application Gateway subnet"
  type        = string
  
}

# Compute variables
variable "frontend_vm_size" {
  description = "VM size for frontend instances"
  type        = string
  # default     = "Standard_B2s"
}

variable "backend_vm_size" {
  description = "VM size for backend instances"
  type        = string
  # default     = "Standard_B2s"
}

variable "frontend_instances" {
  description = "Number of frontend VM instances"
  type        = number
  # default     = 1
}

variable "backend_instances" {
  description = "Number of backend VM instances"
  type        = number
  # default     = 1
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  # default     = "adminuser"
}

variable "deploy_compute" {
  description = "Whether to deploy compute resources (VMSS). Set to false for initial infrastructure deployment."
  type        = bool
  default     = true
}

# Database variables
variable "postgres_sku_name" {
  description = "SKU name for PostgreSQL Flexible Server"
  type        = string
 
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  
}

variable "postgres_storage_mb" {
  description = "PostgreSQL storage in MB"
  type        = number
  
}

variable "postgres_db_name" {
  description = "PostgreSQL database name"
  type        = string
  
}

variable "postgres_db_port" {
  description = "Port for PostgreSQL database connection"
  type        = number
  
}

variable "postgres_db_sslmode" {
  description = "SSL mode for PostgreSQL database connection"
  type        = string
  default     = "require"
  validation {
    condition     = contains(["disable", "allow", "prefer", "require", "verify-ca", "verify-full"], var.postgres_db_sslmode)
    error_message = "Allowed values are: disable, allow, prefer, require, verify-ca, verify-full"
  }
}

# Docker Hub variables
variable "dockerhub_username" {
  description = "Docker Hub username for private image access"
  type        = string
  default     = ""
}

variable "dockerhub_password" {
  description = "Docker Hub password or Personal Access Token (PAT)"
  type        = string
  sensitive   = true
  default     = ""
}

# Docker image variables
variable "frontend_image" {
  description = "Frontend Docker image name including registry path (e.g., 'username/frontend:latest')"
  type        = string
  default     = "frontend:latest"
}

variable "backend_image" {
  description = "Backend Docker image name including registry path (e.g., 'username/backend:latest')"
  type        = string
  default     = "backend:latest"
}

# Monitoring variables
variable "log_analytics_sku" {
  description = "The SKU of the Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_days" {
  description = "The number of days to retain logs"
  type        = number
  default     = 30
}

variable "alert_email" {
  description = "Email address for monitoring alerts"
  type        = string
  default     = "admin@example.com"
}


# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)

}

# variable "georeplication_locations" {
#   description = "List of Azure locations where the container registry should be geo-replicated"
#   type        = list(string)
#   # default     = []
# }