resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "dev"
  }
}


