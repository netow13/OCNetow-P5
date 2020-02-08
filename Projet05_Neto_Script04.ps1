# Script de sauvegarde de chaque poste client dans un dossier c:\SAV\ dédié sur le serveur

$DirToBackup = "C:\Users"
$Backup = "\\SRVADPAR01\Sensible\[sytem.environment]::MachineName"

if(Test-Path $Backup
# Suppression de la précédente sauvegarde
Remove-Item $Backup\$NomMachine\* -Recurse -Force

# Nouvelle sauvegarde
Copy-Item -Path $DirToBackup\* -Destination $Backup\$NomMachine -Recurse -Force
