variable "vm_name" {
  description = "Name of the Virtual Machine"
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

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}

variable "os_type" {
  description = "Operating System type (linux or windows)"
  type        = string
  default     = "linux"
  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = "OS type must be either 'linux' or 'windows'."
  }
}

variable "admin_username" {
  description = "Administrator username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for Windows VMs"
  type        = string
  sensitive   = true
  default     = null
}

variable "ssh_public_key" {
  description = "SSH public key for Linux VMs"
  type        = string
  default     = null
}

variable "disable_password_auth" {
  description = "Disable password authentication for Linux VMs"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "ID of the subnet to attach the VM"
  type        = string
}

variable "public_ip_id" {
  description = "ID of the public IP to attach to the VM"
  type        = string
  default     = null
}

variable "os_disk_type" {
  description = "Type of OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "image_publisher" {
  description = "Publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the VM image"
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "SKU of the VM image"
  type        = string
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "Version of the VM image"
  type        = string
  default     = "latest"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
