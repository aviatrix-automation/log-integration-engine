output "container_group_fqdn" {
  description = "FQDN of the container group"
  value       = azurerm_container_group.logstash.fqdn
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.aci_rg.name
}

output "storage_account_name" {
  description = "Name of the storage account for Logstash configuration"
  value       = azurerm_storage_account.logstash_storage.name
}

output "container_group_name" {
  description = "Name of the Logstash container group"
  value       = azurerm_container_group.logstash.name
}

output "attach_container_command" {
  description = "Copy / Past that command to attach to container"
  value = "az container attach --resource-group ${azurerm_resource_group.aci_rg.name} --name ${azurerm_container_group.logstash.name}"
}