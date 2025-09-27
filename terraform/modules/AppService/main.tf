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

resource "azurerm_linux_web_app" "app" {
  count               = var.kind == "Linux" ? 1 : 0
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.rgname
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on     = var.always_on
    ftps_state    = var.ftps_state
    http2_enabled = var.http2_enabled
    application_stack {
      docker_image_name   = var.linux_fx_version
      dotnet_version      = var.dotnet_framework_version
      php_version         = var.php_version
      python_version      = var.python_version
      java_version        = var.java_version
      java_server         = var.java_container
      java_server_version = var.java_container_version
    }
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

resource "azurerm_windows_web_app" "app" {
  count               = var.kind == "Windows" ? 1 : 0
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.rgname
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on     = var.always_on
    ftps_state    = var.ftps_state
    http2_enabled = var.http2_enabled
    application_stack {
      dotnet_version = var.dotnet_framework_version
      php_version    = var.php_version
      java_version   = var.java_version
    }
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
  app_service_name    = var.kind == "Linux" ? azurerm_linux_web_app.app[0].name : azurerm_windows_web_app.app[0].name
  resource_group_name = var.rgname
}
