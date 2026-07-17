variable "resource_group_name" {
  description = "Name of the Resource Group where networking resources will be created."
  type        = string
}

variable "location" {
  description = "Azure region where networking resources will be deployed."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network."
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the AKS subnet."
  type        = string
}

variable "subnet_prefix" {
  description = "Address prefix for the AKS subnet."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to networking resources."
  type        = map(string)
}