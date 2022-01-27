data "azurerm_subnet" "petpostgres" {
  provider             = "azurerm.pet-aks"
  name                 = "pet_private_${var.petenv}"
  virtual_network_name = "pet_${var.petenv}_network"
  resource_group_name  = "pet_${var.petenv}_network_resource_group"
}

output "petenv" {
  value = "pet_${var.petenv}_network"
}