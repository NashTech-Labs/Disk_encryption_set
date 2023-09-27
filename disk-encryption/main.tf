terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}


resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "kv" {
  name                        = var.key-vault-name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.sku-name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  purge_protection_enabled    = var.purge_protection_enabled
}

resource "azurerm_key_vault_key" "kv_key" {
  name         = var.key-vault-key
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = var.key_type
  key_size     = var.key_size

  depends_on = [
    azurerm_key_vault_access_policy.user
  ]

  key_opts = [
    "decrypt",
    "encrypt",
    "unwrapKey",
    "wrapKey",
  ]
}

resource "azurerm_disk_encryption_set" "disk_set" {
  name                = var.disk_encryption_set
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  key_vault_key_id    = azurerm_key_vault_key.kv_key.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_key_vault_access_policy" "disk" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = azurerm_disk_encryption_set.disk_set.identity.0.tenant_id
  object_id = azurerm_disk_encryption_set.disk_set.identity.0.principal_id

  key_permissions = [
    "Create",
    "Delete",
    "Get",   
    "Update",
  ]
}

resource "azurerm_key_vault_access_policy" "user" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create",
    "Delete",
    "Get",
    "Update",
  ]
}

resource "azurerm_role_assignment" "disk_role" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_disk_encryption_set.disk_set.identity.0.principal_id
}