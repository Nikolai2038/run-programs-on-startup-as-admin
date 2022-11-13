#!/usr/bin/env pwsh

param(
    [string]$scriptFolder = ""
)
# Чтобы скрипт можно было запускать вручную
if (!($scriptFolder)) {
    $scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
}
$pathToExecutables = "$scriptFolder/executables"

$files = @(Get-ChildItem "$pathToExecutables")
foreach ($file in $files) {
    if ($file -match "(.*).lnk") {
        $fileName = ($file | %{$_.Name})
        $fileFullPath = "$pathToExecutables/$fileName"
        Start-Process -FilePath "$fileFullPath" -Verb RunAs
    }
}