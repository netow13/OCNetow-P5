$DirToBackup = "C:\Users"
$Backup = "\\SRVADPAR01\Sensible"
Remove-Item $Backup -Recurse -Force
Copy-Item -Path $DirToBackup\* -Destination $Backup -Recurse -Force
