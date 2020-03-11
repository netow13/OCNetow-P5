# Script de sauvegarde de chaque poste client dans un dossier C:\SAV\ dédié sur le serveur

$NomMachine = [system.environment]::MachineName
$DirToBackup = "C:\Users"
$Backup = "\\SRVADPAR01\sav\$NomMachine"
$exclude = @("ntuser*", "AppData")

# Teste de l'existance d'un dossier de sauvegarde selon la machine
if(Test-Path $Backup\$NomMachine)
{  
# Suppression de la précédente sauvegarde
  Remove-Item $Backup\$NomMachine\* -Recurse -Force

# Nouvelle sauvegarde du dossier C:\User en excluant les fichiers ntuser et dossiers AppData
  Get-ChildItem $DirToBackup -Recurse -Exclude $exclude | Copy-Item -Destination {join-path $Backup $_.FullName.Substring($DirToBackup.Length)}
  }
else
{
# Création d'un dossier de sauvegarde pour la nouvelle machine
  New-Item -Path $Backup -Name $NomMachine -ItemType directory

# Première sauvegarde du dossier C:\User en excluant les fichiers ntuser et dossiers AppData
  Get-ChildItem $DirToBackup -Recurse -Exclude $exclude | Copy-Item -Destination {join-path $Backup $_.FullName.Substring($DirToBackup.Length)}
}
