# script to download files from FTP server

#Retrieved from: https://www.thomasmaurer.ch/2010/11/powershell-ftp-upload-and-download/
$Username = "FTPUSER"
$Password = "P@assw0rd"
$LocalFile = "C:\Temp\file.zip"
$RemoteFile = "ftp://thomasmaurer.ch/downloads/files/file.zip"
 
# Create a FTPWebRequest
$FTPRequest = [System.Net.FtpWebRequest]::Create($RemoteFile)
$FTPRequest.Credentials = New-Object System.Net.NetworkCredential($Username,$Password)
$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::DownloadFile
$FTPRequest.UseBinary = $true
$FTPRequest.KeepAlive = $false

# Send the ftp request
$FTPResponse = $FTPRequest.GetResponse()

# Get a download stream from the server response
$ResponseStream = $FTPResponse.GetResponseStream()

# Create the target file on the local system and the download buffer
$LocalFileFile = New-Object IO.FileStream ($LocalFile,[IO.FileMode]::Create)
[byte[]]$ReadBuffer = New-Object byte[] 1024

# Loop through the download
do {
$ReadLength = $ResponseStream.Read($ReadBuffer,0,1024)
$LocalFileFile.Write($ReadBuffer,0,$ReadLength)
}
while ($ReadLength -ne 0)