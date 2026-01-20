resource "azurerm_resource_group" "rg_demo" {
  name     = "rg-terraform-demo-dev"
  location = "eastus"
}

resource "azurerm_storage_account" "storage_demo" {
  name                     = "stterraformdemodev001"
  resource_group_name      = azurerm_resource_group.rg_demo.name
  location                 = azurerm_resource_group.rg_demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}