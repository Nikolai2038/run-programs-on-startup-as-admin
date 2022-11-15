#!/usr/bin/env pwsh

$taskName = "RunProgramsOnStartup"

# Creating a launch schedule
$trigger = New-ScheduledTaskTrigger -AtLogOn

# We will pass this variable to the script itself
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden & '${scriptFolder}/task_script.ps1' '${scriptFolder}'"

# We remove registration of the task if it already exists
($is_job_already_created = Get-ScheduledTask -TaskName "$taskName") 2> $null;
if ($is_job_already_created) {
    Unregister-ScheduledTask -TaskName "$taskName" | Start-Sleep 3
}

# Registration of the task
Register-ScheduledTask -TaskName "$taskName" -Trigger $trigger -Action $action