resource "azurerm_public_ip" "lb_public_ip" {
  count               = var.load_balancer_type == "public" ? 1 : 0
  name                = "${var.lb_name}-pip"
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  domain_name_label   = var.domain_name_label

  tags = {
    environment = var.environment
  }
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = var.load_balancer_type == "public" ? azurerm_public_ip.lb_public_ip[0].id : null
    subnet_id            = var.load_balancer_type == "private" ? var.subnet_id : null
    private_ip_address_allocation = var.load_balancer_type == "private" ? var.private_ip_allocation : null
    private_ip_address   = var.load_balancer_type == "private" ? var.private_ip_address : null
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.lb_name}-backend-pool"
}

resource "azurerm_lb_backend_address_pool_address" "backend_addresses" {
  for_each = var.backend_addresses

  name                    = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
  virtual_network_id      = each.value.virtual_network_id
  ip_address              = each.value.ip_address
}

resource "azurerm_lb_nat_rule" "nat_rules" {
  for_each = var.nat_rules

  resource_group_name            = var.rgname
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = each.key
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
}

resource "azurerm_lb_probe" "health_probes" {
  for_each = var.health_probes

  loadbalancer_id     = azurerm_lb.lb.id
  name                = each.key
  protocol            = each.value.protocol
  port                = each.value.port
  interval_in_seconds = each.value.interval_in_seconds
  number_of_probes    = each.value.number_of_probes
  request_path        = each.value.request_path
  probe_threshold     = each.value.probe_threshold
}

resource "azurerm_lb_rule" "lb_rules" {
  for_each = var.lb_rules

  loadbalancer_id                = azurerm_lb.lb.id
  name                           = each.key
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.health_probes[each.value.probe_name].id
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
  load_distribution              = each.value.load_distribution
  disable_outbound_snat          = each.value.disable_outbound_snat
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool" {
  for_each = var.network_interface_ids

  network_interface_id    = each.value
  ip_configuration_name   = var.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}
