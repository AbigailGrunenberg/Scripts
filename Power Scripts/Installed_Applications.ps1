#script to find all installed applications on computer
#Get-InstalledApps retreived from: https://serverfault.com/questions/1111419/how-to-get-a-complete-list-of-all-installed-software-via-powershell
#edited slightly from original

function Get-InstalledApps {
    param (
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$ComputerName = $env:COMPUTERNAME,
        [string]$NameRegex = ''
    )
    
    foreach ($comp in $ComputerName) {
        $keys = '','\Wow6432Node'
        foreach ($key in $keys) {
            try {
                $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $comp)
                $apps = $reg.OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall").GetSubKeyNames()
            } catch {
                continue
            }

            foreach ($app in $apps) {
                $program = $reg.OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall\$app")
                $name = $program.GetValue('DisplayName')
                if ($name -and $name -match $NameRegex) {
                    [pscustomobject]@{
                        DisplayName = $name
                        DisplayVersion = $program.GetValue('DisplayVersion')
                        UninstallString = $program.GetValue('UninstallString')
                        Path = $program.name
                    }
                }
            }
        }
    }
}

#name of app
$AppName = "Example"

#get names of installed apps as strings
$InstalledApps = Get-InstalledApps | select DisplayName | Out-String

#returns true if the application is already installed, false otherwise
function Installed? {
    if ($InstalledApps.Contains($AppName)) {
        msg console /server:localhost "App already installed on device, cancelling installation."
        $true
        exit
    }
    else {
        msg console / server:localhost "App not installed on device."
        $false
        continue
    }
    
}