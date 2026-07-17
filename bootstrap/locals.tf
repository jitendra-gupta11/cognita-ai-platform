locals {

  location = "Central India"

  resource_group_name = "rg-tfstate-dev"

  storage_account_prefix = "sttfstate"

  container_name = "tfstate"

  tags = {
    Project     = "atlas"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Purpose     = "Terraform Backend"
  }

}