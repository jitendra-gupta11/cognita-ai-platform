output "vnet_id" {
  description = "ID of the Virtual Network."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the Virtual Network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_id" {
  description = "ID of the AKS subnet."
  value       = azurerm_subnet.aks.id
}

output "subnet_name" {
  description = "Name of the AKS subnet."
  value       = azurerm_subnet.aks.name
}

output "nsg_id" {
  description = "ID of the Network Security Group."
  value       = azurerm_network_security_group.aks.id
}