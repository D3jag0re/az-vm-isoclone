output "rg_name" {
  value = data.azurerm_resource_group.vnet_rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.id
}

output "sn_name" {
  value = azurerm_subnet.tmp_subnet.id
}

output "nsg_name" {
  value = azurerm_network_security_group.temp_nsg.id
}



