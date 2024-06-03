#activation of KMS batch file for Windows 11

# list of administrator names
$Admins=net localGroup Administrators

#List of user objects
$AllUsers=Get-ChildItem -Path "C:\Users"

#Empty list, store list of usernames as objects 
$Usernames=new-object system.collections.arrayList

#adds users' names to $Usernames
#list of strings
foreach ($user in $AllUsers) {
    $Usernames.Add($user.name)
}

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
#if none, returns nothing
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
              #add names in both $list1 and $list2 to $listBoth
              $listBoth.Add($object)
      }
   } 
      Write-Host $listBoth
}

#placeholder for local download location
$LocalLocation="" 

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
        Write-Host "Starting installation"

        #return list of objects in both $Admins and $Usernames
        InBoth -list1 $Admins -list2 $Usernames

        #Get one unsername that is in both admins and usernames
        $User = "C:\Users\" + $listBoth[0]

        # Location where installer will be installed and run from
        $LocalLocation=$User + "\Downloads\"
    }
}

#Start installation
Main -list $listBoth

# Retrieved from: https://www.thomasmaurer.ch/2010/11/powershell-ftp-upload-and-download/
function Get-FTPFile {
    [CmdletBinding()]
    param (
        # Username for FTP
        [Parameter(Mandatory=$true)]
        [string] $Username,

        # Password for FTP
        [Parameter(Mandatory=$true)]
        [string] $Password,

        # Local Path to put file
        [Parameter(Mandatory=$true)]
        [string] $LocalLocation,

        # Remote Path to download file
        [Parameter(Mandatory=$true)]
        [string] $RemoteLocation
    )

    # Create a FTPWebRequest
    $FTPRequest = [System.Net.FtpWebRequest]::Create($RemoteLocation)
    $FTPRequest.Credentials = New-Object System.Net.NetworkCredential($Username,$Password)
    $FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::DownloadFile
    $FTPRequest.UseBinary = $true
    $FTPRequest.KeepAlive = $false

    # Send the ftp request
    $FTPResponse = $FTPRequest.GetResponse()

    # Get a download stream from the server response
    $ResponseStream = $FTPResponse.GetResponseStream()

    # Create the target file on the local system and the download buffer
    $LocalLocationFile = New-Object IO.FileStream ($LocalLocation,[IO.FileMode]::Create)
    [byte[]]$ReadBuffer = New-Object byte[] 1024

    # Loop through the download
    do {
        $ReadLength = $ResponseStream.Read($ReadBuffer,0,1024)
        $LocalLocationFile.Write($ReadBuffer,0,$ReadLength)
    }
    while ($ReadLength -ne 0)
} 

$Username = "FTPUSER"
$Password = "P@assw0rd"
$LocalLocation = $LocalLocation #defined above 
$RemoteLocation = "ftp://thomasmaurer.ch/downloads/files/file.zip"
Get-FTPFile $Username $Password $LocalLocation $RemoteLocation

