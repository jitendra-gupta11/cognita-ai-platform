output "id" {
  description = "AKS Cluster ID"
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "AKS Cluster Name"
  value       = azurerm_kubernetes_cluster.this.name
}

output "fqdn" {
  description = "AKS API Server FQDN"
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "kubelet_identity" {
  description = "AKS Kubelet Identity Object ID"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

output "node_resource_group" {
  description = "AKS Managed Resource Group"
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}