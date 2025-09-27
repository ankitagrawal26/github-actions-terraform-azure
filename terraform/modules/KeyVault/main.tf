data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = var.kv_name
  location            = var.location
  resource_group_name = var.rgname
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  enabled_for_deployment      = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  purge_protection_enabled    = var.purge_protection_enabled
  soft_delete_retention_days  = var.soft_delete_retention_days

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = var.key_permissions
    secret_permissions = var.secret_permissions
    storage_permissions = var.storage_permissions
  }

  network_acls {
    default_action = var.network_acls_default_action
    bypass         = var.network_acls_bypass
    ip_rules       = var.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secrets

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_key" "keys" {
  for_each = var.keys

  name         = each.key
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = each.value.key_type
  key_size     = each.value.key_size
  key_opts     = each.value.key_opts
}
