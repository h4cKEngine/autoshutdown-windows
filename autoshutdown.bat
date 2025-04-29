@echo off
title Autoshutdown

:inputlabel :: label
	:: Prompt the user to enter the shutdown time in hours (0-9) or -1 to cancel
	set /p HOURS=Inserisci prima le ore (0-9) o -1 per annullare la precedente schedulazione [Premi Invio per 0]: 

	:: Check if the entered hours are empty, if so, set to 0
	if "%HOURS%"=="" set HOURS=0

	:: Debugging information
	echo Ore inserite: %HOURS%

	:: Check if the entered hours are less than -1, if so, prompt again
	if %HOURS% LSS -1 (
		echo Selezione non valida. Reinserimento necessario:
		goto inputlabel
	)
	
	:: Check if the entered hours are greater than 9, if so, prompt again
	if %HOURS% GTR 9 (
		echo Selezione non valida. Reinserimento necessario:
		goto inputlabel
	)

	:: If the user enters -1, cancel the shutdown command
	if %HOURS% EQU -1 (
		shutdown /a
		if %errorlevel% NEQ 0 (
			echo "Nessuna schedulazione di spegnimento eseguita in precedenza."
		) else (
			echo "Schedulazione precedente annullata."
		)
		goto endlabel
	)

	:: Prompt the user to enter the shutdown time in minutes (0-60)
	set /p MINUTES=Inserisci i minuti (0-60) [Premi Invio per 0]: 

	:: Check if the entered minutes are empty, if so, set to 0
	if "%MINUTES%"=="" set MINUTES=0

	:: Debugging information
	echo Minuti inseriti: %MINUTES%

	:: Check if the entered minutes are less than 0, if so, prompt again
	if %MINUTES% LSS 0 (
		echo Selezione non valida. Reinserimento necessario:
		goto inputlabel
	)
	
	:: Check if the entered minutes are greater than 60, if so, prompt again
	if %MINUTES% GTR 60 (
		echo Selezione non valida. Reinserimento necessario:
		goto inputlabel
	)

	:: Convert the entered time from hours and minutes to seconds
	set /a SECONDS=(%HOURS%*3600) + (%MINUTES%*60)

	:: Execute the shutdown command with the calculated time in seconds
	shutdown /s /f /t %SECONDS%
	
	:: Display a message indicating the automatic shutdown time
	echo "Spegnimento automatico dopo %HOURS% ore e %MINUTES% minuti"

:endlabel
	:: Pause the script to keep the command prompt window open
	PAUSE
