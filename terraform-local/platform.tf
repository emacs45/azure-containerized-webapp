resource "azurerm_container_app_environment" "main" {
  name                = "cae-webapp-local"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    project    = "azure-containerized-webapp"
    managed_by = "terraform"
    platform   = "floci-az"
  }
}