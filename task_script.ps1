#!/usr/bin/env pwsh

# Path to the script folder
param([string]$scriptFolder = "")
# So that the script can be run manually
if (!($scriptFolder)) {
    $scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
}
# Path to the folder with shortcuts
$pathToLinks = "$scriptFolder/links"

# Checks if the file is locked by any process
function isLockedBySomeProcesses ($fileName) {
    Get-Process | ForEach-Object {
        $_.Modules | ForEach-Object {
            if ($_.FileName -eq $exePath) {
                return 1
            }
        }
    }
    return 0
}

# For each file in the folder with shortcuts
$files = (Get-ChildItem "$pathToLinks")
foreach ($filePath in $files) {
    # Consider only labels
    if ($filePath -match "^(.*).lnk$") {
        $fileName = ($filePath | ForEach-Object { $_.Name })
        $fileFullPath = "$pathToLinks/$fileName"
        # Path to the exe file
        $exePath = (New-Object -ComObject WScript.Shell).CreateShortcut("$fileFullPath").TargetPath
        if ((Test-Path -Path "$exePath") -eq $false) {
            Write-Error "The file `"$exePath`" does not exist!"
        } else {
            if (isLockedBySomeProcesses("$exePath")) {
                Write-Warning "The `"$exePath`" process is already running!"
            } else {
                Start-Process -FilePath "$fileFullPath" -Verb RunAs -WindowStyle Minimized
                Write-Host "The process `"$exePath`" has started!"
            }
        }
    }
}
