resource "azurerm_log_analytics_workspace" "law" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  daily_quota_gb      = var.daily_quota_gb

  tags = {
    environment = var.environment
  }
}

resource "azurerm_log_analytics_solution" "solutions" {
  for_each = var.solutions

  solution_name         = each.key
  location              = var.location
  resource_group_name   = var.rgname
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = each.value.publisher
    product   = each.value.product
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings" {
  for_each = var.diagnostic_settings

  name                       = each.key
  target_resource_id         = each.value.target_resource_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  dynamic "enabled_log" {
    for_each = each.value.enabled_logs
    content {
      category       = enabled_log.value.category
      category_group = enabled_log.value.category_group

      retention_policy {
        enabled = enabled_log.value.retention_policy.enabled
        days    = enabled_log.value.retention_policy.days
      }
    }
  }

  dynamic "metric" {
    for_each = each.value.enabled_metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled

      retention_policy {
        enabled = metric.value.retention_policy.enabled
        days    = metric.value.retention_policy.days
      }
    }
  }
}

resource "azurerm_log_analytics_saved_search" "saved_searches" {
  for_each = var.saved_searches

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  category                   = each.value.category
  display_name               = each.value.display_name
  name                       = each.key
  query                      = each.value.query
}
