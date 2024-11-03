resource "azurerm_network_security_group" "nsgs" {
  name                = var.nsg_details
  resource_group_name = "dev-lv-queensland"
  location            = "CanadaCentral"

  security_rule {
    name                         = "ruleforlbinbound"
    priority                     = 100
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    source_address_prefix        = "*"
    destination_port_range       = 80
    destination_address_prefixes = ["192.168.0.4", "192.168.0.5"]
  }
}

resource "azurerm_subnet_network_security_group_association" "snet-nsg" {
  subnet_id                 = data.azurerm_subnet.fsubnet.id
  network_security_group_id = azurerm_network_security_group.nsgs.id
}
