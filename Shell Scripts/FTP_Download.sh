#!/bin/bash

Username=""
Password=""
URL=""

#download file from FTP

curl --user ftpusername:ftpuserpass -o /Users/Shared/test.txt  ftp://host/test.txt

