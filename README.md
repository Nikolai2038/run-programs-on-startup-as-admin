**EN** | [RU](README_ru.md)

This script allows you to create an application startup that will run as an administrator when a user logs into Windows (because startup in Windows itself does not allow you to run applications as an administrator).

This is achieved by creating an appropriate scheduled task. To create it, you need to run `PowerShell` **as administrator**, and execute:
```powershell
& "<path to the cloned repository>/task_create.ps1"
```
Enter:
```powershell
Y
```

The created scheduled task can be viewed in the `Windows Task Manager` and changed manually if required. The name of the task being created: `RunProgramsOnStartup`. Calling the `task_create.ps1` script again will recreate the task.

The task itself calls the script `task_script.ps1`, which, in turn, runs all shortcuts of programs located in the folder `<path to the cloned repository>/links` in a loop. At the moment, the script works with shortcuts, not executable files. If there are no shortcuts, then nothing will happen.

Feel free to contribute!
