variable "create_rg" {
  type        = true
  description = "If true, create RG; if false, read existing."
}

variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for VNet"
}

variable "subnet_app_name" {
  type        = string
  description = "Subnet name for workloads"
}

variable "subnet_app_prefix" {
  type        = list(string)
  description = "CIDR prefixes for app subnet"
}

variable "subnet_pe_name" {
  type        = string
  description = "Subnet name for private endpoints"
}

variable "subnet_pe_prefix" {
  type        = list(string)
  description = "CIDR prefixes for private endpoint subnet"
}

variable "appservice_privatedns_zone" {
  type        = string
  description = "Private DNS zone for App Service private endpoints"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
