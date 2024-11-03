data "azurerm_subnet" "fsubnet" {
    name = "frontend-subnet"
    resource_group_name = "dev-lv-queensland"
    virtual_network_name = "devvnetqueens"
}