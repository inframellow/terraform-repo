resource "azurerm_network_interface" "vm_nics" {
    for_each = var.vm_details
    name = each.value.nic_name
    resource_group_name = each.value.rg_name
    location = each.value.rg_location

    ip_configuration {
      name = "internal_conf"
      subnet_id = data.azurerm_subnet.subnets[each.key].id
      private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_linux_virtual_machine" "linux_vms" {
    for_each = var.vm_details
    name = each.value.vm_name
    resource_group_name = each.value.rg_name
    location = each.value.rg_location
    size = each.value.size
    admin_username = data.azurerm_key_vault_secret.secret1.value
    admin_password = data.azurerm_key_vault_secret.secret2.value
    disable_password_authentication = false
    network_interface_ids = [ azurerm_network_interface.vm_nics[each.key].id ]
    
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
}



