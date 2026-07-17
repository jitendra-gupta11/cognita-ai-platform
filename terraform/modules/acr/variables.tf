variable "resource_group_name" {
  description = "Name of the Resource Group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "name" {
  description = "Azure Container Registry name."
  type        = string
}

variable "sku" {
  description = "Container Registry SKU."
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "Tags for the registry."
  type        = map(string)
}