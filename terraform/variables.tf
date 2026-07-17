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

variable "aks_node_count" {
  description = "Initial AKS node count"
  type        = number
  default     = 1
}

variable "aks_vm_size" {
  description = "AKS Node VM Size"
  type        = string
  default     = "Standard_B2s_v2"
}