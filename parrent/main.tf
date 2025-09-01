module "RG" {
  source   = "../chlid/RG"
  rg_name  = "rgapp45"
  location = "Central India"
}
module "VNET" {
  depends_on = [module.RG]
  source     = "../chlid/VNET"
  vnet_name  = "vnetapp45"
  rg_name    = "rgapp45"
  location   = "Central India"
}
module "SUBNET" {
  depends_on       = [module.VNET]
  source           = "../chlid/SUBNET"
  rg_name          = "rgapp45"
  vnet_name        = "vnetapp45"
  subnet_name      = "subnetapp45"
  address_prefixes = ["10.0.1.0/24"]
}
module "Public_ip" {
  depends_on = [module.RG]
  source     = "../chlid/Public_ip"
  rg_name    = "rgapp45"
  location   = "Central India"
  pip_name   = "pipapp45"
}
module "VM" {
  depends_on                = [module.SUBNET, module.Public_ip]
  source                    = "../chlid/VM"
  nic_name                  = "nicapp45"
  subnet_name               = "subnetapp45"
  rg_name                   = "rgapp45"
  location                  = "Central India"
  vnet_name                 = "vnetapp45"
  vm_name                   = "vmapp45"
  vm_size                   = "Standard_F2"
  pip_name                  = "pipapp45"
  kv_name                   = "kvapp45"
  kvrg_name                 = "rgapp45"
  key_vault_secret_username = "kv-username"
  key_vault_secret_password = "keyvault-password"
}
module "SUBNET-1" {
  depends_on       = [module.VNET]
  source           = "../chlid/SUBNET"
  rg_name          = "rgapp45"
  vnet_name        = "vnetapp45"
  subnet_name      = "subnetapp49"
  address_prefixes = ["10.0.2.0/24"]
}



module "Public_ip-1" {
  depends_on = [module.RG]
  source     = "../chlid/Public_ip"
  rg_name    = "rgapp45"
  location   = "Central India"
  pip_name   = "pipapp49"
}
module "VM-1" {
  depends_on                = [module.SUBNET-1, module.Public_ip-1]
  source                    = "../chlid/VM"
  nic_name                  = "nicapp49"
  subnet_name               = "subnetapp49"
  rg_name                   = "rgapp45"
  location                  = "Central India"
  vnet_name                 = "vnetapp45"
  vm_name                   = "vmapp49"
  vm_size                   = "Standard_D2s_v3"
  pip_name                  = "pipapp49"
  kv_name                   = "kvapp45"
  kvrg_name                 = "rgapp45"
  key_vault_secret_username = "kv-username"
  key_vault_secret_password = "keyvault-password"
}