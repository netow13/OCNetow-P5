#Script exportation des membres d'un groupe dans un fichier texte via ligne de commande
param(
    [string] $groupe
    )

Import-Module activedirectory

$UserName = [Environment]::UserName

#Teste de la présence du groupe dans AD

try
{
    $ADgroupe = Get-ADGroup -Identity $groupe -ErrorAction Stop

#Exportation des membres d'un groupe dans un fichier texte si ce dernier existe
    
    $liste = get-ADGroupMember -Identity $groupe | select Name,SamAccountName | out-file C:\Users\$UserName\Desktop\Projet05_Neto_AD02.txt
   
}
catch
{
    "Groupe non trouvé"
}
