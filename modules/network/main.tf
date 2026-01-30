# Create RG optionally
resource "azurerm_resource_group" "rg" {
  count    = var.create_rg ? 1 : 0
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}

# Read RG if it already exists
data "azurerm_resource_group" "rg" {
  count = var.create_rg ? 0 : 1
  name  = var.rg_name
}

# Local helpers to unify access
locals {
  rg_name   = var.create_rg ? azurerm_resource_group.rg[0].name     : data.azurerm_resource_group.rg[0].name
  location  = var.create_rg ? azurerm_resource_group.rg[0].location : data.azurerm_resource_group.rg[0].location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = local.location
  resource_group_name = local.rg_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# Subnet for app/workloads (for later use: integration/jumpbox/etc.)
resource "azurerm_subnet" "snet_app" {
  name                 = var.subnet_app_name
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_app_prefix
}

# Subnet dedicated to Private Endpoints
resource "azurerm_subnet" "snet_pe" {
  name                 = var.subnet_pe_name
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_pe_prefix

  # REQUIRED: disable network policies for private endpoints
  private_endpoint_network_policies_enabled = false
}

# Private DNS Zone for App Service/Function Private Endpoints
resource "azurerm_private_dns_zone" "appservice" {
  name                = var.appservice_privatedns_zone # privatelink.azurewebsites.net
  resource_group_name = local.rg_name
  tags                = var.tags
}

# Link DNS zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "appservice_link" {
  name                  = "${var.vnet_name}-appservice-link"
  resource_group_name   = local.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.appservice.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
}