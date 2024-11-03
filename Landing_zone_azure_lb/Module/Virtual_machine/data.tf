data "azurerm_subnet" "subnets" {
    for_each = var.vm_details
    name = each.value.subnet_name
    virtual_network_name = each.value.vnet_name
    resource_group_name = each.value.rg_name
}

data "azurerm_key_vault" "kvault" {
    name = "keyvaultqueensdev"
    resource_group_name = "dev-lv-queensland"
  
}

data "azurerm_key_vault_secret" "secret1" {
    name = "username"
    key_vault_id = data.azurerm_key_vault.kvault.id
}

data "azurerm_key_vault_secret" "secret2" {
    name = "password"
    key_vault_id = data.azurerm_key_vault.kvault.id
}