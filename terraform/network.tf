resource "azurerm_virtual_network" "vnet" {
  name                = "paperless-vnet"
  location            = azurerm_resource_group.paperless.location
  resource_group_name = azurerm_resource_group.paperless.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "paperless-privat-subnet"
  resource_group_name  = azurerm_resource_group.paperless.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

