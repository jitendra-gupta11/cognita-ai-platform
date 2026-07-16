module "resource_group" {
  source = "./modules/resource-group"

  name     = "rg-${local.project}-${var.environment}"
  location = var.location
  tags     = local.common_tags
}