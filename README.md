# az-vm-isoclone
This repo is for automating the VM cloning process in Azure when you want to spin up a duplicate for testing purposes, but want to avoid the AD issues that arise when spinning up a VM of the same name.

- Create Iso Subnet in target VNet with NSG defined for subnet 
- Clone The VM 
- Run Commands against the VM 
    - Change Name  
    - Remove From Domain
- Change SN / NSG to target 
- Re-Add To The Domain 
- Destroy ISO VNET and NSG 

