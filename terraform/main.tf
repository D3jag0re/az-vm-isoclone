# Used to build the temporary Subnet and NSG inside an existing Virtual Network. 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.65.0"
    }
  }
}

# Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Resource Group Data Source 
data "azurerm_resource_group" "vnet_rg" {
  name = var.rgname 
}

# Virtual Network Data Source 
#data "azurerm_virtual_network" "vnet" {
#  name                = var.vnetname 
#  resource_group_name = data.azurerm_resource_group.vnet_rg.name 
#}

resource "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  location            = data.azurerm_resource_group.vnet_rg.location
  resource_group_name = data.azurerm_resource_group.vnet_rg.name
  address_space       = ["173.0.0.0/24"]
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

# Create New Subnet with NSG
resource "azurerm_subnet" "tmp_subnet" {
  name                 = "tmp_iso_sn"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["173.30.0.0/24"]
}

# Create Network Security Group (NSG)
resource "azurerm_network_security_group" "temp_nsg" {
  name                = "tmp_iso_nsg"
  resource_group_name = data.azurerm_resource_group.vnet_rg.name
  location            = data.azurerm_resource_group.vnet_rg.location 
}

# Associate NSG with Subnet 
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.tmp_subnet.id
  network_security_group_id = azurerm_network_security_group.temp_nsg.id
}

