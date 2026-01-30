variable "create_rg" {
  type        = bool
  description = "If true, create the resource group. If false, read an existing RG."
  default     = false
}

variable "location" {
  type        = string
  description = "Azure region for all resources"
  default     = "eastus"
}

variable "rg_name" {
  type        = string
  description = "Resource group name where networking will be deployed"
  default     = "rg-terraform-demo-dev"
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name"
  default     = "vnet-terraform-demo-dev"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for VNet"
  default     = ["10.50.0.0/16"]
}

variable "subnet_app_name" {
  type        = string
  description = "Subnet for future app service integration or workloads"
  default     = "snet-app"
}

variable "subnet_app_prefix" {
  type        = list(string)
  description = "CIDR for the app subnet"
  default     = ["10.50.1.0/24"]
}

variable "subnet_pe_name" {
  type        = string
  description = "Subnet dedicated to Private Endpoints"
  default     = "snet-private-endpoints"
}

variable "subnet_pe_prefix" {
  type        = list(string)
  description = "CIDR for the private endpoint subnet"
  default     = ["10.50.2.0/24"]
}

variable "appservice_privatedns_zone" {
  type        = string
  description = "Private DNS zone for App Service/Function private endpoints"
  default     = "privatelink.azurewebsites.net"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default = {
    env   = "dev"
    owner = "terraform"
  }
}
