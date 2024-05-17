# script to download files from FTP server

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
$LocalLocation = "C:\Temp\file.zip"
$RemoteLocation = "ftp://thomasmaurer.ch/downloads/files/file.zip"
Get-FTPFile $Username $Password $LocalLocation $RemoteLocation

