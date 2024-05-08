# Name of URL to download Dropbox
$URL="https://dropbox.com/download?plat=win"

# list of administrator names
$Admins=net localGroup Administrators

#List of user objects
$AllUsers=Get-ChildItem -Path "C:\Users"

#Empty list, store list of usernames as objects 
$Usernames=new-object system.collections.arrayList

#returns list of user profiles
function Get-Profiles {
  foreach ($user in $AllUsers) {
  $Usernames.Add($user.Name)
  }
}

#activate command
Get-Profiles
