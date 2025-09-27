variable "rgname" {
  description = "Resource Group Name"
  default     = "github-action1"
  type        = string
}
variable "location" {
  description = "Azure location"
  default     = "East US"
  type        = string
}
variable "sname" {
  description = "Azure Storage Account"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefixes"
  type        = list(string)
}

variable "pip_name" {
  description = "Public IP name"
  type        = string
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

# Virtual Machine Variables
variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
  default     = "myvm"
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}

variable "vm_os_type" {
  description = "Operating System type (linux or windows)"
  type        = string
  default     = "linux"
}

variable "vm_admin_username" {
  description = "Administrator username for the VM"
  type        = string
  default     = "adminuser"
}

variable "vm_admin_password" {
  description = "Administrator password for Windows VMs"
  type        = string
  sensitive   = true
  default     = null
}

variable "vm_ssh_public_key" {
  description = "SSH public key for Linux VMs"
  type        = string
  default     = null
}

# Key Vault Variables
variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
  default     = "mykeyvault"
}

# App Service Variables
variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "myappservice"
}

# SQL Database Variables
variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
  default     = "mysqlserver"
}

variable "sql_admin_username" {
  description = "Administrator username for the SQL Server"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "Administrator password for the SQL Server"
  type        = string
  sensitive   = true
  default     = null
}

# Load Balancer Variables
variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
  default     = "myloadbalancer"
}

# Log Analytics Variables
variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
  default     = "myloganalytics"
}

# Environment Variable
variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}