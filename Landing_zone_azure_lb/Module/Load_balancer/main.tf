resource "azurerm_public_ip" "pip" {
  name                = "lb-pip"
  resource_group_name = "dev-lv-queensland"
  location            = "CanadaCentral"
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_lb" "queenslb" {
  name                = var.lb_name
  location            = "CanadaCentral"
  resource_group_name = "dev-lv-queensland"

  frontend_ip_configuration {
    name                 = "frontendip"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_pool" {
  name            = "backend_vm_pool"
  loadbalancer_id = azurerm_lb.queenslb.id
}

resource "azurerm_lb_backend_address_pool_address" "pool-address" {
  for_each                = var.front_vm
  name                    = each.value.backendpool_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_pool.id
  virtual_network_id      = data.azurerm_virtual_network.vnet.id
  # ip_address              = data.azurerm_network_interface.nics[each.key].ip_configuration[0].private_ip_address
  ip_address = data.azurerm_virtual_machine.vms[each.key].private_ip_address
}

resource "azurerm_lb_rule" "name" {
  name = "rule90"
  loadbalancer_id = azurerm_lb.queenslb.id
  frontend_ip_configuration_name = "frontendip"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.lb_pool.id ]
  probe_id = azurerm_lb_probe.lb-probe.id
}

resource "azurerm_lb_probe" "lb-probe" {
  loadbalancer_id = azurerm_lb.queenslb.id
  name            = "ssh-running-probe"
  port            = 22
}
