resource "azurerm_resource_group" "rg" {
  name     = var.rg_name 
  location = var.rg_location 
}

#####################################
# VIRTUAL NETWORK
#####################################
module "vnet" {
   source        = "./modules/vnet"
   rg_name       = azurerm_resource_group.rg.name
 
   rg_location   = var.rg_location 
   vnet_name     = var.vnet_name 
 }
#####################################
# SUBNET
#####################################
module "snet" {
  source                    = "./modules/subnet"
  snet_name                 = var.snet_name
  rg_name                   = azurerm_resource_group.rg.name
  vnet_name                 = module.vnet.vnet_name 
}   
#####################################
# PUBLIC IP
#####################################
module "pub_ip" {
  source                 = "./modules/public_ip"
  prefix                 = var.prefix
  rg_name                = azurerm_resource_group.rg.name
  rg_location            = var.rg_location
  
}
#####################################
# NETWORK INTERFACE
#####################################
module "nic" {
  source = "./modules/network_interface"
  nic_name                = var.nic_name 
  rg_location             = var.rg_location
  rg_name                 = azurerm_resource_group.rg.name

  public_id = module.pub_ip.public_ip_id
  subnet_id = module.snet.subnet_id

}
#####################################
# VIRTUAL MACHINE 
#####################################
module  "vm" {
  source                    = "./modules/virtual_machine"
  prefix                    = var.prefix
  rg_name = azurerm_resource_group.rg.name
  rg_location               = var.rg_location  
  vm_size                   = var.vm_size 
  nic_id                    = [module.nic.nic_id]
  publisher                 = var.publisher 
  offer                     = var.offer 
  sku                       = var.sku   
  admin_username = var.admin_username
  admin_password = var.admin_password 
  ssh_public_key = var.ssh_public_key     
}

#####################################
# KEY VAULT
#####################################
data "azurerm_client_config" "current" {}

module  "kv" {
  source                         = "./modules/keyvault"  
  rg_location                    = var.rg_location
  rg_name                        = azurerm_resource_group.rg.name

  kv_name                        = var.kv_name 
  vm_principal_id                = module.vm.vm_principal_id 
  key_permissions                = var.key_permissions
  secret_permissions             = var.secret_permissions
  storage_permissions = var.storage_permissions
  }

#####################################
# KEY VAULT SECRET
#####################################
module "kv_secret" {
  source                 = "./modules/keyvault_secret"
  kv_secret_name         = var.kv_secret_name 
  kv_secret_value        = var.kv_secret_value
  key_vault_id = module.kv.key_vault_id
}
