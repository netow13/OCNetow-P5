#Script exportation des membres d'un groupe dans un fichier texte
Import-Module activedirectory

#Variable

$groupe = Read-Host "Entrez le nom du groupe dont vous souhaitez la liste des membres"

#Teste de la présence du groupe dans AD

try
{
    $ADgroupe = Get-ADGroup -Identity $groupe -ErrorAction Stop

#Exportation des membres d'un groupe dans un fichier texte si ce dernier existe
    
    $liste = get-ADGroupMember -Identity $groupe | Get-ADUser -Properties Mail,OfficePhone,MobilePhone | select Name,Mail,OfficePhone,MobilePhone | out-file C:\Users\Administrateur.WIN-LPRU2UTKF0H\Desktop\Groupe_concerné_$groupe.txt
   
}
catch
{
    "Groupe non trouvé"
}