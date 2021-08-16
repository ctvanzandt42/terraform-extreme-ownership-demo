data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                = "cvz-key-vault"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "set",
      "get",
      "list",
      "delete",
      "purge",
      "recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "ld_sdk_key" {
  name         = "ld-sdk-key"
  value        = data.launchdarkly_environment.ld_env.api_key
  key_vault_id = azurerm_key_vault.key_vault.id
}