variable "workspace_name" {
  description = "Name of the Log Analytics workspace"
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

variable "sku" {
  description = "SKU of the Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
  validation {
    condition     = contains(["Free", "PerNode", "PerGB2018", "Standard", "Premium"], var.sku)
    error_message = "SKU must be one of: Free, PerNode, PerGB2018, Standard, Premium."
  }
}

variable "retention_in_days" {
  description = "Data retention in days"
  type        = number
  default     = 30
  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "Retention must be between 30 and 730 days."
  }
}

variable "daily_quota_gb" {
  description = "Daily quota in GB"
  type        = number
  default     = null
}

variable "solutions" {
  description = "Map of Log Analytics solutions to install"
  type        = map(object({
    publisher = string
    product   = string
  }))
  default = {
    "ContainerInsights" = {
      publisher = "Microsoft"
      product   = "OMSGallery/ContainerInsights"
    }
    "ServiceMap" = {
      publisher = "Microsoft"
      product   = "OMSGallery/ServiceMap"
    }
  }
}

variable "diagnostic_settings" {
  description = "Map of diagnostic settings"
  type        = map(object({
    target_resource_id = string
    enabled_logs = list(object({
      category        = string
      category_group  = string
      retention_policy = object({
        enabled = bool
        days    = number
      })
    }))
    enabled_metrics = list(object({
      category = string
      enabled  = bool
      retention_policy = object({
        enabled = bool
        days    = number
      })
    }))
  }))
  default = {}
}

variable "saved_searches" {
  description = "Map of saved searches"
  type        = map(object({
    category     = string
    display_name = string
    query        = string
  }))
  default = {
    "FailedLogins" = {
      category     = "Security"
      display_name = "Failed Login Attempts"
      query        = "SecurityEvent | where EventID == 4625 | summarize count() by Account"
    }
    "TopErrors" = {
      category     = "Application"
      display_name = "Top Application Errors"
      query        = "Event | where Level == \"Error\" | summarize count() by Source | top 10 by count_"
    }
  }
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
