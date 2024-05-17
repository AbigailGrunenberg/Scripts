#!/bin/bash

#check if zoom.us.app is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
CiscoLocation="/Applications/Cisco/'Cisco AnyConnect Secure Mobility Client.app'"
AppName="Cisco Secure Endpoint"

if [[ ${Applications[@]} =~ $AppName ]]
    then
    echo "Array element exists"
    exit 0
else   
    echo "Starting installation of $AppName"
    continue
fi 

url="https://console.amp.cisco.com/install_packages/578f304b-bd79-4b41-ae5f-c058a82b5b7d/download?product=MacProduct" # URL of where the DMG is being hosted
dmgfile="ampmac_connector.dmg" # Name of DMG file
dmgvol="ampmac_connector" # Name of DMG volume (obtained after mounting the file)
filename="Cisco AnyConnect Secure Mobility Client.app" # Name of file to copy
filedestination="/Applications/" # Path to where the file should be copied to

#mount dmg
hdiutil attach /path/to/file.dmg

#Retrieved from https://community.spiceworks.com/t/copying-a-file-from-a-dmg-in-bash/946768/8
echo "$(date): Copying..."
cp -rf "/Volumes/$dmgvol/$filename" "$filedestination/$filename"
chmod -R 777 "$filedestination/$filename"
/bin/sleep 10
echo "$(date): Unmounting..."
/usr/bin/hdiutil detach "$(/bin/df | /usr/bin/grep "$dmgvol" | awk '{print $1}')" -quiet
/bin/sleep 10
echo "$(date): Cleaning..."
/bin/rm -rf /tmp/"$dmgfile"