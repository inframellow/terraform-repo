data "azurerm_virtual_network" "vnet" {
    name = "devvnetqueens"
    resource_group_name = "dev-lv-queensland"
}

# data "azurerm_network_interface" "nics" {
#     for_each = var.vm_details
#     name = each.value.nic_name
#     resource_group_name = each.value.rg_name
# }

data "azurerm_virtual_machine" "vms" {
  for_each = var.front_vm
  name = each.value.vm_name
  resource_group_name = each.value.rg_name
}