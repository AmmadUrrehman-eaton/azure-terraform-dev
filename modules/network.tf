
# If the RG already exists (as in your setup), read it as data instead of re-creating it
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# Subnet for app/workloads (e.g., app service integration later, jump hosts, etc.)
resource "azurerm_subnet" "snet_app" {
  name                 = var.subnet_app_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_app_prefix
}

# Subnet dedicated to Private Endpoints (best practice: keep PEs isolated)
resource "azurerm_subnet" "snet_pe" {
  name                 = var.subnet_pe_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_pe_prefix

  # Some orgs enforce that PE subnets have no delegation/service endpoints.
  # Do not add NSG by default; many org policies allow/require no NSG on PE subnets.
}

# Private DNS Zone for App Service/Function Private Endpoints
# When you create a PE for a Web App or Function App, the A-record lives here.
resource "azurerm_private_dns_zone" "appservice" {
  name                = var.appservice_privatedns_zone # privatelink.azurewebsites.net
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags
}

# Link the Private DNS Zone to the VNet so queries from this VNet resolve to private IPs
resource "azurerm_private_dns_zone_virtual_network_link" "appservice_link" {
  name                  = "${var.vnet_name}-appservice-link"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.appservice.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
}

# (Optional) Additional Private DNS Zones for other service types can be added later, e.g.:
# privatelink.blob.core.windows.net (Storage), privatelink.vaultcore.azure.net (Key Vault), etc.
