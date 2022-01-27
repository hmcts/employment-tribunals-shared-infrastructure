resource "azurerm_resource_group" "apipetrg" {
  provider = "azurerm.pet-aks"
  name     = "${var.product}-api-${var.petenv}-endpoint-rg"
  location = var.location

}
resource "azurerm_private_endpoint" "apipetpostgres" {
  provider            = "azurerm.pet-aks"
  name                = "${var.product}-api-${var.petenv}-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.apipetrg.name
  subnet_id           = data.azurerm_subnet.petpostgres.id

  private_service_connection {
    name                           = "${var.product}-api-${var.petenv}-postgressdb"
    private_connection_resource_id = module.et-api-database.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "api-postgres-endpoint-dnszonegroup"
    private_dns_zone_ids = ["/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"]
  }
  tags = var.common_tags
}
