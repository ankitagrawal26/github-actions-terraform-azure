output "nsg" {
  value = {
    id   = azurerm_network_security_group.nsg.id
    name = azurerm_network_security_group.nsg.name
  }
}


