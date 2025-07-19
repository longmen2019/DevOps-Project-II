data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "tag" {
  name         = "allowed_tag"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "acceptance test policy definition"

  policy_rule = jsonencode({
    "if" = {
      "anyOf" = [
        {
          "field"  = "tags[${var.allowed_tags[0]}]"
          "exists" = false
        },
        {
          "field"  = "tags[${var.allowed_tags[1]}]"
          "exists" = false
        }
      ]
    },
    "then" = {
      "effect" = "deny"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "example" {
  name                 = "tag_assignment"
  policy_definition_id = azurerm_policy_definition.tag.id
  subscription_id      = data.azurerm_subscription.current.id
}
 

resource "azurerm_policy_definition" "vm_size" {
  name         = "vm_size"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "acceptance vm policy definition"

  policy_rule = jsonencode({
    "if" = {
      "anyOf" = [
        {
          "field"  = "Microsoft.Compute/virtualMachines/sku.name"
          "notIn" = ["${var.vm_sizes[0]}", "${var.vm_sizes[1]}"]
        }        
      ]
    },
    "then" = {
      "effect" = "deny"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "example1" {
  name                 = "size_assignment"
  policy_definition_id = azurerm_policy_definition.vm_size.id
  subscription_id      = data.azurerm_subscription.current.id
}
 

resource "azurerm_policy_definition" "location" {
  name         = "location"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed locations policy"

  policy_rule = jsonencode({
    "if" = {
      "anyOf" = [
        {
          "field"  = "location"
          "notIn" = ["${var.location[0]}", "${var.location[1]}"]
        }        
      ]
    },
    "then" = {
      "effect" = "deny"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "example2" {
  name                 = "location_assignment"
  policy_definition_id = azurerm_policy_definition.location.id
  subscription_id      = data.azurerm_subscription.current.id
}
 