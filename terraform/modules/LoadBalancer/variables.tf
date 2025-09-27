variable "lb_name" {
  description = "Name of the Load Balancer"
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

variable "load_balancer_type" {
  description = "Type of Load Balancer (public or private)"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private"], var.load_balancer_type)
    error_message = "Load balancer type must be either 'public' or 'private'."
  }
}

variable "lb_sku" {
  description = "SKU of the Load Balancer"
  type        = string
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard"], var.lb_sku)
    error_message = "Load balancer SKU must be either 'Basic' or 'Standard'."
  }
}

variable "frontend_ip_configuration_name" {
  description = "Name of the frontend IP configuration"
  type        = string
  default     = "PublicIPAddress"
}

variable "public_ip_allocation_method" {
  description = "Allocation method for public IP"
  type        = string
  default     = "Static"
  validation {
    condition     = contains(["Static", "Dynamic"], var.public_ip_allocation_method)
    error_message = "Public IP allocation method must be either 'Static' or 'Dynamic'."
  }
}

variable "public_ip_sku" {
  description = "SKU of the public IP"
  type        = string
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard"], var.public_ip_sku)
    error_message = "Public IP SKU must be either 'Basic' or 'Standard'."
  }
}

variable "domain_name_label" {
  description = "Domain name label for the public IP"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID for private load balancer"
  type        = string
  default     = null
}

variable "private_ip_allocation" {
  description = "Private IP allocation method"
  type        = string
  default     = "Dynamic"
  validation {
    condition     = contains(["Static", "Dynamic"], var.private_ip_allocation)
    error_message = "Private IP allocation must be either 'Static' or 'Dynamic'."
  }
}

variable "private_ip_address" {
  description = "Private IP address for static allocation"
  type        = string
  default     = null
}

variable "backend_addresses" {
  description = "Map of backend addresses"
  type = map(object({
    virtual_network_id = string
    ip_address         = string
  }))
  default = {}
}

variable "nat_rules" {
  description = "Map of NAT rules"
  type = map(object({
    protocol      = string
    frontend_port = number
    backend_port  = number
  }))
  default = {}
}

variable "health_probes" {
  description = "Map of health probes"
  type = map(object({
    protocol            = string
    port                = number
    interval_in_seconds = number
    number_of_probes    = number
    request_path        = string
    probe_threshold     = number
  }))
  default = {
    "http-probe" = {
      protocol            = "Http"
      port                = 80
      interval_in_seconds = 5
      number_of_probes    = 2
      request_path        = "/"
      probe_threshold     = 1
    }
  }
}

variable "lb_rules" {
  description = "Map of load balancer rules"
  type = map(object({
    protocol                = string
    frontend_port           = number
    backend_port            = number
    probe_name              = string
    idle_timeout_in_minutes = number
    load_distribution       = string
    enable_floating_ip      = bool
    disable_outbound_snat   = bool
  }))
  default = {
    "http-rule" = {
      protocol                = "Tcp"
      frontend_port           = 80
      backend_port            = 80
      probe_name              = "http-probe"
      idle_timeout_in_minutes = 4
      load_distribution       = "Default"
      enable_floating_ip      = false
      disable_outbound_snat   = false
    }
  }
}

variable "network_interface_ids" {
  description = "Map of network interface IDs to associate with backend pool"
  type        = map(string)
  default     = {}
}

variable "ip_configuration_name" {
  description = "IP configuration name for network interface association"
  type        = string
  default     = "internal"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
