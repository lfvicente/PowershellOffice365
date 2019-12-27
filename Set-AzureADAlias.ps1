<# 
.NAME
    Set-AzureADAlias

.SYNOPSIS
    Update Office 365 or AzureAD User Alias 

.DESCRIPTION
    Easy way to Update Office 365 or AzureAD User Alias. Accounts can to have zero or more Alias. 
    Basiclly, the function changes the UserPrincipalName by the Alias and continue repeat the same process one more time. 
    I had noticed this effect when you make this change manually on the Office 365 Admin Portal. 
    I needed automatice Alias provision for my deployment and on powershell is the same result.
    ProxyAddresses includes Principal Mail address, UserPrincipalName and the others alias or mail addresses.

.NOTES
    Version:        1.0   
    Author:         Luis Felipe Vicente Díez   
    Creation Date:  27/12/2019   
    
.EXAMPLE
    Set-AzureADAlias -UserPrincipalName "luis.vicente@midominio.es" -Alias "lfvicente@midominio.es"

#>
function Set-AzureADAlias
{

Param
(
[Parameter(Mandatory=$true,
    Position=1)]
    [String]
    $UserPrincipalName,
[Parameter(Mandatory=$true,
    Position=2)]
    [String]
    $Alias
)
    #Function Logic:
    $user=(Get-AzureADUser -ObjectId $UserPrincipalName);

    Set-AzureADUser -ObjectId $user.ObjectId -UserPrincipalName $Alias;

    #Is this really necesary? Im not sure
    $refresh=(Get-AzureADUser -ObjectId $user.ObjectId);

    Set-AzureADUser -ObjectId $user.ObjectId -UserPrincipalName $UserPrincipalName;

    Get-AzureADUser -ObjectId $user.ObjectId | select ObjectId, DisplayName, UserPrincipalName, UserType, ProxyAddresses ;

}
