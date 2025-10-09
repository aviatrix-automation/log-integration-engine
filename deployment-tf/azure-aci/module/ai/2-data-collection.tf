# Terraform configuration file for Azure Monitor Data Collection Rules and related resources

## Data Collection Endpoint used as entry point for Data Collection Rules
resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                = "avx-drc-${random_integer.suffix.result}"
  location            = azurerm_resource_group.aci_rg.location
  resource_group_name = azurerm_resource_group.aci_rg.name

}

## Data Collection Rules for Aviatrix Firewall logs
resource "azurerm_monitor_data_collection_rule" "aviatrix_microseg" {
  name                        = "aviatrix-microseg-dcr"
  location                    = azurerm_resource_group.aci_rg.location
  resource_group_name         = azurerm_resource_group.aci_rg.name
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.dce.id

  data_flow {
    streams       = ["Custom-AviatrixMicroseg_CL"]
    destinations  = ["loganalytics-destination"]
    output_stream = "Custom-AviatrixMicroseg_CL"
    transform_kql = "source"
  }

  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace.id
      name                  = "loganalytics-destination"
    }
  }

  stream_declaration {
    stream_name = "Custom-AviatrixMicroseg_CL"
    column {
      name = "TimeGenerated"
      type = "datetime"
    }
    column {
      name = "action"
      type = "string"
    }
    column {
      name = "dst_ip"
      type = "string"
    }
    column {
      name = "dst_mac"
      type = "string"
    }
    column {
      name = "dst_port"
      type = "int"
    }
    column {
      name = "enforced"
      type = "boolean"
    }
    column {
      name = "gw_hostname"
      type = "string"
    }
    column {
      name = "ls_timestamp"
      type = "string"
    }
    column {
      name = "proto"
      type = "string"
    }
    column {
      name = "src_ip"
      type = "string"
    }
    column {
      name = "src_mac"
      type = "string"
    }
    column {
      name = "src_port"
      type = "int"
    }
    column {
      name = "tags"
      type = "dynamic"
    }
    column {
      name = "uuid"
      type = "string"
    }
  }
}

## Data Collection Rules for Aviatrix IDS logs
resource "azurerm_monitor_data_collection_rule" "aviatrix_suricata" {
  name                        = "aviatrix-suricata-dcr"
  location                    = azurerm_resource_group.aci_rg.location
  resource_group_name         = azurerm_resource_group.aci_rg.name
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.dce.id

  data_flow {
    streams       = ["Custom-AviatrixSuricata_CL"]
    destinations  = ["loganalytics-destination"]
    output_stream = "Custom-AviatrixSuricata_CL"
    transform_kql = "source"
  }

  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace.id
      name                  = "loganalytics-destination"
    }
  }

  stream_declaration {
    stream_name = "Custom-AviatrixSuricata_CL"
    column {
      name = "TimeGenerated"
      type = "datetime"
    }
    column {
      name = "Computer"
      type = "string"
    }
    column {
      name = "alert"
      type = "dynamic"
    }
    column {
      name = "app_proto"
      type = "string"
    }
    column {
      name = "dest_ip"
      type = "string"
    }
    column {
      name = "dest_port"
      type = "int"
    }
    column {
      name = "event_type"
      type = "string"
    }
    column {
      name = "files"
      type = "dynamic"
    }
    column {
      name = "flow"
      type = "dynamic"
    }
    column {
      name = "flow_id"
      type = "long"
    }
    column {
      name = "http"
      type = "dynamic"
    }
    column {
      name = "in_iface"
      type = "string"
    }
    column {
      name = "ls_timestamp"
      type = "string"
    }
    column {
      name = "ls_version"
      type = "string"
    }
    column {
      name = "proto"
      type = "string"
    }
    column {
      name = "src_ip"
      type = "string"
    }
    column {
      name = "src_port"
      type = "int"
    }
    column {
      name = "tags"
      type = "dynamic"
    }
    column {
      name = "timestamp"
      type = "string"
    }
    column {
      name = "tx_id"
      type = "int"
    }
    column {
      name = "SourceType"
      type = "string"
    }
    column {
      name = "UnixTime"
      type = "long"
    }
  }
}
