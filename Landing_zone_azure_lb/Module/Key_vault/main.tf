resource "azurerm_key_vault" "vault" {
    name = var.kv_details
    resource_group_name = "dev-lv-queensland"
    location = "CanadaCentral"
    sku_name = "standard"
    tenant_id = data.azurerm_client_config.client_config.tenant_id
    soft_delete_retention_days = 7
    purge_protection_enabled = false

    access_policy {
        tenant_id = data.azurerm_client_config.client_config.tenant_id
        object_id = data.azurerm_client_config.client_config.object_id

        key_permissions = ["List", "Get", "Create", "Update"]
        secret_permissions = ["List", "Get", "Set", "Delete", "Purge", "Recover"]
        storage_permissions = ["List", "Get"]
    }

}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "secret1" {
  name         = "username"
  value        = "demouser"
  key_vault_id = azurerm_key_vault.vault.id
}


resource "azurerm_key_vault_secret" "secret2" {
  name         = "password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.vault.id
}