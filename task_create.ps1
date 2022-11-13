#!/usr/bin/env pwsh

$taskName = "RunProgramsOnStartup"

# Создаём расписание запуска
$trigger = New-ScheduledTaskTrigger -AtLogOn

# Переменную будем передавать в сам скрипт
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path

$action = New-ScheduledTaskAction -Execute "powershell" -Argument "& '${scriptFolder}/task_script.ps1' '${scriptFolder}'"

# Снимаем регистрацию с задания, если оно уже существует
($is_job_already_created = Get-ScheduledTask -TaskName "$taskName") 2> $null;
if ($is_job_already_created) {
    Unregister-ScheduledTask -TaskName "$taskName" | Sleep 3
}

# Регистрация
Register-ScheduledTask -TaskName "$taskName" -Trigger $trigger -Action $action