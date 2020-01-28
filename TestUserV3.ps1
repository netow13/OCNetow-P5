# Script création d'utilisateur(s) dans l'AD depuis la ligne de commande ou depuis un fichier CSV

param(
    [string] $fichier, $lastname, $firstname
    )

# Importe le module active directory pour utiliser les commandlets AD
Import-Module activedirectory

# Vérification de l'existance d'un argument pour le paramêtre fichier
if($PSBoundParameters.ContainsKey("fichier"))
{
# Vérification de l'existance ou non du fichier
    if((Test-Path C:\Windows\Temp\$fichier) -eq $True)
    {
# Stocke les données du fichier CSV dans la variable $ADUsers
        $ADUsers = Import-csv C:\Windows\Temp\$fichier -Delimiter ";"

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
                $Password = PswdNT
	        $Firstname = $User.Prenom
	        $Lastname = $User.Nom
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
        Write-Warning "Le fichier $fichier n'existe pas"
    }
}
else
{
# Vérification de l'existance d'un argument pour le paramêtre lastname
    if($PSBoundParameters.ContainsKey("lastname"))
    {
# Vérification de l'existance d'un argument pour le paramêtre firstname
        if($PSBoundParameters.ContainsKey("firstname"))
        {
            $Username = $firstname.SubString(0,1).ToLower()+$lastname.ToLower()

# Vérification de l'existance de l'utilisateur dans l'AD
	        if (Get-ADUser -F {SamAccountName -eq $Username})
	        {
		        Write-Warning "Un compte utilisateur avec pour login $Username existe déjà dans l'Active Directory."
	        }
            else
	        {
                $NbGroup = Read-Host "Merci d'entrer le nombre de groupe auquel appartient l'utilisateur"

                $Password = Pwd$lastname%
                $Officephone = Read-Host "Merci d'entrer le numéro de téléphone de bureau de l'utilisateur"
                $Mobilephone = Read-Host "Merci d'entrer le numéro de téléphone mobile de l'utilisateur"
                $Email = Read-Host "Merci d'entrer l'adresse email de l'utilisateur"

# Création utilisateur

                New-ADUser -SamAccountName $Username -UserPrincipalName "$Username@acme.sp" -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -OfficePhone $OfficePhone -MobilePhone $MobilePhone -EmailAddress $Email -Enabled $True -DisplayName "$lastname, $firstname" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -ChangePasswordAtLogon $True
                if($NbGroup -ge 1)
                {
                    $i = 1
# Boucle d'ajout d'un utilisateur à 1 ou plusieurs groupes
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
                    Write-Warning "L'utilisateur n'a été ajouté à aucun groupe"
                }
            }
        }
        else
        {
            Write-Warning "Aucun prénom n'a été utilisé en argument"
        }
    }
    else
    {
        Write-Warning "Aucun nom n'a été utilisé en argument"
    }
}
