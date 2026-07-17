resource "azurerm_kubernetes_cluster" "this" {

  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = var.dns_prefix

  sku_tier = "Free"

  default_node_pool {

    name = "system"

    vm_size = var.vm_size

    node_count = var.node_count

    vnet_subnet_id = var.subnet_id

    type = "VirtualMachineScaleSets"

    os_disk_type = "Managed"

    os_disk_size_gb = 128
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {

    network_plugin = "azure"

    network_plugin_mode = "overlay"

    network_policy = "azure"

    load_balancer_sku = "standard"

    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  role_based_access_control_enabled = true

  oidc_issuer_enabled = true

  workload_identity_enabled = true

  tags = var.tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {

  scope = var.acr_id

  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id

  skip_service_principal_aad_check = true
}