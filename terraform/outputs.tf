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

# Virtual Machine Outputs
output "vm" {
  value = {
    id         = module.VM.vm_id
    name       = module.VM.vm_name
    private_ip = module.VM.vm_private_ip
    public_ip  = module.VM.vm_public_ip
  }
}

# Key Vault Outputs
output "key_vault" {
  value = {
    id       = module.KeyVault.key_vault_id
    name     = module.KeyVault.key_vault_name
    uri      = module.KeyVault.key_vault_uri
    tenant_id = module.KeyVault.key_vault_tenant_id
  }
}

# App Service Outputs
output "app_service" {
  value = {
    id                = module.AppService.app_service_id
    name              = module.AppService.app_service_name
    default_hostname  = module.AppService.app_service_default_site_hostname
    outbound_ips      = module.AppService.app_service_outbound_ip_addresses
  }
}

# SQL Database Outputs
output "sql_database" {
  value = {
    server_id   = module.SqlDatabase.sql_server_id
    server_name = module.SqlDatabase.sql_server_name
    server_fqdn = module.SqlDatabase.sql_server_fqdn
    databases   = module.SqlDatabase.sql_database_names
  }
}

# Load Balancer Outputs
output "load_balancer" {
  value = {
    id         = module.LoadBalancer.load_balancer_id
    name       = module.LoadBalancer.load_balancer_name
    private_ip = module.LoadBalancer.load_balancer_private_ip_address
    public_ip  = module.LoadBalancer.public_ip_address
  }
}

# Log Analytics Outputs
output "log_analytics" {
  value = {
    workspace_id = module.LogAnalytics.workspace_id
    workspace_name = module.LogAnalytics.workspace_name
    portal_url     = module.LogAnalytics.workspace_portal_url
  }
}