output "container_app_environment_id" {
  description = "ID of the shared Container Apps Environment"
  value       = azurerm_container_app_environment.main.id
}

output "container_app_urls" {
  description = "Public HTTPS endpoints for QS and Production"

  value = {
    for env, app in azurerm_container_app.webapp :
    env => "https://${app.ingress[0].fqdn}"
  }
}