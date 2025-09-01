data "azurerm_subnet" "pintusubnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}
data "azurerm_public_ip" "pintupip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault" "keyvault"{
   name = var.kv_name
   resource_group_name = var.kvrg_name
   }
data "azurerm_key_vault_secret" "kv-username" {
  name         = var.key_vault_secret_username
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "keyvault-password" {
  name         = var.key_vault_secret_password
  key_vault_id = data.azurerm_key_vault.keyvault.id
}