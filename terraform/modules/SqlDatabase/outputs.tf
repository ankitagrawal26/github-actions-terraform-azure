output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.name
}

output "sql_server_fqdn" {
  description = "FQDN of the SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_databases" {
  description = "Map of created SQL databases"
  value       = { for k, v in azurerm_mssql_database.sql_database : k => v.id }
}

output "sql_database_names" {
  description = "Names of the created SQL databases"
  value       = [for k, v in azurerm_mssql_database.sql_database : v.name]
}

output "firewall_rules" {
  description = "Map of created firewall rules"
  value       = { for k, v in azurerm_mssql_firewall_rule.firewall_rules : k => v.id }
}
