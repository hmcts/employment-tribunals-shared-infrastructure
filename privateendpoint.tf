data "azurerm_subnet" "petpostgres" {
  provider             = "azurerm.pet-aks"
  name                 = "pet_private_${var.env}"
  virtual_network_name = "pet_${var.env}_network"
  resource_group_name  = "pet_${var.env}_network_resource_group"
}

resource "azurerm_resource_group" "petrg" {
  provider = "azurerm.pet-aks"
  name     = "${var.product}-${var.env}-endpoint-rg"
  location = var.location

}
resource "azurerm_private_endpoint" "petpostgres" {
  provider            = "azurerm.pet-aks"
  name                = "${var.product}-${var.env}-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.petrg.name
  subnet_id           = data.azurerm_subnet.petpostgres.id

  private_service_connection {
    name                           = "${var.product}-et1-${var.env}-postgressdb"
    private_connection_resource_id = module.et1-database.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_service_connection {
    name                           = "${var.product}-et3-${var.env}-postgressdb"
    private_connection_resource_id = module.et3-database.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_service_connection {
    name                           = "${var.product}-api-${var.env}-postgressdb"
    private_connection_resource_id = module.et-api-database.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "postgres-endpoint-dnszonegroup"
    private_dns_zone_ids = ["/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"]
  }
  tags = var.common_tags
}
