resource "azurerm_network_interface" "pintunic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.pintusubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.pintupip.id
  }
}

resource "azurerm_linux_virtual_machine" "pintuvm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = data.azurerm_key_vault_secret.kv-username.value
  network_interface_ids = [
    azurerm_network_interface.pintunic.id,
  ]

 admin_password = data.azurerm_key_vault_secret.keyvault-password.value
 disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}