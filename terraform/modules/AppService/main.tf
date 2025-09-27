resource "azurerm_service_plan" "asp" {
  name                = "${var.app_service_name}-plan"
  location            = var.location
  resource_group_name = var.rgname
  os_type             = var.kind == "Linux" ? "Linux" : "Windows"
  sku_name            = "${var.sku_tier}_${var.sku_size}"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.rgname
  app_service_plan_id = azurerm_service_plan.asp.id

  site_config {
    linux_fx_version          = var.linux_fx_version
    windows_fx_version        = var.windows_fx_version
    dotnet_framework_version  = var.dotnet_framework_version
    php_version               = var.php_version
    python_version            = var.python_version
    java_version              = var.java_version
    java_container            = var.java_container
    java_container_version    = var.java_container_version
    always_on                 = var.always_on
    ftps_state                = var.ftps_state
    http2_enabled             = var.http2_enabled
    min_tls_version           = var.min_tls_version
    use_32_bit_worker_process = var.use_32_bit_worker_process
  }

  app_settings = var.app_settings

  connection_string {
    name  = var.connection_string_name
    type  = var.connection_string_type
    value = var.connection_string_value
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_app_service_custom_hostname_binding" "custom_domain" {
  count               = var.custom_domain_name != null ? 1 : 0
  hostname            = var.custom_domain_name
  app_service_name    = azurerm_app_service.app.name
  resource_group_name = var.rgname
}
