terraform {
  backend "azurerm" {
    resource_group_name  = "Omterraformdemo"
    storage_account_name = "omterraformcodeops"
    container_name       = "tfstatefile"
    key                  = "dev.terraform.tfstate"
  }
}

module "RG" {
  source   = "./modules/RG"
  rgname   = var.rgname
  location = var.location
}

module "SA" {
  source   = "./modules/StorageAccount"
  sname    = var.sname
  rgname   = var.rgname
  location = var.location
}

module "VNet" {
  source        = "./modules/VirtualNetwork"
  vnet_name     = var.vnet_name
  address_space = var.vnet_address_space
  rgname        = var.rgname
  location      = var.location
}

module "Subnet" {
  source           = "./modules/Subnet"
  subnet_name      = var.subnet_name
  vnet_name        = module.VNet.vnet.name
  rgname           = var.rgname
  address_prefixes = var.subnet_address_prefixes
}

module "PublicIP" {
  source   = "./modules/PublicIP"
  pip_name = var.pip_name
  rgname   = var.rgname
  location = var.location
}

module "NSG" {
  source   = "./modules/NetworkSecurityGroup"
  nsg_name = var.nsg_name
  rgname   = var.rgname
  location = var.location
}

# Virtual Machine Module
module "VM" {
  source            = "./modules/VirtualMachine"
  vm_name          = var.vm_name
  rgname           = var.rgname
  location         = var.location
  vm_size          = var.vm_size
  os_type          = var.vm_os_type
  admin_username   = var.vm_admin_username
  admin_password   = var.vm_admin_password
  ssh_public_key   = var.vm_ssh_public_key
  subnet_id        = module.Subnet.subnet.id
  public_ip_id     = module.PublicIP.public_ip.id
  environment      = var.environment
}

# Key Vault Module
module "KeyVault" {
  source   = "./modules/KeyVault"
  kv_name  = var.kv_name
  rgname   = var.rgname
  location = var.location
  environment = var.environment
}

# App Service Module
module "AppService" {
  source            = "./modules/AppService"
  app_service_name  = var.app_service_name
  rgname           = var.rgname
  location         = var.location
  environment      = var.environment
}

# SQL Database Module
module "SqlDatabase" {
  source           = "./modules/SqlDatabase"
  sql_server_name  = var.sql_server_name
  rgname          = var.rgname
  location        = var.location
  admin_username  = var.sql_admin_username
  admin_password  = var.sql_admin_password
  environment     = var.environment
}

# Load Balancer Module
module "LoadBalancer" {
  source   = "./modules/LoadBalancer"
  lb_name  = var.lb_name
  rgname   = var.rgname
  location = var.location
  environment = var.environment
}

# Log Analytics Module
module "LogAnalytics" {
  source        = "./modules/LogAnalytics"
  workspace_name = var.log_analytics_workspace_name
  rgname        = var.rgname
  location      = var.location
  environment   = var.environment
}

