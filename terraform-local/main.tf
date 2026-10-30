resource "azurerm_resource_group" "main" {
  name     = "rg-containerized-webapp-local"
  location = "eastus2"

  tags = {
    project    = "azure-containerized-webapp"
    managed_by = "terraform"
    platform   = "floci-az"
  }
}