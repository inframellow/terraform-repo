resource "azurerm_storage_account" "stg_details" {
    for_each = var.stg_details
    name = each.value.name
    resource_group_name = each.value.rg_name
    location = each.value.rg_location
    account_tier = each.value.tier
    account_replication_type = each.value.rep_type
}