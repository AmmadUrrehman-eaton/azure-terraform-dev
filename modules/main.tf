
# Use the existing RG instead of creating it
data "azurerm_resource_group" "rg_demo" {
  name = "rg-terraform-demo-dev"
}

# Storage Account (must be globally unique, all lowercase, 3–24 chars)
resource "azurerm_storage_account" "st_demo" {
  name                     = "stammaddemo1234" # change to a unique name if needed
  resource_group_name      = data.azurerm_resource_group.rg_demo.name
  location                 = data.azurerm_resource_group.rg_demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"


# Explicitly disallow public blob access (required by your policy)
  allow_nested_items_to_be_public = false


  # Removed unsupported "allow_blob_public_access"
  min_tls_version                = "TLS1_2"
  public_network_access_enabled  = false

  tags = {
    env   = "dev"
    owner = "terraform"
  }
}
