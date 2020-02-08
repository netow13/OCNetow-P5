# Script de sauvegarde de chaque poste client dans un dossier c:\SAV\ dédié sur le serveur

$NomMachine = [system.environment]::MachineName
$DirToBackup = "C:\Users"
$Backup = "\\SRVADPAR01\Sensible"

# Suppression de la précédente sauvegarde
Remove-Item $Backup\$NomMachine -Recurse -Force

# Nouvelle sauvegarde
Copy-Item -Path $DirToBackup\* -Destination $Backup\$NomMachine -Recurse -Force
