resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "backend" {

  name     = local.resource_group_name
  location = local.location

  tags = local.tags
}

resource "azurerm_storage_account" "backend" {

  name                = "${local.storage_account_prefix}${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.backend.name
  location            = azurerm_resource_group.backend.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true
  }

  tags = local.tags
}

resource "azurerm_storage_container" "tfstate" {

  name                  = local.container_name
  storage_account_id    = azurerm_storage_account.backend.id
  container_access_type = "private"

}