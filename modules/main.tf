resource "azurerm_resource_group" "rg_demo" {
  name     = "rg-terraform-demo-dev"
  location = "eastus"
}


# Reuse the existing RG you already created
# resource "azurerm_resource_group" "rg_demo" {
#   name     = "rg-terraform-demo-dev"
#   location = "eastus"
# }

# 1) Storage Account (unique name!)
resource "azurerm_storage_account_test_123321" "st_demo" {
  name                     = "st${replace(azurerm_resource_group.rg_demo.name, "-", "")}01" # adjust if needed to meet naming rules
  resource_group_name      = azurerm_resource_group.rg_demo.name
  location                 = azurerm_resource_group.rg_demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Optional good practices
  allow_blob_public_access = false
  min_tls_version          = "TLS1_2"
  tags = {
    env = "dev"
    owner = "terraform"
  }
}
