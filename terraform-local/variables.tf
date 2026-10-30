variable "image_tag" {
  description = "Immutable GHCR image tag"
  type        = string
}

variable "production_image_tag" {
  description = "Approved production image tag"
  type        = string
}

variable "deploy_environments" {
  description = "Environments to deploy"
  type        = set(string)
  default     = ["qs", "production"]

  validation {
    condition = alltrue([
      for env in var.deploy_environments :
      contains(["qs", "production"], env)
    ])
    error_message = "Only qs and production are supported."
  }
}