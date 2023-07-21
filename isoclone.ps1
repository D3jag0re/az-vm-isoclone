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
$newSubnetName = $config.newSubnetName
$newNsgName = $config.newNsgName
$vmName = $config.vmName
$newVMName = $config.newVMName
$newVMResourceGroupName = $config.newVMResourceGroupName
$domainName = $config.domainName

