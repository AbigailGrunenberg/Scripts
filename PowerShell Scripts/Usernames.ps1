﻿# list of administrator names
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
    [CmdletBinding()]
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
function InList {
    [CmdletBinding()]
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
            $true 
        }
        else {
            $false
        }
}

#returns if list is empty, false otherwise
function Empty? {
    [CmdletBinding()]
    param (
        [# Given list to check
        [Parameter(Mandatory=$true)]
        [arrayList]
        $list]
    )
    if ($list -eq 0) {
        $true 
    }
    else {
        $false
    }
}


#return list objects in both $list1 and $list2
# if none, returns nothing
function InBoth {
    [CmdletBinding()]
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
    $listBoth=new-object system.collections.arrayList
    foreach ($object in $list1) {
        if (InList -item $object -list $list2)
            {
                #add names in both $list1 and $list2 to $List_Both
                $listBoth.Add($name)
        }
     } 
        Empty? -list $listBoth
        Write-Host $listBoth
}
