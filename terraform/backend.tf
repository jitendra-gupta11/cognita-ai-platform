terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev"
    storage_account_name = "sttfstate1s5289"
    container_name       = "tfstate"
    key                  = "atlas-dev.tfstate"
  }
}