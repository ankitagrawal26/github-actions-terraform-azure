output "vnet" {
  value = {
    id   = azurerm_virtual_network.vnet.id
    name = azurerm_virtual_network.vnet.name
  }
}


