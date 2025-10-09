# Data source for existing Log Analytics workspace
data "azurerm_log_analytics_workspace" "workspace" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_resource_group_name
}

data "azurerm_client_config" "current" {}

