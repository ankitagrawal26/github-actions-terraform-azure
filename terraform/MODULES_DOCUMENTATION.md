# Azure Terraform Modules Documentation

This document provides comprehensive information about all the Terraform modules available in this repository for deploying Azure resources.

## Existing Modules

### 1. Resource Group (RG)
**Location**: `./modules/RG/`
**Purpose**: Creates an Azure Resource Group
**Resources**: `azurerm_resource_group`

### 2. Storage Account (StorageAccount)
**Location**: `./modules/StorageAccount/`
**Purpose**: Creates an Azure Storage Account
**Resources**: `azurerm_storage_account`

### 3. Virtual Network (VirtualNetwork)
**Location**: `./modules/VirtualNetwork/`
**Purpose**: Creates an Azure Virtual Network
**Resources**: `azurerm_virtual_network`

### 4. Subnet
**Location**: `./modules/Subnet/`
**Purpose**: Creates an Azure Subnet
**Resources**: `azurerm_subnet`

### 5. Public IP (PublicIP)
**Location**: `./modules/PublicIP/`
**Purpose**: Creates an Azure Public IP
**Resources**: `azurerm_public_ip`

### 6. Network Security Group (NetworkSecurityGroup)
**Location**: `./modules/NetworkSecurityGroup/`
**Purpose**: Creates an Azure Network Security Group
**Resources**: `azurerm_network_security_group`

## New Modules

### 7. Virtual Machine (VirtualMachine)
**Location**: `./modules/VirtualMachine/`
**Purpose**: Creates Azure Virtual Machines with configurable OS and networking
**Resources**: 
- `azurerm_network_interface`
- `azurerm_linux_virtual_machine`
- `azurerm_windows_virtual_machine`

**Key Features**:
- Support for both Linux and Windows VMs
- Configurable VM sizes and OS images
- SSH key authentication for Linux
- Password authentication for Windows
- Network interface integration
- Public IP attachment support

**Usage Example**:
```hcl
module "VM" {
  source            = "./modules/VirtualMachine"
  vm_name          = "my-vm"
  rgname           = "my-rg"
  location         = "East US"
  vm_size          = "Standard_B1s"
  os_type          = "linux"
  admin_username   = "adminuser"
  ssh_public_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ..."
  subnet_id        = module.Subnet.subnet.id
  public_ip_id     = module.PublicIP.public_ip.id
  environment      = "dev"
}
```

### 8. Key Vault (KeyVault)
**Location**: `./modules/KeyVault/`
**Purpose**: Creates Azure Key Vault for secrets, keys, and certificates management
**Resources**:
- `azurerm_key_vault`
- `azurerm_key_vault_secret`
- `azurerm_key_vault_key`

**Key Features**:
- Secure secrets and keys storage
- Configurable access policies
- Network ACLs for security
- Soft delete and purge protection
- Support for secrets and cryptographic keys

**Usage Example**:
```hcl
module "KeyVault" {
  source     = "./modules/KeyVault"
  kv_name    = "my-keyvault"
  rgname     = "my-rg"
  location   = "East US"
  secrets = {
    "database-password" = "MySecurePassword123!"
    "api-key"          = "abc123def456"
  }
  environment = "dev"
}
```

### 9. App Service (AppService)
**Location**: `./modules/AppService/`
**Purpose**: Creates Azure App Service and App Service Plan for web applications
**Resources**:
- `azurerm_app_service_plan`
- `azurerm_app_service`
- `azurerm_app_service_custom_hostname_binding`

**Key Features**:
- Support for Linux and Windows App Services
- Multiple programming language support (.NET, PHP, Python, Node.js, Java)
- Configurable SKU tiers
- Custom domain support
- Managed identity integration
- Application settings and connection strings

**Usage Example**:
```hcl
module "AppService" {
  source            = "./modules/AppService"
  app_service_name  = "my-web-app"
  rgname           = "my-rg"
  location         = "East US"
  sku_tier         = "Standard"
  sku_size         = "S1"
  python_version   = "3.9"
  app_settings = {
    "APP_SETTING" = "value"
    "DATABASE_URL" = "connection_string"
  }
  environment      = "dev"
}
```

### 10. SQL Database (SqlDatabase)
**Location**: `./modules/SqlDatabase/`
**Purpose**: Creates Azure SQL Server and SQL Databases
**Resources**:
- `azurerm_mssql_server`
- `azurerm_mssql_database`
- `azurerm_mssql_firewall_rule`
- `azurerm_mssql_vulnerability_assessment`

