output "vnet_id" {
  description = "ID of the VNet"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the VNet"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_app_id" {
  description = "ID of the app/workload subnet"
  value       = azurerm_subnet.snet_app.id
}

output "subnet_pe_id" {
  description = "ID of the private endpoint subnet"
  value       = azurerm_subnet.snet_pe.id
}

output "private_dns_zone_appservice" {
  description = "Private DNS zone name used for App Service/Function private endpoints"
  value       = azurerm_private_dns_zone.appservice.name
}
``