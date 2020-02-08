$NomMachine = [system.environment]::MachineName
$DirToBackup = "C:\Users"
$Backup = "\\SRVADPAR01\Sensible"
Remove-Item $Backup\$NomMachine -Recurse -Force
Copy-Item -Path $DirToBackup\* -Destination $Backup\$NomMachine -Recurse -Force
