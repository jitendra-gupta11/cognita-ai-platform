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
}