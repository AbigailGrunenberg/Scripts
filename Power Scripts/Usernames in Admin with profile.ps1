# list of administrator names
$Admins=net localGroup Administrators


#object
$User=Get-LocalUser -Name cpsit | select FullName

# object | Select - ExpandPropperty Fullname

#see if user cpsit in $Admins=net localGroup Administrators
function In-Admins-Bool {
    foreach($user in $Admins) {
        if ($user -match "cpsit") {Write-Host "true"}
    else {Write-Host false}
    }
}


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

#check if in admin
    #true check if in users
        #if true, return name of user
    #false #move to next
#if none, Write-Host "No Administrators with a User Profile"

#check if item is in given list
function In-List {
    param (
        [object] $item,
        [array] $list
    )
        if ($List.Contains($item)) {
            Write-Host "Item in List"
            $Select=$item 
        }
        else {
            Write-Host "Item not in List"
        }
}

#create empty array to store usernames in both admins and usernames
$In_Admins_Usernames=new-object system.collections.arrayList

#return list of usernames in both the admin and usernames list
function In-Both {
    foreach ($name in $Admins) {
        if (In-List -item $name -list $Usernames)
            {
            $In_Admins_Usernames.Add($name)
            Write-Host $In_Admins_Usernames
    }
        Write-Host $In_Admins_Usernames
   }
}