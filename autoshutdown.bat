@echo off
title Autoshutdown

:inputlabel :: label
    :: Prompt the user to enter the shutdown time in hours (0-9) or -1 to cancel
    set /p HOURS=Enter the hours (0-9) or -1 to cancel the previous scheduling [Press Enter for 0]:

    :: Check if the entered hours are empty, if so, set to 0
    if "%HOURS%"=="" set HOURS=0

    :: Debugging information
    echo Hours entered: %HOURS%

    :: Check if the entered hours are less than -1, if so, prompt again
    if %HOURS% LSS -1 (
        echo Invalid selection. Re-entry required:
        goto inputlabel
    )

    :: Check if the entered hours are greater than 9, if so, prompt again
    if %HOURS% GTR 9 (
        echo Invalid selection. Re-entry required:
        goto inputlabel
    )

    :: If the user enters -1, cancel the shutdown command
    if %HOURS% EQU -1 (
        shutdown /a
        if %errorlevel% NEQ 0 (
            echo No previous shutdown scheduled.
        ) else (
            echo Previous scheduling canceled.
        )
        goto endlabel
    )

    :: Prompt the user to enter the shutdown time in minutes (0-60)
    set /p MINUTES=Enter the minutes (0-60) [Press Enter for 0]:

    :: Check if the entered minutes are empty, if so, set to 0
    if "%MINUTES%"=="" set MINUTES=0

    :: Debugging information
    echo Minutes entered: %MINUTES%

    :: Check if the entered minutes are less than 0, if so, prompt again
    if %MINUTES% LSS 0 (
        echo Invalid selection. Re-entry required:
        goto inputlabel
    )

    :: Check if the entered minutes are greater than 60, if so, prompt again
    if %MINUTES% GTR 60 (
        echo Invalid selection. Re-entry required:
        goto inputlabel
    )

    :: Convert the entered time from hours and minutes to seconds
    set /a SECONDS=(%HOURS%*3600) + (%MINUTES%*60)

    :: Execute the shutdown command with the calculated time in seconds
    shutdown /s /f /t %SECONDS%

    :: Display a message indicating the automatic shutdown time
    echo Automatic shutdown after %HOURS% hours and %MINUTES% minutes

:endlabel
    :: Pause the script to keep the command prompt window open
    PAUSE
