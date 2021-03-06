resource "azurerm_resource_group" "et3petrg" {
  provider = "azurerm.pet-aks"
  name     = "${var.product}-et3-${local.petenv}-endpoint-rg"
  location = var.location

}
resource "azurerm_private_endpoint" "et3petpostgres" {
  provider            = "azurerm.pet-aks"
  name                = "${var.product}-et3-${local.petenv}-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.et3petrg.name
  subnet_id           = data.azurerm_subnet.petpostgres.id

  private_service_connection {
    name                           = "${var.product}-et3-${local.petenv}-postgressdb"
    private_connection_resource_id = module.et3-database.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "et3-postgres-endpoint-dnszonegroup"
    private_dns_zone_ids = ["/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"]
  }
  tags = var.common_tags
}
