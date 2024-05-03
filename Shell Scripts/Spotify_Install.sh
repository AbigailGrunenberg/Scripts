#!/bin/bash

#script to install Chrome

#get pkg 
curl -o /Users/Shared/Chrome.pkg 'https://dl.google.com/chrome/mac/stable/gcem/GoogleChrome.pkg'
printf "Chrome for Enterprise Downloaded\n"
printf "Chrome for Etnerprise Installing\n"

installer -pkg /Users/Shared/Chrome.pkg -target /
printf "Chrome for Enterprise Installed\n"

cd /Users/Shared; rm Chrome.pkg
printf "Install package removed\n"

