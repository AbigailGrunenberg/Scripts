#!/bin/bash

#script to install Chrome

#get pkg 
curl --output /Users/AG/Downloads/Chrome.pkg 'https://dl.google.com/chrome/mac/stable/gcem/GoogleChrome.pkg'
printf "Chrome for Enterprise Downloaded\n"
printf "Chrome for Enterprise Installing\n"

installer -pkg /Users/AG/Downloads/GoogleChrome.pkg -target /Applications
printf "Chrome for Enterprise Installed\n"

cd /Users/Shared; rm Chrome.pkg
printf "Install package removed\n" 

installer -pkg Downloads/Chrome.pkg -target /Applications