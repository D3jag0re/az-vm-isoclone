# az-vm-isoclone
This repo is for automating the VM cloning process in Azure when you want to spin up a duplicate for testing purposes, but want to avoid the AD issues that arise when spinning up a VM of the same name.

- Create Iso Subnet in target VNet with NSG defined for subnet 
- Clone The VM into the iso subnet
- Run Commands against the VM 
    - Change Name  
    - Remove From Domain
- Change SN / NSG to target 
- Re-Add To The Domain 
- Destroy ISO VNET and NSG 

Might not be doable with terraform due to snapshots. May be best to stick with Azure Automation and Powershell.
When restoring via PS, it only rstores the desk, extra steps needed to build the VM. 

Or do a mix. TF to create the networking side (and ultimately destroy it) with scripts running in the pipeline. Have TF output for the script to use. 

Due to subnet being in different address space, could we just use existing NSG? TEST. 


