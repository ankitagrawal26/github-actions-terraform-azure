output "vm_id" {
  description = "ID of the Virtual Machine"
  value       = var.os_type == "linux" ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
}

output "vm_name" {
  description = "Name of the Virtual Machine"
  value       = var.os_type == "linux" ? azurerm_linux_virtual_machine.vm[0].name : azurerm_windows_virtual_machine.vm[0].name
}

output "vm_private_ip" {
  description = "Private IP address of the Virtual Machine"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_public_ip_id" {
  description = "Public IP ID of the Virtual Machine"
  value       = var.public_ip_id
}

output "network_interface_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.vm_nic.id
}
