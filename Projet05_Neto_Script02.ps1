#Script exportation des membres d'un groupe dans un fichier texte via ligne de commande

param(
    [string] $groupe
    )

Import-Module activedirectory


#Teste de la présence du groupe dans AD

try
{
    Get-ADGroup -Identity $groupe -ErrorAction Stop

#Exportation des membres d'un groupe dans un fichier texte si ce dernier existe
    
    Get-ADGroupMember -Identity $groupe | select Name,SamAccountName | out-file C:\Temp\Projet05_Neto_AD02.txt

    Write-Host "Exportation effectuée! Retrouvez le fichier texte AD02 dans le dossier C:\Temp."
   
}
catch
{
    "Une erreur est survenue"
}
