variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
}

variable "rgname" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "kind" {
  description = "Kind of App Service Plan"
  type        = string
  default     = "Linux"
  validation {
    condition     = contains(["Linux", "Windows", "WindowsContainer"], var.kind)
    error_message = "Kind must be 'Linux', 'Windows', or 'WindowsContainer'."
  }
}

variable "reserved" {
  description = "Is this App Service Plan reserved (for Linux)"
  type        = bool
  default     = true
}

variable "sku_tier" {
  description = "SKU tier for the App Service Plan"
  type        = string
  default     = "Basic"
  validation {
    condition     = contains(["Free", "Basic", "Standard", "Premium", "PremiumV2", "PremiumV3", "Isolated"], var.sku_tier)
    error_message = "SKU tier must be one of the valid Azure App Service tiers."
  }
}

variable "sku_size" {
  description = "SKU size for the App Service Plan"
  type        = string
  default     = "B1"
}

variable "linux_fx_version" {
  description = "Linux FX version (e.g., 'DOCKER|nginx:latest')"
  type        = string
  default     = null
}

variable "windows_fx_version" {
  description = "Windows FX version"
  type        = string
  default     = null
}

variable "dotnet_framework_version" {
  description = ".NET Framework version"
  type        = string
  default     = "v4.0"
}

variable "php_version" {
  description = "PHP version"
  type        = string
  default     = null
}

variable "python_version" {
  description = "Python version"
  type        = string
  default     = null
}

variable "node_default_version" {
  description = "Node.js default version"
  type        = string
  default     = null
}

variable "java_version" {
  description = "Java version"
  type        = string
  default     = null
}

variable "java_container" {
  description = "Java container"
  type        = string
  default     = null
}

variable "java_container_version" {
  description = "Java container version"
  type        = string
  default     = null
}

variable "always_on" {
  description = "Enable Always On"
  type        = bool
  default     = false
}

variable "ftps_state" {
  description = "State of FTP / FTPS service"
  type        = string
  default     = "Disabled"
  validation {
    condition     = contains(["AllAllowed", "FtpsOnly", "Disabled"], var.ftps_state)
    error_message = "FTPS state must be 'AllAllowed', 'FtpsOnly', or 'Disabled'."
  }
}

variable "http2_enabled" {
  description = "Enable HTTP/2"
  type        = bool
  default     = false
}

variable "min_tls_version" {
  description = "Minimum TLS version"
  type        = string
  default     = "1.2"
  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.min_tls_version)
    error_message = "Minimum TLS version must be '1.0', '1.1', or '1.2'."
  }
}

variable "scm_min_tls_version" {
  description = "Minimum TLS version for SCM"
  type        = string
  default     = "1.2"
  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.scm_min_tls_version)
    error_message = "SCM minimum TLS version must be '1.0', '1.1', or '1.2'."
  }
}

variable "use_32_bit_worker_process" {
  description = "Use 32-bit worker process"
  type        = bool
  default     = true
}

variable "app_settings" {
  description = "App settings for the App Service"
  type        = map(string)
  default     = {}
}

variable "connection_string_name" {
  description = "Name of the connection string"
  type        = string
  default     = null
}

variable "connection_string_type" {
  description = "Type of the connection string"
  type        = string
  default     = "SQLServer"
  validation {
    condition     = contains(["APIHub", "Custom", "DocDb", "EventHub", "MySQL", "NotificationHub", "PostgreSQL", "RedisCache", "ServiceBus", "SQLAzure", "SQLServer"], var.connection_string_type)
    error_message = "Connection string type must be one of the valid Azure connection string types."
  }
}

variable "connection_string_value" {
  description = "Value of the connection string"
  type        = string
  default     = null
  sensitive   = true
}

variable "identity_type" {
  description = "Type of managed identity"
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "Identity type must be 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'."
  }
}

variable "identity_ids" {
  description = "List of user assigned identity IDs"
  type        = list(string)
  default     = []
}

variable "custom_domain_name" {
  description = "Custom domain name for the App Service"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
