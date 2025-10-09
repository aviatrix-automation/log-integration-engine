output "log_analytics_workspace" {
  description = "Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.workspace
}
