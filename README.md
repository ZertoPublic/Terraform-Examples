# Terraform-Examples
Basic Terraform config skeletons that can be used for ZVM/ZCA and example VM deployments

# Legal Disclaimer
This script is an example script and is not supported under any Zerto support program or service. The author and Zerto further disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.

In no event shall Zerto, its authors or anyone else involved in the creation, production or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or the inability to use the sample scripts or documentation, even if the author or Zerto has been advised of the possibility of such damages. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you.

# Requirements
zvm_in_vsphere - user will be required to have pre-existing Windows Server 2012 - 2019 template that has .NET 4.7.2 or higher installed 
zca_in_azure - user will be required to accept marketplace EULA before programmatically deploying Zerto marketplace image. Additional information on how to accept EULA programmatically can be found on Microsoft Docs (https://docs.microsoft.com/en-us/powershell/module/azurerm.marketplaceordering/set-azurermmarketplaceterms?view=azurermps-6.13.0) 


# Configuration
Each example has variables that will need to be uniquely defined per user environment. These variable include things like local OS username and password, private or public IP address, and subnet. The examples have left these values blank with the intent of the user configuring them before initial execution 
