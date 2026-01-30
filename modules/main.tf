module "network" {
  source = "./modules/network"

  # RG handling
  create_rg = var.create_rg
  rg_name   = var.rg_name
  location  = var.location

  # VNet/Subnets
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnet_app_name     = var.subnet_app_name
  subnet_app_prefix   = var.subnet_app_prefix
  subnet_pe_name      = var.subnet_pe_name
  subnet_pe_prefix    = var.subnet_pe_prefix

  # Private DNS for App Service private endpoints
  appservice_privatedns_zone = var.appservice_privatedns_zone

  tags = var.tags
}
