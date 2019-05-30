Clear-Host

# Abrimos la conexi?n con azureAD en caso de no estar conectado
if($azureConnection.Account -eq $null){
    try {
        $azureConnection = Connect-AzureAD    
    } catch {
        Clear-Host
        Write-Warning "Debe conectarse a AzureAD" 
        Start-Sleep -seconds 2
    }
    
}    

# Ficheros requeridos con Funciones auxiliares 
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
try {
    . ("$ScriptDirectory\menu.ps1")    
    . ("$ScriptDirectory\commonFunctions.ps1")  
    . ("$ScriptDirectory\RandomPasswords.ps1")         
}
catch {
    Write-Host "Error cargando ficheros auxiliares PowerShell Scripts" -ForegroundColor Red
}
#endregion

if($azureConnection.Account -ne $null){
    # lanzamos la aplicación llamando al menú principal
    showMainMenu
}

 