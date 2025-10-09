variable "log_analytics_workspace_name" {
  description = "Name of the existing Log Analytics workspace"
  type        = string
  default     = "we-log-ws"
}

variable "log_analytics_resource_group_name" {
  description = "Resource group name of the existing Log Analytics workspace"
  type        = string
  default     = "we-loga-rg"
}

variable "log_analytics_subscription_id" {
  description = "Subscription ID of the existing Log Analytics workspace. Set to 'dummy' to use the current subscription."
  type        = string
  default     = "dummy"
}
