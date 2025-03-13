terraform {
  required_version = ">=1.2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
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

  #backend "azurerm" {}
  backend "local" {}
}

provider "azurerm" {
  features {}
  subscription_id = var.SUBSCRIPTION_ID
}
