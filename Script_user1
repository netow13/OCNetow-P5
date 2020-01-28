# Script création de nouveaux utilisateurs dans l'AD avec l'ajout dans un groupe et la création d'un dossier partagé
# pour ce dernier via des question successives

[int] $nombre = Read-Host "Merci de rentrer le nombre d'utilisateurs à créer"

for ($i=1; $i -le $nombre; $i++)
{

#Variables

    $nom = Read-Host "Merci de rentrer le Nom et le Prénom de l'utilisateur à créer"

    $login = Read-Host "Merci de rentrer le login de l'utilisateur à créer"

    $mdp = Read-Host "Merci de rentrer le mot de passe de l'utilisateur à créer"

    $groupe = Read-Host "Merci de rentrer le nom du groupe auquel l'utilisateur est rattaché (SEC, DIR, COM, MAR, ING ou RH)"

#Création utilisateur

    New-ADUser -Name $nom -SamAccountName $login -UserPrincipalName $login@acme.sp -AccountPassword (ConvertTo-SecureString -AsPlainText $mdp -Force) -PasswordNeverExpires $true -CannotChangePassword $true -Enabled $true

#Ajout utilisateur à un groupe

    Add-ADGroupMember -Identity $groupe -Members $login

#Création dossier partagé au nom de l'utilisateur

    New-Item -Path \\SRVADPAR01\Sensible\$groupe -Name $nom -ItemType directory
}
