# Script exportation liste des groupes dont un utilisateur est membre dans un fichier texte via ligne de commande

param(
    [string] $username
    )

Import-Module activedirectory


# Teste de la présence de l'utilisateur dans AD
try
{    
    Get-ADUser -Identity $username -ErrorAction Stop
    
#Exportation des groupes auquels appartient l'utilisateur dans un fichier texte

    Get-ADPrincipalGroupMembership -Identity $username | Get-ADGroup -properties name | select name | Out-File C:\Temp\Projet05_Neto_AD03.txt

    Write-Host "Exportation effectuée! Retrouvez le fichier texte AD03 dans le dossier C:\Temp."
    
}
catch
{
    "Une erreur est survenue"
}
