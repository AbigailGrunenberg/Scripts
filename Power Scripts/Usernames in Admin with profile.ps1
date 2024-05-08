# list of administrator names
$Admins=net localGroup Administrators


<#object
#$User=Get-LocalUser -Name cpsit | select FullName

# object | Select - ExpandPropperty Fullname

#see if user cpsit in $Admins=net localGroup Administrators
function In-Admins-Bool {
    foreach($user in $Admins) {
        if ($user -match "cpsit") {Write-Host "true"}
    else {Write-Host false}
    }
}
#>

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

#Flow chart for In-Both function
<#check if in admin
    true check if in users
        #if true, return name of user
    false #move to next
if none, Write-Host "No Administrators with a User Profile"
#>

#check if item is in given list
#helper function for In-Both
function In-List {
    param (
        [#item
        [Parameter(Mandatory=$true)]
        [object]
        $item],

        [# list
        [Parameter(Mandatory=$true)]
        [array]
        $list]
    )
        if ($List.Contains($item)) {
            Write-Host "Item in List"
            $true 
        }
        else {
            Write-Host "Item not in List"
            $false
        }
}


#return list objects in both $list1 and $list2
# if none, returns nothing
function In-Both {
    param (
        [# list1
        [Parameter(Mandatory=$true)]
        [arrayList]
        $list1],

        [#list2
        [Parameter(Mandatory=$true)]
        [arrayList]
        $list2]
    )
    #list to store objects in both $list1 and $list2
    $List_Both=new-object system.collections.arrayList
    foreach ($object in $list1) {
        if (In-List -item $object -list $list2)
            {
                #add names in both $Admins and $Usernames into $In_Admins_Usernames
                $List_Both.Add($name)
        }
        elseif ($List_Both.Length -eq 0) {
            Write-Host "No objects in both lists."
        }
     } 
        Write-Host $List_Both
}