#!/usr/bin/env pwsh

$taskName = "RunProgramsOnStartup"

# Создаём расписание запуска
$trigger = New-JobTrigger -AtLogOn

# Просим пользователя авторизоваться (для доступа к Планировщику Заданий)
$credential = Get-Credential

# В качестве опции указываем запуск задания с повышенными привилегиями
$option = New-ScheduledJobOption -RunElevated -WakeToRun

# Переменную будем передавать в сам скрипт
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path

# Снимаем регистрацию с задания, если оно уже существует
($is_job_already_created = Get-ScheduledJob -Name "$taskName") 2> $null;
if ($is_job_already_created) {
    Unregister-ScheduledJob -Name "$taskName" | Sleep 3
}

# Регистрируем само задание
Register-ScheduledJob `
    -Name "$taskName" `
    -Trigger $trigger `
    -Credential $credential `
    -ScheduledJobOption $option `
    -FilePath "${scriptFolder}/task_script.ps1" `
    -ArgumentList @("${scriptFolder}")
    