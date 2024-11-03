data "azurerm_subnet" "subnets" {
    for_each = var.bast_details
    name = each.value.subnet_name
    virtual_network_name = each.value.vnet_name
    resource_group_name = each.value.rg_name
}