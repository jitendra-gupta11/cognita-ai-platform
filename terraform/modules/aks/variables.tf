variable "resource_group_name" {
  description = "Resource Group where AKS will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "cluster_name" {
  description = "AKS Cluster Name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS Prefix for AKS API Server"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for AKS Nodes"
  type        = string
}

variable "node_count" {
  description = "Initial number of nodes"

  type = number

  validation {
    condition     = var.node_count >= 1
    error_message = "Node count must be at least 1."
  }
}

variable "vm_size" {
  description = "AKS Node VM Size"
  type        = string
}

variable "service_cidr" {
  description = "Kubernetes service CIDR. Must not overlap with the VNet or subnet address spaces."
  type        = string
}

variable "dns_service_ip" {
  description = "Kubernetes DNS service IP. Must be inside service_cidr."
  type        = string
}

variable "acr_id" {
  description = "Azure Container Registry ID"
  type        = string
}

variable "tags" {
  description = "Resource tags"

  type = map(string)

  default = {}
}


