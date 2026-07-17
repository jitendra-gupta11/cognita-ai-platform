locals {
  project     = "atlas"
  environment = "dev"
  location    = "Central India"

  common_tags = {
    Project     = local.project
    Environment = local.environment
    ManagedBy   = "Terraform"
    Owner       = "Jitendra Gupta"
    Repository  = "cognita-ai-platform"
  }

  names = {
    resource_group = "rg-${local.project}-${var.environment}"
    vnet           = "vnet-${local.project}-${var.environment}"
    aks_subnet     = "snet-aks"
    aks_nsg        = "snet-aks-nsg"
    acr            = "acr${local.project}${var.environment}${random_string.acr_suffix.result}"
    aks            = "aks-${local.project}-${var.environment}"

  }

  networking = {
    vnet_address_space = ["10.0.0.0/16"]
    aks_subnet_prefix  = ["10.0.1.0/24"]
    aks_service_cidr   = "10.2.0.0/16"
    aks_dns_service_ip = "10.2.0.10"
  }
}
