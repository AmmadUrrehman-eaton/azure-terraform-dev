resource "azurerm_resource_group" "rg_demo" {
  name     = "rg-terraform-demo-dev"
  location = "eastus"
}


# Reuse the existing RG you already created
# resource "azurerm_resource_group" "rg_demo" {
#   name     = "rg-terraform-demo-dev"
#   location = "eastus"
# }



resource "azurerm_storage_account" "st_demo" {
  name                     = "stammaddemo1234"  # must be globally unique, lowercase, 3–24 chars
  resource_group_name      = azurerm_resource_group.rg_demo.name
  location                 = azurerm_resource_group.rg_demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Removed: allow_blob_public_access (not supported in your provider)
  # Optional hardening that is supported:
  min_tls_version              = "TLS1_2"
  public_network_access_enabled = true

  tags = {
    env   = "dev"
    owner = "terraform"
  }
}
