variable "environment" {
  description = "Deployment environment"
  type        = string

  default = "dev"

  validation {
    condition     = contains(["dev", "uat", "prod"], var.environment)
    error_message = "Environment must be one of: dev, uat, prod."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Central India"
}