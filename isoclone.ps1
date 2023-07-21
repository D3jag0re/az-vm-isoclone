# Import the AzureRM module
Import-Module AzureRM

# Authenticate to Azure with service principal credentials
#$connection = Get-AutomationConnection -Name 'AzureRunAsConnection'
#Connect-AzureRmAccount -ServicePrincipal `
#    -Tenant $connection.TenantID `
#    -ApplicationId $connection.ApplicationID `
#    -CertificateThumbprint $connection.CertificateThumbprint

# Try running after connecting in terminal. Will need to use Service Principal, Managed Identity, or automation account role assignments https://learn.microsoft.com/en-us/azure/automation/learn/automation-tutorial-runbook-textual

# Read variables from the configuration file
$configFile = '.\config.json'
$config = Get-Content $configFile | ConvertFrom-Json

$resourceGroupName = $config.resourceGroupName
$virtualNetworkName = $config.virtualNetworkName
$virtualNetworkAddressSpace = $config.AddressSpace
$newSubnetName = $config.newSubnetName
$newNsgName = $config.new_nsg_name
$vmName = $config.vmName
$newVMName = $config.newVMName
$newVMResourceGroupName = $config.newVMResourceGroupName
$domainName = $config.domainName

# Add the new address space to the existing virtual network
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName
$vnet | Add-AzureRmVirtualNetworkAddressSpace -AddressSpace $config.AddressSpace
$vnet | Set-AzureRmVirtualNetwork

# Create a new subnet with a network security group attached
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name $newSubnetName -AddressPrefix '173.30.0.0/24' -NetworkSecurityGroup $(New-AzureRmNetworkSecurityGroup -Name $newNsgName -ResourceGroupName $resourceGroupName -Location 'YourLocation')

# Add the new subnet to the existing virtual network
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName
$vnet | Add-AzureRmVirtualNetworkSubnetConfig -Name $newSubnetName -AddressPrefix '173.30.0.0/24' -NetworkSecurityGroup $(Get-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Name $newNsgName)
$vnet | Set-AzureRmVirtualNetwork


