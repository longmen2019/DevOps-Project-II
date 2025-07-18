variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_resource_group" "app_rg" {
  name     = "Day19-LM"
  location = "East US"
}

resource "azurerm_virtual_network" "main" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.app_rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "vm_nsg" {
  name                = "example-nsg"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "vm_ip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "example-nic"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_ip.id 
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

resource "null_resource" "deployment_prep" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "echo 'Deployment started at ${timestamp()}' > deployment-${replace(timestamp(), ":", "-")}.log"
  }
}

resource "azurerm_linux_virtual_machine" "demo_vm" {
  name                = "${var.prefix}-vm"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.main.id]
  disable_password_authentication = true

  depends_on = [null_resource.deployment_prep]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                 = "myosdisk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "echo '<html><body><h1>#28daysofAZTerraform is Awesome!</h1></body></html>' | sudo tee /var/www/html/index.html",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = file("~/.ssh/id_rsa")
      host        = azurerm_public_ip.vm_ip.ip_address
    }
  }

  provisioner "file" {
    source = "${path.module}/configs/sample.config"
    destination = "/home/azureuser/sample.conf"

    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = file("~/.ssh/id_rsa")
      host        = azurerm_public_ip.vm_ip.ip_address
    }
  }

  tags = {
    environment = "staging"
  }
}

output "vm_public_ip" {
  value = azurerm_public_ip.vm_ip.ip_address
}
