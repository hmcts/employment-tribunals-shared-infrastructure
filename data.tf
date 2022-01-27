data "azurerm_subnet" "petpostgres" {
  provider             = "azurerm.pet-aks"
  name                 = "pet_private_${var.env}"
  virtual_network_name = "pet_${var.env}_network"
  resource_group_name  = "pet_${var.env}_network_resource_group"
}
