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
data "azurerm_virtual_network" "vnet" {
  name                = var.vnetname 
  resource_group_name = azurerm_resource_group.vnet_rg.name 
}

# Create New Subnet with NSG
resource "azurerm_subnet" "tmp_subnet" {
  name                 = var.subname
  virtual_network_name = azurerm_virtual_network.vnet.id
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["173.30.0.0/24"]
}

# Create Network Security Group (NSG)
resource "azurerm_network_security_group" "temp_nsg" {
  name                = var.nsgname
  resource_group_name = azurerm_resource_group.dvnet_rg.name
  location            = azurerm_resource_group.dvnet_rg.location 
}

# Associate NSG with Subnet 
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.tmp_subnet.id
  network_security_group_id = azurerm_network_security_group.temp_nsg.id
}

