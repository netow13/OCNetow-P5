# Script création d'un utilisateur dans l'AD à partir d'un fichier CSV, avec l'ajout de ce dernier dans un groupe
# et la création d'un dossier partagé

# Importe le module active directory pour utiliser les commandlets AD
Import-Module activedirectory
  
# Stocke les données du fichier CSV dans la variable $ADUsers
$ADUsers = Import-csv C:\Users\Administrateur.WIN-LPRU2UTKF0H\Desktop\test2.csv -Delimiter ";"

# Boucle pour chaque rangée contenant les details d'un utilisateur dans un fichier CSV 
foreach ($User in $ADUsers)
{
# Lis les données utilisateur dans chaque champs de chaque rangée et assigne la donnée à une variable ci-dessous	
	
	$Username = $User.LoginNT
	$Password = $User.PswdNT
	$Firstname = $User.Prenom
	$Lastname = $User.Nom
	$Group = $User.Departement
	$OfficePhone = $User.Tel2
    	$MobilePhone = $User.Mobile
    	$Email = $User.email
    


# Vérification de l'existance de l'utilisateur dans l'AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
# Si l'utilisateur existe déjà, message d'erreur
		 Write-Warning "Un compte utilisateur avec pour login $Username existe déjà dans l'Active Directory."
	}
	else
	{
# L'utilisateur n'existe pas donc le script cré un nouveau compte utilisateur
		
		New-ADUser -SamAccountName $Username -UserPrincipalName "$Username@acme.sp" -Name "$Firstname $Lastname" -GivenName $Firstname -Surname $Lastname -OfficePhone $OfficePhone -MobilePhone $MobilePhone -EmailAddress $Email -Enabled $True -DisplayName "$Lastname, $Firstname" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -ChangePasswordAtLogon $True
        
# Ajoute l'utilisateur à son groupe

        	Add-ADGroupMember -Identity $Group -Members $Username             

	}
}
