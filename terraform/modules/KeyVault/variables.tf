variable "kv_name" {
  description = "Name of the Key Vault"
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

variable "sku_name" {
  description = "SKU name for the Key Vault"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "SKU name must be either 'standard' or 'premium'."
  }
}

variable "enabled_for_disk_encryption" {
  description = "Enable Key Vault for disk encryption"
  type        = bool
  default     = true
}

variable "enabled_for_deployment" {
  description = "Enable Key Vault for deployment"
  type        = bool
  default     = true
}

variable "enabled_for_template_deployment" {
  description = "Enable Key Vault for template deployment"
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Enable purge protection"
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft deleted Key Vault"
  type        = number
  default     = 7
  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "Soft delete retention days must be between 7 and 90."
  }
}

variable "key_permissions" {
  description = "Key permissions for the access policy"
  type        = list(string)
  default     = ["Get", "List", "Create", "Delete", "Update", "Import", "Backup", "Restore", "Recover"]
}

variable "secret_permissions" {
  description = "Secret permissions for the access policy"
  type        = list(string)
  default     = ["Get", "List", "Set", "Delete", "Backup", "Restore", "Recover"]
}

variable "storage_permissions" {
  description = "Storage permissions for the access policy"
  type        = list(string)
  default     = ["Get", "List", "Delete", "Set", "Update", "RegenerateKey", "Recover", "Purge", "Backup", "Restore", "SetSAS", "ListSAS", "GetSAS", "DeleteSAS"]
}

variable "network_acls_default_action" {
  description = "Default action for network ACLs"
  type        = string
  default     = "Deny"
  validation {
    condition     = contains(["Allow", "Deny"], var.network_acls_default_action)
    error_message = "Network ACLs default action must be either 'Allow' or 'Deny'."
  }
}

variable "network_acls_bypass" {
  description = "Bypass option for network ACLs"
  type        = string
  default     = "AzureServices"
  validation {
    condition     = contains(["None", "AzureServices"], var.network_acls_bypass)
    error_message = "Network ACLs bypass must be either 'None' or 'AzureServices'."
  }
}

variable "ip_rules" {
  description = "List of IP addresses to allow access"
  type        = list(string)
  default     = []
}

variable "virtual_network_subnet_ids" {
  description = "List of subnet IDs to allow access"
  type        = list(string)
  default     = []
}

variable "secrets" {
  description = "Map of secrets to store in Key Vault"
  type        = map(string)
  default     = {}
}

variable "keys" {
  description = "Map of keys to create in Key Vault"
  type = map(object({
    key_type = string
    key_size = number
    key_opts = list(string)
  }))
  default = {}
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
