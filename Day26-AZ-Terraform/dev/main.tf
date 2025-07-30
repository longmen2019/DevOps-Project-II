resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group_name
  location = var.location
}

module "service_principal" {
  source                    = "./modules/ServicePrincipal"
  service_principal_name    = var.service_principal_name
  depends_on                = [azurerm_resource_group.rg1]
}

resource "azurerm_role_assignment" "rolespn" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = module.service_principal.service_principal_object_id
  depends_on           = [module.service_principal]
}

module "keyvault" {
  source                        = "./modules/keyvault"
  keyvault_name                 = var.keyvault_name
  resource_group_name           = var.resource_group_name
  resource_group_location       = var.location
  service_principal_name        = var.service_principal_name
  service_principal_object_id   = module.service_principal.service_principal_object_id
  service_principal_tenant_id   = module.service_principal.service_principal_tenant_id
  depends_on                    = [module.service_principal]
}

resource "azurerm_key_vault_secret" "sp_secret" {
  name         = module.service_principal.client_id
  value        = module.service_principal.client_secret
  key_vault_id = module.keyvault.keyvault_id
  depends_on   = [module.keyvault]
}

module "aks" {
  source                      = "./modules/aks"
  service_principal_name      = var.service_principal_name
  client_id                   = module.service_principal.client_id
  client_secret               = module.service_principal.client_secret
  location                    = var.location
  resource_group_name         = var.resource_group_name
  cluster_name                = var.cluster_name
  node_pool_name              = var.node_pool_name
  depends_on                  = [module.service_principal]
}

# Optional: Uncomment to generate kubeconfig locally
# resource "local_file" "kubeconfig" {
#   filename   = "./kubeconfig"
#   content    = module.aks.config
#   depends_on = [module.aks]
# }
