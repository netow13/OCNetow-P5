# Script de sauvegarde de chaque poste client dans un dossier c:\SAV\ dédié sur le serveur

$NomMachine = "[system.environment]::MachineName"
$DirToBackup = "C:\Users"
$Backup = "\\SRVADPAR01\sav"

# Teste de l'existance d'un dossier de sauvegarde selon la machine
if(Test-Path $Backup\$NomMachine -eq True)
{  
# Suppression de la précédente sauvegarde
  Remove-Item $Backup\$NomMachine\* -Recurse -Force

# Nouvelle sauvegarde
  Copy-Item -Path $DirToBackup\* -Destination $Backup\$NomMachine -Recurse -Force
}
else
{
# Création d'un dossier de sauvegarde pour la nouvelle machine
  New-Item -Path $Backup -Name $NomMachine -ItemType directory
# Première sauvegarde  
  Copy-Item -Path $DirToBackup\* -Destination $Backup\$NomMachine -Recurse -Force
}
