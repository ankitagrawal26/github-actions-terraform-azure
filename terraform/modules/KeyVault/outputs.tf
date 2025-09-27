output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.kv.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}

output "key_vault_tenant_id" {
  description = "Tenant ID of the Key Vault"
  value       = azurerm_key_vault.kv.tenant_id
}

output "secrets" {
  description = "Map of created secrets"
  value       = { for k, v in azurerm_key_vault_secret.secrets : k => v.id }
}

output "keys" {
  description = "Map of created keys"
  value       = { for k, v in azurerm_key_vault_key.keys : k => v.id }
}
