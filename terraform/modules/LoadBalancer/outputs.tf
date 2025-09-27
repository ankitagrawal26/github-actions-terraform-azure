output "load_balancer_id" {
  description = "ID of the Load Balancer"
  value       = azurerm_lb.lb.id
}

output "load_balancer_name" {
  description = "Name of the Load Balancer"
  value       = azurerm_lb.lb.name
}

output "load_balancer_private_ip_address" {
  description = "Private IP address of the Load Balancer"
  value       = var.load_balancer_type == "private" ? azurerm_lb.lb.private_ip_address : null
}

output "public_ip_id" {
  description = "ID of the public IP (if public load balancer)"
  value       = var.load_balancer_type == "public" ? azurerm_public_ip.lb_public_ip[0].id : null
}

output "public_ip_address" {
  description = "Public IP address (if public load balancer)"
  value       = var.load_balancer_type == "public" ? azurerm_public_ip.lb_public_ip[0].ip_address : null
}

output "backend_pool_id" {
  description = "ID of the backend address pool"
  value       = azurerm_lb_backend_address_pool.backend_pool.id
}

output "backend_pool_name" {
  description = "Name of the backend address pool"
  value       = azurerm_lb_backend_address_pool.backend_pool.name
}

output "frontend_ip_configuration" {
  description = "Frontend IP configuration"
  value       = azurerm_lb.lb.frontend_ip_configuration
}
