variable "SSH_PUBLIC_KEY" {
  description = "RSA (Azure does not support Elliptic Curve keys) Public key for admin SSH-connections (required)"
  type        = string
}

variable "EXPIRES" {
  description = "ISO 8601 date (yyyy-mm-dd) after which this resource is cleaned up, defaults to 30days from now"
  default     = null
  type        = string
  validation {
    condition     = var.EXPIRES == null ? true : can(regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", var.EXPIRES))
    error_message = "Must be yyyy-mm-dd"
  }
}

variable "DEPLOYMENT_NAME" {
  default     = null
  description = "Set DNS name, if not set will be automatically generated"
  type        = string
}

variable "VITE_ASSET_SET" {
  default     = "neutral"
  description = "Which asset set to use for RM UI"
  type        = string
}

variable "RESOURCE_GROUP_LOCATION" {
  default     = "northeurope"
  description = "Location of the resource group."
  type        = string
}

variable "RESOURCE_GROUP_NAME_PREFIX" {
  default     = "rg-miniwerk"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  type        = string
}

variable "DOCKER_COMPOSITION_REPO" {
  default     = "https://github.com/pvarki/docker-rasenmaeher-integration.git"
  description = "The repo to use to get the docker-composition from"
  type        = string
}


variable "DOCKER_REPO_TAG" {
  default     = "1.5.0" # do not set to "main", nothing guarantees there are no backwards incompatible changes
  description = "The branch/tag in DOCKER_COMPOSITION_REPO to use"
  type        = string
}

variable "VM_SIZE" {
  default     = "Standard_B4ms"
  description = "The SKU which should be used for this Virtual Machine, e.g. Standard_B4ms"
  type        = string
}

variable "ZONE_RESOURCE_GROUP" {
  default     = "FDF-PVARKI-SOLUTION-static"
  description = "Resource group where the DNS zone resides"
  type        = string
}

variable "ZONE_DNS_NAME" {
  default     = "solution.dev.pvarki.fi"
  description = "DNS Zone to place mumbler server under"
  type        = string
}

variable "CERTBOT_EMAIL" {
  default     = "benjam.gronmark_arkiproj@hotmail.com"
  description = "Email address to send certificate expiration notifications."
  type        = string
}

variable "DOCKER_TAG_EXTRA" {
  default     = ""
  description = "If you want to deploy for example a PR tagged version, messing this up is a good way to make everything take forever"
  type        = string
}
