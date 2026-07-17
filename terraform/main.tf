module "resource_group" {
  source = "./modules/resource-group"

  name     = "rg-${local.project}-${var.environment}"
  location = var.location
  tags     = local.common_tags
}

module "networking" {
  source = "./modules/networking"

  resource_group_name = module.resource_group.name
  location            = var.location

  vnet_name     = local.names.vnet
  address_space = local.networking.vnet_address_space

  subnet_name   = local.names.aks_subnet
  subnet_prefix = local.networking.aks_subnet_prefix

  tags = local.common_tags
}

resource "random_string" "acr_suffix" {
  length  = 4
  upper   = false
  special = false
}

module "acr" {
  source = "./modules/acr"

  name                = local.names.acr
  resource_group_name = module.resource_group.name
  location            = var.location

  tags = local.common_tags
}

module "aks" {
  source = "./modules/aks"

  resource_group_name = module.resource_group.name
  location            = var.location

  cluster_name = local.names.aks
  dns_prefix   = local.names.aks

  subnet_id = module.networking.subnet_id

  node_count = var.aks_node_count
  vm_size    = var.aks_vm_size

  service_cidr   = local.networking.aks_service_cidr
  dns_service_ip = local.networking.aks_dns_service_ip

  acr_id = module.acr.id

  tags = local.common_tags
}
