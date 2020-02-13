# Script exportation liste des groupes dont un utilisateur est membre dans un fichier texte via ligne de commande
param(
    [string] $username
    )

Import-Module activedirectory

$UserN = [Environment]::UserName

# Teste de la présence de l'utilisateur dans AD
try
{    
    $ADUser = Get-ADUser -Identity $username -ErrorAction Stop
    
#Exportation des groupes auquels appartient l'utilisateur dans un fichier texte

    $liste = Get-ADPrincipalGroupMembership -Identity $username | get-adgroup -properties name | select name | out-file C:\Users\$UserN\Desktop\Projet05_Neto_AD03.txt
    
}
catch
{
    "Membre non trouvé"
}
