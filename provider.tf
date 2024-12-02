terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.11.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.44.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}