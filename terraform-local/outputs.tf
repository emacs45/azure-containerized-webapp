output "container_app_fqdns" {
  description = "Local Container App hostnames"

  value = {
    for env, app in azurerm_container_app.webapp :
    env => app.ingress[0].fqdn
  }
}