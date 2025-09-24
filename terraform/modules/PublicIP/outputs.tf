output "public_ip" {
  value = {
    id         = azurerm_public_ip.pip.id
    name       = azurerm_public_ip.pip.name
    ip_address = azurerm_public_ip.pip.ip_address
  }
}


