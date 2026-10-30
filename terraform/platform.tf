resource "azurerm_container_app_environment" "main" {
  name                = "cae-containerized-webapp"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  tags = {
    project    = "azure-containerized-webapp"
    managed_by = "terraform"
  }
}