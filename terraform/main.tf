provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "paperless" {
  name     = "paperless"
  location = "Switzerland North"
}

