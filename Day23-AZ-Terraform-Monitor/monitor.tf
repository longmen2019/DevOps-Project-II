resource "azurerm_monitor_action_group" "main" {
  name                = "example-actiongroup-lm"
  resource_group_name = azurerm_resource_group.app_rg.name
  short_name          = "exampleact"

  email_receiver {
    name          = "sendtoadmin"
    email_address = var.email
  }
}

resource "azurerm_monitor_metric_alert" "example" {
  name                = "example-metricalert-lm"
  resource_group_name = azurerm_resource_group.app_rg.name
  scopes              = [azurerm_linux_virtual_machine.demo_vm.id]
  description         = "Action will be triggered when CPU is greater than 60."

  criteria {
    metric_namespace = "Microsoft.Compute/VirtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 60

#     dimension {
#       name     = "ApiName"
#       operator = "Include"
#       values   = ["*"]
#     }
  }

action {
action_group_id = azurerm_monitor_action_group.main.id
}
}


resource "azurerm_monitor_metric_alert" "disk" {
  name                = "example-metricalert-lm2"
  resource_group_name = azurerm_resource_group.app_rg.name
  scopes              = [azurerm_linux_virtual_machine.demo_vm.id]
  description         = "Action will be triggered when Free disk space is less than 20."

  criteria {
    metric_namespace = "Microsoft.Compute/VirtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 20

    # dimension {
    #   name     = "ApiName"
    #   operator = "Include"
    #   values   = ["*"]
    # }
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}