terraform {
  backend "azurerm" {
    resource_group_name = "Omterraformdemo"
    storage_account_name = "omterraformcodeops"
    container_name = "tfstatefile"
    key = "dev.terraform.tfstate"
  }
}
module "RG" {
  source = "./modules/RG"  #A
  rgname = var.rgname  #B
  location = var.location
}
module "SA" {
  source = "./modules/StorageAccount"
  sname = var.sname
  rgname = var.rgname
  location = var.location
}

module "VNet" {
  source = "./modules/VirtualNetwork"
  vnet_name = var.vnet_name
  address_space = var.vnet_address_space
  rgname = var.rgname
  location = var.location
}

module "Subnet" {
  source = "./modules/Subnet"
  subnet_name = var.subnet_name
  vnet_name = module.VNet.vnet.name
  rgname = var.rgname
  address_prefixes = var.subnet_address_prefixes
}

module "PublicIP" {
  source = "./modules/PublicIP"
  pip_name = var.pip_name
  rgname = var.rgname
  location = var.location
}

module "NSG" {
  source = "./modules/NetworkSecurityGroup"
  nsg_name = var.nsg_name
  rgname = var.rgname
  location = var.location
}