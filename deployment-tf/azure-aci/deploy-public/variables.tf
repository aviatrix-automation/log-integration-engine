variable "resource_group_name" {
  description = "Name of the resource group for the container instance"
  type        = string
  default     = "logstash-aci-rg"
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "France Central"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "logstash"
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
  default     = "docker.elastic.co/logstash/logstash:8.16.2"
}

variable "cpu_cores" {
  description = "Number of CPU cores for the container"
  type        = number
  default     = 1
}

variable "memory_gb" {
  description = "Memory in GB for the container"
  type        = number
  default     = 1.5
}

variable "container_port" {
  description = "Port to expose on the container"
  type        = number
  default     = 5000
}

variable "container_protocol" {
  description = "Protocol for the container port"
  type        = string
  default     = "TCP"
  validation {
    condition     = contains(["TCP", "UDP"], var.container_protocol)
    error_message = "Protocol must be either TCP or UDP."
  }
}

variable "storage_account_name" {
  description = "Name of the storage account for Logstash configuration files"
  type        = string
  default     = "logstashstorage"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be between 3 and 24 characters long and contain only lowercase letters and numbers."
  }
}

variable "file_share_quota_gb" {
  description = "Quota for the file share in GB"
  type        = number
  default     = 5

  validation {
    condition     = var.file_share_quota_gb >= 1 && var.file_share_quota_gb <= 102400
    error_message = "File share quota must be between 1 and 102400 GB."
  }
}

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

variable "environment_variables" {
  description = "Environment variables for the container"
  type        = map(string)
  default = {
    "LS_JAVA_OPTS"             = "-Xmx1g -Xms1g"
    "LOG_LEVEL"                = "info"
    "XPACK_MONITORING_ENABLED" = "false"
    "PIPELINE_WORKERS"         = "1"
    "CONFIG_RELOAD_AUTOMATIC"  = "true"
    "azure_stream_suricata"    = "Custom-AviatrixSuricata_CL"
    "azure_stream_microseg"    = "Custom-AviatrixMicroseg_CL"
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "log-integration-engine"
    Service     = "logstash"
  }
}

variable "logstash_config_variables" {
  description = "Configuration variables for Logstash output plugins"
  type        = map(string)
  default = {
    # Azure Log Ingestion API Configuration
    "azure_dcr_mitm_id"     = ""
    "azure_dcr_fqdn_id"     = ""
    "azure_dcr_cmd_id"      = ""
    "azure_stream_suricata" = "Custom-AviatrixSuricata_CL"
    "azure_stream_mitm"     = "Custom-AviatrixMITM_CL"
    "azure_stream_microseg" = "Custom-AviatrixMicroseg_CL"
    "azure_stream_fqdn"     = "Custom-AviatrixFQDN_CL"
    "azure_stream_cmd"      = "Custom-AviatrixCMD_CL"

    # Microsoft Sentinel Plugin Configuration
    "client_app_id"     = "your-client-app-id"
    "client_app_secret" = "your-client-app-secret"
    "tenant_id"         = "your-tenant-id"
  }
}

variable "use_existing_spn" {
  description = "Whether to use an existing service principal (true) or create a new one (false) for the plugin to send logs to Log Analytics via DCR rules"
  type        = bool
  default     = true
}

variable "client_app_id" {
  description = "Client Application ID for authentication"
  type        = string
  default     = "dummy"
}

variable "client_app_secret" {
  description = "Client Application Secret for authentication"
  type        = string
  default     = "dummy"
  sensitive   = true
}

variable "tenant_id" {
  description = "Tenant ID for authentication"
  type        = string
  default     = "dummy"
}

variable "azure_cloud" {
  description = "Azure cloud environment (e.g., 'AzureCloud', 'AzureUSGovernment', 'AzureChinaCloud')"
  type        = string
  default     = "AzureCloud"
}

variable "log_analytics_subscription_id" {
  description = "Subscription ID for the Log Analytics workspace"
  type        = string
  default     = "dummy"
}
