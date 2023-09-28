# Run programs on Windows Startup as Administrator

**EN** | [RU](README_RU.md)

## Description

This script allows you to create an application startup that will run as an administrator when a user logs into Windows (because startup in Windows itself does not allow you to run applications as an administrator).

This is achieved by creating an appropriate scheduled task.

## Requirements

- Windows 10/11;
- PowerShell.

You also need to enable the ability to execute scripts `*.ps1`, if not already enabled:

1. Run `PowerShell` **as administrator**;
2. Execute:

    ```powershell
    Set-ExecutionPolicy Unrestricted
    ```

## Usage

1. Run `PowerShell`;
2. Clone the repository:

    ```powershell
    git clone https://github.com/Nikolai2038/bash-webp-to-gif.git
    ```

3. Reopen `PowerShell` **as administrator**;
4. Execute the script for creating a scheduled task:

    ```powershell
    & "<path to the cloned repository>/task_create.ps1"
    ```

    Enter (if necessary):

    ```powershell
    R
    ```

The created scheduled task can be viewed in the `Windows Task Manager` and changed manually if required. The name of the task being created: `RunProgramsOnStartup`. Calling the `task_create.ps1` script again will recreate the task.

The task itself calls the script `task_script.ps1`, which, in turn, runs all shortcuts of programs located in the folder `<path to the cloned repository>/links` in a loop.

At the moment, the script works with shortcuts, not executable files. If there are no shortcuts, then nothing will happen.

## Contribution

Feel free to contribute via [pull requests](https://github.com/Nikolai2038/run-programs-on-startup-as-admin/pulls) or [issues](https://github.com/Nikolai2038/run-programs-on-startup-as-admin/issues)!
