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

#check if item is in given list
#helper function for In-Both
function InList {
  [CmdletBinding()]
  param (
      #item
      [Parameter(Mandatory=$true)]
      [object]
      $item,

      #list
      [Parameter(Mandatory=$true)]
      [array]
      $list
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
      #Given list to check
      [Parameter(Mandatory=$true)]
      [array]
      $list
  )
  if ($list -eq 0) {
      $true 
  }
  else {
      $false
  }
}

  #list to store objects in both $list1 and $list2
  $listBoth=new-object system.collections.arrayList

#return list objects in both $list1 and $list2
# if none, returns nothing
function InBoth {
  [CmdletBinding()]
  param (
      #list1
      [Parameter(Mandatory=$true)]
      [array]
      $list1,

      #list2
      [Parameter(Mandatory=$true)]
      [array]
      $list2
  )

  foreach ($object in $list1) {
      if (InList -item $object -list $list2)
          {
              #add names in both $list1 and $list2 to $List_Both
              $listBoth.Add($object)
      }
   } 
      Write-Host $listBoth
}

#check if there are users in both $Admins and $Usernames
#if there are, choose first one and start the installation
#if none, exit
function Main {
    param (
        #list 
        [Parameter(Mandatory=$true)]
        [array]
        $list
    ) 

    if (Empty? -list $list) {
        Write-Host "Could not finish installation"
        exit
    }
    else {
        #return list of objects in both $Admins and $Usernames
        InBoth -list1 $Admins -list2 $Usernames

        #Get one unsername that is in both admins and usernames
        $User = "C:\Users\" + $listBoth[0]

        # Location where installer will be installed and run from
        $Location=$User + "\Downloads\DropboxInstaller.exe"

        #download file to specified location
        Invoke-WebRequest -Uri $URL -Outfile $Location

        #open and run Dropbox installer
        & $Location 
    }

}

#Start installation
Main -list $listBoth
