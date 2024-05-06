# Name of URL
$URL="https://dropbox.com/download?plat=win"

#Name of current userprofile
$User=$env:USERPROFILE

#Name of current Domain
$env:USERDNSDOMAIN

# Location where installer will be installed and run from
# should be to an Admin account to ensure it is installed on all users
$Location="C:\Users\cpsit\Downloads\DropboxInstaller.exe"

#download file to Downloads folder
Invoke-WebRequest -Uri $URL -Outfile $Location

#open and run Dropbox installer
& $Location


# Get who I am
 $Me = whoami.exe
 $Me 
Cookham\JerryG

# Get members of administrators group
$Admins = Get-LocalGroupMember -Name Administrators | 
       Select-Object -ExpandProperty name

# Check to see if this user is an administrator and act accordingly
if ($Admins -Contains $Me) {
      "$Me is a local administrator"} 
    else {
     "$Me is NOT a local administrator"}
Cookham\JerryG is a local administrator

MEDF-BIOC-05500

$env:USERDNSDOMAIN