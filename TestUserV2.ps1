# Importe le module active directory pour utiliser les commandlets AD
Import-Module activedirectory

$Chemin = Read-Host "Veuillez entrer le nom du fichier CSV pour la création de comptes utilisateurs" 

if((Test-Path C:\Windows\Temp\$Chemin) -eq $True)
{
# Stocke les données du fichier CSV dans la variable $ADUsers
    $ADUsers = Import-csv C:\Windows\Temp\$Chemin -Delimiter ";"

# Boucle pour chaque rangée contenant les details d'un utilisateur dans un fichier CSV 
    foreach ($User in $ADUsers)
    {
# Lis les données utilisateur dans chaque champs de chaque rangée et assigne la donnée à une variable ci-dessous	
	
	    $Username 	= $User.LoginNT
    
# Vérification de l'existance de l'utilisateur dans l'AD
	    if (Get-ADUser -F {SamAccountName -eq $Username})
	    {
# Si l'utilisateur existe déjà, message d'erreur
		    Write-Warning "Un compte utilisateur avec pour login $Username existe déjà dans l'Active Directory."
	    }
        else
	    {
            $Password 	= PswdNT
	        $Firstname 	= $User.Prenom
	        $Lastname 	= $User.Nom
	        $Group = $User.Departement
            $OfficePhone = $User.Tel2
            $MobilePhone = $User.Mobile
            $Email = $User.email

# L'utilisateur n'existe pas donc le script cré un nouveau compte utilisateur
		
		    New-ADUser -SamAccountName $Username -UserPrincipalName "$Username@acme.sp" -Name "$Firstname $Lastname" -GivenName $Firstname -Surname $Lastname -OfficePhone $OfficePhone -MobilePhone $MobilePhone -EmailAddress $Email -Enabled $True -DisplayName "$Lastname, $Firstname" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -ChangePasswordAtLogon $True
        
# Ajoute l'utilisateur à son groupe

            Add-ADGroupMember -Identity $Group -Members $Username
            
# Création dossier partagé ayant pour nom le login de l'utilisateur
            
            New-Item -Path \\SRVADPAR01\Sensible\$Group -Name $Username -ItemType directory           

	    }
    }
}

else
{    
    Write-Host "Le fichier $Chemin n'existe pas"

    [int] $nombre = Read-Host "Merci d'entrer le nombre d'utilisateurs à créer"

    for ($i=1; $i -le $nombre; $i++)
    {

        $Username = Read-Host "Merci d'entrer le login de l'utilisateur à créer"

# Vérification de l'existance de l'utilisateur dans l'AD
	    if (Get-ADUser -F {SamAccountName -eq $Username})
	    {
# Si l'utilisateur existe déjà, message d'erreur
		    Write-Warning "Un compte utilisateur avec pour login $Username existe déjà dans l'Active Directory."
	    }
        else
	    {
            $NbGroup = Read-Host "Merci d'entrer le nombre de groupe auquel appartient l'utilisateur"

            

            $Firstname = Read-Host "Merci d'entrer le prénom de l'utilisateur à créer"
            $Lastname = Read-Host "Merci d'entrer le nom de l'utilisateur à créer"
            $Password = Pwd$Lastname%
            $Officephone = Read-Host "Merci d'entrer le numéro de téléphone de bureau de l'utilisateur"
            $Mobilephone = Read-Host "Merci d'entrer le numéro de téléphone mobile de l'utilisateur"
            $Email = Read-Host "Merci d'entrer l'adresse email de l'utilisateur"

# Création utilisateur

            New-ADUser -SamAccountName $Username -UserPrincipalName "$Username@acme.sp" -Name "$Firstname $Lastname" -GivenName $Firstname -Surname $Lastname -OfficePhone $OfficePhone -MobilePhone $MobilePhone -EmailAddress $Email -Enabled $True -DisplayName "$Lastname, $Firstname" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -ChangePasswordAtLogon $True

            if($NbGroup -ge 1)
            {
                $i = 1
                While($i -le $NbGroup)
                {
                    $Group = Read-Host "Merci d'entrer le nom du groupe n°$i auquel l'utilisateur est rattaché (SEC, DIR, COM, MAR, ING ou RH)"

# Ajout utilisateur à un groupe                    
                    Add-ADGroupMember -Identity $Group -Members $Username

# Création dossier partagé ayant pour nom le login de l'utilisateur
                    New-Item -Path \\SRVADPAR01\Sensible\$Group -Name $Username -ItemType directory

                    $i++
                }
            }
            else
            {
                Write-Host "L'utilisateur n'a été ajouté à aucun groupe"
            }
        }
    }
}