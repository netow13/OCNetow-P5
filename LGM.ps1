# Script exportation liste des groupes dont un utilisateur est membre
Import-Module activedirectory

# Variable
    $Username = Read-Host "Veuillez entrer le nom d'utilisateur (loginNT)"

# Teste de la présence de l'utilisateur dans AD
try
{    
    $ADUser = Get-ADUser -Identity $Username -ErrorAction Stop
    
#Exportation des groupes auquels appartient l'utilisateur dans un fichier texte

    $liste = Get-ADPrincipalGroupMembership -Identity $Username | get-adgroup -properties name | select name | out-file C:\Users\Administrateur.WIN-LPRU2UTKF0H\Desktop\Membre_concerné_$Username.txt
    
}
catch
{
    "Membre non trouvé"
}