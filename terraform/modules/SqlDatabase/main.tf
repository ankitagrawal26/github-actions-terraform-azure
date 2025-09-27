resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.rgname
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  minimum_tls_version          = var.minimum_tls_version

  azuread_administrator {
    login_username = var.azuread_admin_login_username
    object_id      = var.azuread_admin_object_id
    tenant_id      = var.azuread_admin_tenant_id
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_mssql_firewall_rule" "firewall_rules" {
  for_each = var.firewall_rules

  name             = each.key
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = each.value.start_ip
  end_ip_address   = each.value.end_ip
}

resource "azurerm_mssql_database" "sql_database" {
  for_each = var.databases

  name           = each.key
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = each.value.collation
  license_type   = each.value.license_type
  max_size_gb    = each.value.max_size_gb
  sku_name       = each.value.sku_name
  zone_redundant = each.value.zone_redundant

  short_term_retention_policy {
    retention_days = each.value.short_term_retention_days
  }

  long_term_retention_policy {
    weekly_retention  = each.value.long_term_weekly_retention
    monthly_retention = each.value.long_term_monthly_retention
    yearly_retention  = each.value.long_term_yearly_retention
    week_of_year      = each.value.long_term_week_of_year
  }

  threat_detection_policy {
    state                      = each.value.threat_detection_enabled ? "Enabled" : "Disabled"
    disabled_alerts            = each.value.threat_detection_disabled_alerts
    email_account_admins       = each.value.threat_detection_email_account_admins
    email_addresses            = each.value.threat_detection_email_addresses
    retention_days             = each.value.threat_detection_retention_days
    storage_account_access_key = each.value.threat_detection_storage_access_key
    storage_endpoint           = each.value.threat_detection_storage_endpoint
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_mssql_vulnerability_assessment" "va" {
  count = var.enable_vulnerability_assessment ? 1 : 0

  server_vulnerability_assessment_id = azurerm_mssql_server_vulnerability_assessment.server_va[0].id
  database_name                      = keys(var.databases)[0]
  storage_container_path             = var.va_storage_container_path
  storage_account_access_key         = var.va_storage_account_access_key
  storage_container_sas_key          = var.va_storage_container_sas_key
  recurring_scans {
    enabled                   = var.va_recurring_scans_enabled
    email_subscription_admins = var.va_email_subscription_admins
    emails                    = var.va_emails
  }
}

resource "azurerm_mssql_server_security_alert_policy" "security_policy" {
  count = var.enable_vulnerability_assessment ? 1 : 0

  resource_group_name        = var.rgname
  server_name               = azurerm_mssql_server.sql_server.name
  state                     = "Enabled"
  storage_endpoint          = var.va_storage_endpoint
  storage_account_access_key = var.va_storage_account_access_key
}

resource "azurerm_mssql_server_vulnerability_assessment" "server_va" {
  count = var.enable_vulnerability_assessment ? 1 : 0

  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.security_policy[0].id
  storage_container_path          = var.va_storage_container_path
  storage_account_access_key      = var.va_storage_account_access_key
  storage_container_sas_key       = var.va_storage_container_sas_key
  recurring_scans {
    enabled                   = var.va_recurring_scans_enabled
    email_subscription_admins = var.va_email_subscription_admins
    emails                    = var.va_emails
  }
}
