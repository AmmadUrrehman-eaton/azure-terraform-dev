resource "azurerm_resource_group" "rg_demo" {
  name     = "rg-terraform-demo-dev"
  location = "eastus"
}


# Reuse the existing RG you already created
# resource "azurerm_resource_group" "rg_demo" {
#   name     = "rg-terraform-demo-dev"
#   location = "eastus"
# }


# Storage Account (must be globally unique, all lowercase, 3–24 chars)
resource "azurerm_storage_account" "st_demo" {
  name                     = "stammaddemo1234"  # <-- change to a globally unique, lowercase name
  resource_group_name      = azurerm_resource_group.rg_demo.name
  location                 = azurerm_resource_group.rg_demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_blob_public_access = false
  min_tls_version          = "TLS1_2"

  tags = {
    env   = "dev"
    owner = "terraform"
  }
}
