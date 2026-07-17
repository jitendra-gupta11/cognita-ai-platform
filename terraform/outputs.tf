output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_name" {
  value = module.networking.vnet_name
}

output "subnet_name" {
  value = module.networking.subnet_name
}

output "acr_name" {
  value = module.acr.name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "aks_name" {
  value = module.aks.name
}

output "aks_fqdn" {
  value = module.aks.fqdn
}

output "aks_node_resource_group" {
  value = module.aks.node_resource_group
}