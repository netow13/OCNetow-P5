#Script exportation des membres d'un groupe dans un fichier texte
param(
    [string] $groupe
    )

Import-Module activedirectory

#Teste de la présence du groupe dans AD

try
{
    $ADgroupe = Get-ADGroup -Identity $groupe -ErrorAction Stop

#Exportation des membres d'un groupe dans un fichier texte si ce dernier existe
    
    $liste = get-ADGroupMember -Identity $groupe | select Name,SamAccountName | out-file C:\Users\Administrateur.WIN-LPRU2UTKF0H\Desktop\Groupe_concerné_$groupe.txt
   
}
catch
{
    "Groupe non trouvé"
}