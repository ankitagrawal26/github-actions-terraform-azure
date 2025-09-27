output "app_service_id" {
  description = "ID of the App Service"
  value       = var.kind == "Linux" ? azurerm_linux_web_app.app[0].id : azurerm_windows_web_app.app[0].id
}

output "app_service_name" {
  description = "Name of the App Service"
  value       = var.kind == "Linux" ? azurerm_linux_web_app.app[0].name : azurerm_windows_web_app.app[0].name
}

output "app_service_default_site_hostname" {
  description = "Default site hostname of the App Service"
  value       = var.kind == "Linux" ? azurerm_linux_web_app.app[0].default_hostname : azurerm_windows_web_app.app[0].default_hostname
}

output "app_service_outbound_ip_addresses" {
  description = "Outbound IP addresses of the App Service"
  value       = var.kind == "Linux" ? azurerm_linux_web_app.app[0].outbound_ip_addresses : azurerm_windows_web_app.app[0].outbound_ip_addresses
}

output "app_service_possible_outbound_ip_addresses" {
  description = "Possible outbound IP addresses of the App Service"
  value       = var.kind == "Linux" ? azurerm_linux_web_app.app[0].possible_outbound_ip_addresses : azurerm_windows_web_app.app[0].possible_outbound_ip_addresses
}

output "app_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.asp.id
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.asp.name
}

output "identity_principal_id" {
  description = "Principal ID of the managed identity"
  value       = var.kind == "Linux" ? azurerm_linux_web_app.app[0].identity[0].principal_id : azurerm_windows_web_app.app[0].identity[0].principal_id
}

output "identity_tenant_id" {
  description = "Tenant ID of the managed identity"
  value       = var.kind == "Linux" ? azurerm_linux_web_app.app[0].identity[0].tenant_id : azurerm_windows_web_app.app[0].identity[0].tenant_id
}
