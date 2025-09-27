variable "public_ip_config" {
  type = object({
    enabled           = bool
    allocation_method = optional(string, "Static")
    sku               = optional(string, "Standard")
  })
  default = {
    enabled = false
  }
  validation {
    condition     = contains(["Static", "Dynamic"], var.public_ip_config.allocation_method)
    error_message = "Allocation method must be Static or Dynamic"
  }

  validation {
    condition = (
      var.virtual_machine_config.zone == null || var.public_ip_config.sku == "Standard"
    )
    error_message = "If a zone is specified, the Public IP SKU must be set to 'Standard'."
  }

  description = <<-DOC
  ```
    enabled: Optionally select true if a public ip should be created. Defaults to false.
    allocation_method: The allocation method of the public ip that will be created. Defaults to static.  
    zones: Optionally specify an availibility zone for the public ip. Defaults to null.    
    sku: Optionally specify the sku of the public ip. Defaults to Standard.
  ```
  DOC
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the resources will be created."
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to add to the resources created in this module"
  default     = {}
}