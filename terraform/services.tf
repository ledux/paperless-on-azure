resource "azurerm_container_group" "broker" {
  name                = "redis-broker-container"
  resource_group_name = azurerm_resource_group.paperless.name
  location            = azurerm_resource_group.paperless.location
  os_type             = "Linux"
  ip_address_type     = "Private"
  subnet_ids          = [azurerm_subnet.private_subnet.id]

  container {
    name   = "redis-broker"
    image  = "redis:7"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 6379
      protocol = "TCP"
    }
  }
}

resource "azurerm_container_group" "gotenberg" {
  name                = "gotenberg-container"
  resource_group_name = azurerm_resource_group.paperless.name
  location            = azurerm_resource_group.paperless.location
  os_type             = "Linux"
  ip_address_type     = "Private"
  subnet_ids          = [azurerm_subnet.private_subnet.id]

  container {
    name   = "gotenberg"
    image  = "gotenberg/gotenberg:7.10"
    cpu    = "0.5"
    memory = "1.5"

    commands = [
      "gotenberg",
      "--chromium-disable-javascript=true",
      "--chromium-allow-list=file:///tmp/.*"
    ]

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }
}

resource "azurerm_container_group" "tika" {
  name                = "tika-container"
  resource_group_name = azurerm_resource_group.paperless.name
  location            = azurerm_resource_group.paperless.location
  os_type             = "Linux"
  ip_address_type     = "Private"
  subnet_ids          = [azurerm_subnet.private_subnet.id]

  container {
    name   = "tika"
    image  = "ghcr.io/paperless-ngx/tika:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 9998
      protocol = "TCP"
    }
  }
}