**Key Features**:
- SQL Server with configurable version
- Multiple database support
- Firewall rules management
- Vulnerability assessment
- Threat detection policies
- Long-term retention policies

**Usage Example**:
```hcl
module "SqlDatabase" {
  source          = "./modules/SqlDatabase"
  sql_server_name = "mysqlserver"
  rgname         = "my-rg"
  location       = "East US"
  admin_username = "sqladmin"
  admin_password = "SecurePassword123!"
  databases = {
    "main-db" = {
      sku_name = "S0"
      max_size_gb = 250
    }
    "test-db" = {
      sku_name = "Basic"
      max_size_gb = 2
    }
  }
  environment = "dev"
}
```

### 11. Load Balancer (LoadBalancer)
**Location**: `./modules/LoadBalancer/`
**Purpose**: Creates Azure Load Balancer for high availability and traffic distribution
**Resources**:
- `azurerm_lb`
- `azurerm_lb_backend_address_pool`
- `azurerm_lb_rule`
- `azurerm_lb_probe`
- `azurerm_lb_nat_rule`
- `azurerm_public_ip` (for public load balancer)

**Key Features**:
- Public and private load balancer support
- Health probes configuration
- Load balancing rules
- NAT rules for port forwarding
- Backend pool management
- Network interface association

**Usage Example**:
```hcl
module "LoadBalancer" {
  source   = "./modules/LoadBalancer"
  lb_name  = "my-loadbalancer"
  rgname   = "my-rg"
  location = "East US"
  load_balancer_type = "public"
  lb_rules = {
    "http-rule" = {
      protocol    = "Tcp"
      frontend_port = 80
      backend_port  = 80
      probe_name    = "http-probe"
    }
  }
  environment = "dev"
}
```

### 12. Log Analytics (LogAnalytics)
**Location**: `./modules/LogAnalytics/`
**Purpose**: Creates Azure Log Analytics workspace for monitoring and diagnostics
**Resources**:
- `azurerm_log_analytics_workspace`
- `azurerm_log_analytics_solution`
- `azurerm_monitor_diagnostic_setting`
- `azurerm_log_analytics_saved_search`

**Key Features**:
- Centralized logging and monitoring
- Pre-configured solutions (Container Insights, Service Map)
- Diagnostic settings for Azure resources
- Saved searches for common queries
- Configurable retention and quotas

**Usage Example**:
```hcl
module "LogAnalytics" {
  source        = "./modules/LogAnalytics"
  workspace_name = "my-loganalytics"
  rgname        = "my-rg"
  location      = "East US"
  solutions = {
    "ContainerInsights" = {
      publisher = "Microsoft"
      product   = "OMSGallery/ContainerInsights"
    }
  }
  environment   = "dev"
}
```

## Module Dependencies

The modules are designed to work together with the following dependency structure:

```
RG (Resource Group)
├── StorageAccount
├── VirtualNetwork
│   └── Subnet
├── PublicIP
├── NetworkSecurityGroup
├── VirtualMachine (depends on Subnet + PublicIP)
├── KeyVault
├── AppService
├── SqlDatabase
├── LoadBalancer
└── LogAnalytics
```

## Usage in main.tf

All modules are configured in the main.tf file with appropriate variable references. You can customize the deployment by modifying the variables in `terraform.tfvars` or by updating the variable defaults in `variables.tf`.

## Security Considerations

- All sensitive variables are marked with `sensitive = true`
- Key Vault provides secure storage for secrets and keys
- Network Security Groups and firewall rules are configurable
- Managed identities are supported where applicable
- TLS/SSL configurations are enforced

## Best Practices

1. **Use variables**: Always use variables instead of hardcoded values
2. **Environment separation**: Use different resource groups for different environments
3. **Naming conventions**: Follow consistent naming conventions across resources
4. **Tagging**: Apply appropriate tags for resource management
5. **Security**: Use Key Vault for sensitive data and enable security features
6. **Monitoring**: Enable Log Analytics for comprehensive monitoring

## Getting Started

1. Update the `terraform.tfvars` file with your specific values
2. Run `terraform init` to initialize the provider
3. Run `terraform plan` to review the deployment plan
4. Run `terraform apply` to deploy the infrastructure

For more detailed information about each module, refer to the individual module documentation in their respective directories.
