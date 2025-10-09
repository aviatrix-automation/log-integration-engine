# Current provider / subscription is China
provider "azurerm" {
  features {}
  alias       = "china"
  environment = "china"
}

# Log Analytics provider for China
provider "azurerm" {
  features {}
  alias           = "loganalytics"
  subscription_id = var.log_analytics_subscription_id == "dummy" ? data.azurerm_client_config.current.subscription_id : var.log_analytics_subscription_id
  environment     = "china"
}

provider "azuread" {
  alias       = "china"
  environment = "china"
}
