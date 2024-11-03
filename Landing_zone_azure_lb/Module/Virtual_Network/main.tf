resource "azurerm_virtual_network" "vnets" {
    for_each = var.vnet_details
    name = each.value.name
    location = each.value.rg_location
    resource_group_name = each.value.rg_name
    address_space = [ "192.168.0.0/16" ]

    dynamic "subnet" {
        for_each = each.value.subnet
        content {
          name = subnet.value.name
          address_prefixes = subnet.value.address_prefix
        }
      
    }
}

