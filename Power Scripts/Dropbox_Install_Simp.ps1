# Simplified dropbox insatllation script 

# Name of URL to download Dropbox
$URL="https://dropbox.com/download?plat=win"

#Name of current userprofile
$User=$env:USERPROFILE

#Name of current Domain
$env:USERDNSDOMAIN

# Location where installer will be installed and run from
# depends on logged in
$Location="$User\Downloads\DropboxInstaller.exe"

#$Location="C:\Users\cpsit\Downloads\DropboxInstaller.exe"

#download file to specified location
Invoke-WebRequest -Uri $URL -Outfile $Location

#open and run Dropbox installer
& $Location


