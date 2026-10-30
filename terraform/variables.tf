variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Existing Azure Resource Group"
  type        = string
}

variable "image_tag" {
  description = "Immutable Docker image tag from GHCR"
  type        = string
}