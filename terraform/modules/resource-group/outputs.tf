output "id" {
  description = "Resource Group ID"

  value = azurerm_resource_group.this.id
}

output "name" {
  description = "Resource Group Name"

  value = azurerm_resource_group.this.name
}