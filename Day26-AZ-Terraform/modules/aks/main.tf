# resource "azurerm_resource_group" "rg-lm" {
#   name     = "demo-rg-lm"
#   location = var.location 
# }

data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
  include_preview = false 
}


resource "azurerm_kubernetes_cluster" "aks-cluster-lm3" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.resource_group_name}-cluster"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.resource_group_name}-nodes"


  
default_node_pool {
  name                  = "internal"  
  vm_size               = "Standard_D2s_v3"
  zones                 = [2]
  auto_scaling_enabled  = true 
  max_count             = 3 
  min_count             = 1 
  os_disk_size_gb       = 30 
  type                  = "VirtualMachineScaleSets"         


  
}
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
        key_data = trimspace(file(var.ssh_public_key))
    }
  }

  network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
  }

    
  }