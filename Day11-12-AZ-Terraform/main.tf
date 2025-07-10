locals {
  
  formatted_name = lower(replace(var.project_name, " ", "-"))
  merge_tags = merge(var.default_tags, var.environment_tags)
  storage_formatted = replace(replace(lower(substr(var.strong_account_name,0,23)), " ", ""), "!", "")


  formatted_ports = split(",", (var.allowed_ports))
  nsg_rules = [for ports in local.formatted_ports: {
    name = "port-${port}"
    port = port 
    description = "Allowed traffic on port: ${port}"

  }]
  vm_size = lookup(var.vm_sizes, var.environment, lower("dev"))

  # assignment 9
  monthly_costs = [-50, 100, 75, 200]
  positive_cost = [for cost in local.monthly_costs: 
  abs(cost)]
  max_cost = max(local.positive_cost...)

  # assignment 11
  current_time = timestamp()
  resource_name = formatdate("YYYYMMDD", local.current_time)
  tag_date = formatdate("DD-MM-YYYY", local.current_time)

  # assignment 12
  config_content = sensitive(file(config.json))

}

resource "azurerm_resource_group" "rg" {
  name     = "${local.formatted_name}-rg"
  location = "westus2"


  tag = local.merge_tags
}

resource "azurerm_storage_account" "example" {
   
  name = local.storage_formatted
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = local.merge_tags



}
# Create Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "${local.formatted_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Here's where we need the dynamic block
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range         = "*"
      destination_port_range    = security_rule.value.port
      source_address_prefix     = "*"
      destination_address_prefix = "*"
      description               = security_rule.value.description
    }
  }
}
output "rgname" {
  value = azurerm_resource_group.rg.name
}

output "storage_name" {
  value = azurerm_storage_account.example.name
}

output "nsg_rules" {
  value = local.nsg_rules
}

output "security_name" {
  value = azurerm_network_security_group.example.name
}

