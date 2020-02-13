# README

Documentation des différents scripts proposés.

## Nom
  Projet05_Neto_Script01.ps1

### Description
  C'est un script de création d'utilisateur dans l'Active Directory à partir de la ligne de commande ou d'un fichier CSV.
  Le paramètre -fichier prend en argument le nom d'un fichier CSV contenant les différentes informations des utilisateurs à créer et
  qui a pour chemin d'accès C:\Windows\Temp\.
  Les paramètres -lastname et -firstname prennent en argument le nom puis le prénom de l'utilisateur à créer manuellement.
  
## Nom
  Projet05_Neto_Script02.ps1
  
### Description
  C'est un script d'exportation des membres d'un groupe présent dans l'Active Directory à partir de la ligne de commande. Le paramètre
  -groupe prend en argument le nom du groupe dont on souhaite connaître les membres. L'identité des membres du groupe sera enregistrée
  dans un fichier texte ayant pour nom Projet05_Neto_AD02.txt. Le chemin d'accès à ce fichier texte est C:\Users\$UserN\Desktop.
  
## Nom
  Projet05_Neto_Script03.ps1
  
### Description
  C'est un script d'exportation de la liste des groupes dont un utilisateur est membre à partir de la ligne de commande. Le paramètre
  -username prend en argument le nom d'utiliateur. La liste des groupes auxquels appartient l'utilisateur sera enregistré dans un fichier   texte ayant pour nom Projet05_Neto_AD03.txt. Le chemin d'accès à ce fichier texte est C:\Users\$UserName\Desktop.
  
## Nom
  Projet05_Neto_Script04.ps1
  
### Description
