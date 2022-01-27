data "azurerm_subnet" "petpostgres" {
  provider             = "azurerm.pet-aks"
  name                 = "pet_private_${local.petenv}"
  virtual_network_name = "pet_${local.petenv}_network"
  resource_group_name  = "pet_${local.petenv}_network_resource_group"
}

locals {
  petenv = var.env == "prod" || var.env == "stg" ? var.env : "dev"
}