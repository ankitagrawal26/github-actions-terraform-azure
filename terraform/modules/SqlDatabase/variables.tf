variable "sql_server_name" {
  description = "Name of the SQL Server"
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

variable "sql_server_version" {
  description = "Version of the SQL Server"
  type        = string
  default     = "12.0"
  validation {
    condition     = contains(["2.0", "12.0"], var.sql_server_version)
    error_message = "SQL Server version must be '2.0' or '12.0'."
  }
}

variable "admin_username" {
  description = "Administrator username for the SQL Server"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for the SQL Server"
  type        = string
  sensitive   = true
}

variable "minimum_tls_version" {
  description = "Minimum TLS version for the SQL Server"
  type        = string
  default     = "1.2"
  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "Minimum TLS version must be '1.0', '1.1', or '1.2'."
  }
}

variable "azuread_admin_login_username" {
  description = "Azure AD administrator login username"
  type        = string
  default     = null
}

variable "azuread_admin_object_id" {
  description = "Azure AD administrator object ID"
  type        = string
  default     = null
}

variable "azuread_admin_tenant_id" {
  description = "Azure AD administrator tenant ID"
  type        = string
  default     = null
}

variable "firewall_rules" {
  description = "Map of firewall rules"
  type        = map(object({
    start_ip = string
    end_ip   = string
  }))
  default = {
    "AllowAllWindowsAzureIps" = {
      start_ip = "0.0.0.0"
      end_ip   = "0.0.0.0"
    }
  }
}

variable "databases" {
  description = "Map of databases to create"
  type        = map(object({
    collation                       = string
    license_type                    = string
    max_size_gb                     = number
    sku_name                        = string
    zone_redundant                  = bool
    short_term_retention_days       = number
    long_term_weekly_retention      = string
    long_term_monthly_retention     = string
    long_term_yearly_retention      = string
    long_term_week_of_year          = number
    threat_detection_enabled        = bool
    threat_detection_disabled_alerts = list(string)
    threat_detection_email_account_admins = bool
    threat_detection_email_addresses = list(string)
    threat_detection_retention_days = number
    threat_detection_storage_access_key = string
    threat_detection_storage_endpoint = string
  }))
  default = {
    "main-db" = {
      collation                       = "SQL_Latin1_General_CP1_CI_AS"
      license_type                    = "LicenseIncluded"
      max_size_gb                     = 2
      sku_name                        = "Basic"
      zone_redundant                  = false
      short_term_retention_days       = 7
      long_term_weekly_retention      = "PT0S"
      long_term_monthly_retention     = "PT0S"
      long_term_yearly_retention      = "PT0S"
      long_term_week_of_year          = 1
      threat_detection_enabled        = false
      threat_detection_disabled_alerts = []
      threat_detection_email_account_admins = false
      threat_detection_email_addresses = []
      threat_detection_retention_days = 0
      threat_detection_storage_access_key = ""
      threat_detection_storage_endpoint = ""
    }
  }
}

variable "enable_vulnerability_assessment" {
  description = "Enable vulnerability assessment"
  type        = bool
  default     = false
}

variable "va_storage_container_path" {
  description = "Storage container path for vulnerability assessment"
  type        = string
  default     = null
}

variable "va_storage_endpoint" {
  description = "Storage endpoint for vulnerability assessment"
  type        = string
  default     = null
}

variable "va_storage_account_access_key" {
  description = "Storage account access key for vulnerability assessment"
  type        = string
  default     = null
  sensitive   = true
}

variable "va_storage_container_sas_key" {
  description = "Storage container SAS key for vulnerability assessment"
  type        = string
  default     = null
  sensitive   = true
}

variable "va_recurring_scans_enabled" {
  description = "Enable recurring scans for vulnerability assessment"
  type        = bool
  default     = false
}

variable "va_email_subscription_admins" {
  description = "Email subscription admins for vulnerability assessment"
  type        = bool
  default     = false
}

variable "va_emails" {
  description = "Email addresses for vulnerability assessment"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
