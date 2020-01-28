# Script exportation liste des groupes dont un utilisateur est membre
param(
    [string] $username
    )

Import-Module activedirectory

# Teste de la présence de l'utilisateur dans AD
try
{    
    $ADUser = Get-ADUser -Identity $username -ErrorAction Stop
    
#Exportation des groupes auquels appartient l'utilisateur dans un fichier texte

    $liste = Get-ADPrincipalGroupMembership -Identity $username | get-adgroup -properties name | select name | out-file C:\Users\Administrateur.WIN-LPRU2UTKF0H\Desktop\Membre_concerné_$username.txt
    
}
catch
{
    "Membre non trouvé"
}