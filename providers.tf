terraform {
  required_version = ">=1.2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    xkcdpass = {
      source  = "advian-oss/xkcdpass"
      version = "~>1.0"
    }
  }

  backend "azurerm" {}
  #backend "local" {}
}

provider "azurerm" {
  subscription_id = "3847d867-f225-4c32-9e3e-38573a7bc5fd"
  skip_provider_registration = "true"
  features {}
  alias = "solution"
}

provider "azurerm" {
  subscription_id = "a20cc10d-ef06-4cbf-a7f4-0fdbd84f989e"
  skip_provider_registration = "true"
  features {}
  alias = "order"
}
