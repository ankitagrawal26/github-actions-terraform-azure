output "rg_name" {
  value = {
    appname = module.RG.resourcegroup_name.rg_name
  }
}

output "vnet" {
  value = module.VNet.vnet
}

output "subnet" {
  value = module.Subnet.subnet
}

output "public_ip" {
  value = module.PublicIP.public_ip
}

output "nsg" {
  value = module.NSG.nsg
}