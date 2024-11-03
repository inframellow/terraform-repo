module "resource_group" {
  source     = "../../Module/Resource_group"
  rg_details = var.rg_map
}

module "storage_account" {
  depends_on  = [module.resource_group]
  source      = "../../Module/Storage_account"
  stg_details = var.stg_map
}

module "virtual_network" {
  depends_on   = [module.resource_group]
  source       = "../../Module/Virtual_Network"
  vnet_details = var.vnet_map
}

module "virtual_machine" {
  depends_on = [module.virtual_network, module.key_vault]
  source     = "../../Module/Virtual_machine"
  vm_details = var.vm_map
}

module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../Module/Key_vault"
  kv_details = var.kv_name
}

module "bastion" {
  depends_on   = [module.virtual_network]
  source       = "../../Module/Bastion_Service"
  bast_details = var.bast_map
}

module "load_balancer" {
  depends_on = [module.virtual_machine]
  source     = "../../Module/Load_balancer"
  lb_name    = var.lb_map
  front_vm   = var.front_vm
}

module "subnet_nsg" {
  depends_on  = [module.virtual_machine]
  source      = "../../Module/nsg_resource"
  nsg_details = var.nsg_map
}