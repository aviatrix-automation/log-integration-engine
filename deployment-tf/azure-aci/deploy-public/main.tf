data "azurerm_client_config" "current" {
  provider = azurerm.public
}

module "log_analytics_same_subscription" {
  count  = var.log_analytics_subscription_id == "dummy" ? 1 : 0
  source = "../module/log-analytics"
  providers = {
    azurerm = azurerm.public
  }

  log_analytics_workspace_name      = var.log_analytics_workspace_name
  log_analytics_resource_group_name = var.log_analytics_resource_group_name
}

module "log_analytics_diff_subscription" {
  count  = var.log_analytics_subscription_id == "dummy" ? 0 : 1
  source = "../module/log-analytics"
  providers = {
    azurerm = azurerm.loganalytics
  }

  log_analytics_workspace_name      = var.log_analytics_workspace_name
  log_analytics_resource_group_name = var.log_analytics_resource_group_name
}

module "deployment" {
  source = "../module/ai"
  providers = {
    azurerm = azurerm.public
    azuread = azuread.public
  }

  # Resource Configuration
  resource_group_name = var.resource_group_name
  location            = var.location

  # Container Configuration
  container_name  = var.container_name
  container_image = var.container_image
  cpu_cores       = var.cpu_cores
  memory_gb       = var.memory_gb
  container_port  = var.container_port

  # Storage Configuration
  storage_account_name = var.storage_account_name

  # Log Analytics Configuration
  log_analytics_workspace           = var.log_analytics_subscription_id == "dummy" ? module.log_analytics_same_subscription[0].log_analytics_workspace : module.log_analytics_diff_subscription[0].log_analytics_workspace
  log_analytics_resource_group_name = var.log_analytics_resource_group_name

  # If you use your own EntraID Service Principal, uncomment the below and insert appropriate value
  client_app_id     = var.client_app_id
  client_app_secret = var.client_app_secret
  tenant_id         = var.tenant_id
  use_existing_spn  = var.use_existing_spn
  azure_cloud       = var.azure_cloud

  # Tags
  tags = var.tags
}
