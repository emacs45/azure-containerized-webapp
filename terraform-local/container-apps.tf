locals {
  environments = toset(["qs", "production"])
}

resource "azurerm_container_app" "webapp" {
  for_each = local.environments

  name                         = "ca-webapp-${each.key}"
  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = azurerm_container_app_environment.main.id

  revision_mode = "Single"

  template {
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "webapp"
      image  = "ghcr.io/emacs45/azure-containerized-webapp:${each.key == "production" ? var.production_image_tag : var.image_tag}"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "DEPLOY_ENV"
        value = each.key
      }

      env {
        name  = "APP_VERSION"
        value = "1.0.0"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "http"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}