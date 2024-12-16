#!/bin/sh
# install/update office to 2021 version

Applications=(/Applications/*)
DownloadLoc="/Users/Shared/MSOffice.pkg"
OfficeLoc="/Applications/MSOffice.pkg"
OSVersion=(sw_vers -productVersion)

if [[ (( $OSVersion < 13 )) ]]
    then
    osascript -e 'Need MacOS version 13.0.0 or above to continue'
	exit 1
else   
    curl -Ls -o $DownloadLoc 'https://go.microsoft.com/fwlink/?linkid=2009112'
    installer -pkg $DownloadLoc -target /Applications
    cd /Users/Shared; rm -v Chrome.pkg
fi 

#exit 1 failure