output "workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.law.id
}

output "workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.law.name
}

output "workspace_primary_shared_key" {
  description = "Primary shared key of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.law.primary_shared_key
  sensitive   = true
}

output "workspace_secondary_shared_key" {
  description = "Secondary shared key of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.law.secondary_shared_key
  sensitive   = true
}

output "workspace_portal_url" {
  description = "Portal URL of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.law.portal_url
}

output "solutions" {
  description = "Map of installed Log Analytics solutions"
  value       = { for k, v in azurerm_log_analytics_solution.solutions : k => v.id }
}

output "saved_searches" {
  description = "Map of created saved searches"
  value       = { for k, v in azurerm_log_analytics_saved_search.saved_searches : k => v.id }
}
