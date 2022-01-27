terraform {
  required_version = "1.1.3"

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.env}"
  location = var.location
  tags     = var.common_tags
}

#PET subnet for privateendpoint
provider "azurerm" {
  subscription_id = "58a2ce36-4e09-467b-8330-d164aa559c68"
  alias           = "pet-aks"
  features {}
}
