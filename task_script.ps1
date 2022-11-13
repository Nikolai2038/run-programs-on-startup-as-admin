#!/usr/bin/env pwsh

# Путь к папке со скриптом
param([string]$scriptFolder = "")
# Чтобы скрипт можно было запускать вручную
if (!($scriptFolder)) {
    $scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
}
# Путь к папке с ярлыками
$pathToExecutables = "$scriptFolder/executables"

# Проверяет, заблокирован ли файл каким-либо процессом
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

# Для каждого файла в папке с ярлыками
$files = (Get-ChildItem "$pathToExecutables")
foreach ($filePath in $files) {
    # Рассматриваем только ярлыки
    if ($filePath -match "^(.*).lnk$") {
        $fileName = ($filePath | ForEach-Object { $_.Name })
        $fileFullPath = "$pathToExecutables/$fileName"
        # Путь к exe-файлу
        $exePath = (New-Object -ComObject WScript.Shell).CreateShortcut("$filePath").TargetPath
        Write-Host "$exePath"
        if ((Test-Path -Path "$exePath") -eq $false) {
            Write-Error "Файл `"$exePath`" не существует!"
        } else {
            if (isLockedBySomeProcesses("$exePath")) {
                Write-Warning "Процесс `"$exePath`" уже запущен!"
            } else {
                Start-Process -FilePath "$fileFullPath" -Verb RunAs -WindowStyle Minimized
            }
        }
    }
}
