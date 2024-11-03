resource "azurerm_public_ip" "pip" {
  for_each            = var.bast_details
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  location            = each.value.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bast_details
  name                = each.value.bast_name
  resource_group_name = each.value.rg_name
  location            = each.value.rg_location

  ip_configuration {
    name                 = "basip"
    subnet_id            = data.azurerm_subnet.subnets[each.key].id
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}
