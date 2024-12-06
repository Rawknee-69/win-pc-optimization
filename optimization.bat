@echo off
cls
echo ========================================
echo Welcome to the System Optimization Tool
echo ========================================
echo 1. Revert to Previous Settings (Recovery)
echo 2. Run Basic Optimization (Disable Startup Apps, Services, Clear Temp, Defrag)
echo 3. Run Advanced Optimization (Disable More Services, Clear Temp, Defrag)
echo ========================================
set /p option="Please choose an option (1, 2, or 3): "

if "%option%"=="1" (
    call :recovery
) else if "%option%"=="2" (
    call :basic_optimization
) else if "%option%"=="3" (
    call :advanced_optimization
) else (
    echo Invalid option. Please choose 1, 2, or 3.
    pause
    exit /b
)

:recovery
cls
echo Reverting Changes...
echo Please run this batch file with administrator privileges.


set "recovery_folder=%cd%\recovery"
if not exist "%recovery_folder%" (
    echo Recovery folder not found. Ensure you have run the original script first.
    pause
    exit /b
)


echo Reverting startup apps...
REG IMPORT "%recovery_folder%\startup_backup.reg"
REG IMPORT "%recovery_folder%\startup_once_backup.reg"
echo Startup apps reverted.

echo Reverting service states...
for /f "tokens=*" %%a in ('type "%recovery_folder%\fax_service_backup.txt"') do sc config "Fax" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\xblgamesave_service_backup.txt"') do sc config "XblGameSave" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\wuauserv_service_backup.txt"') do sc config "wuauserv" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\bluetoothsupport_service_backup.txt"') do sc config "BluetoothSupportService" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\printspooler_service_backup.txt"') do sc config "Print Spooler" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\securitycenter_service_backup.txt"') do sc config "SecurityCenter" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\windows_defender_service_backup.txt"') do sc config "Windows Defender Antivirus Service" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\sysmain_service_backup.txt"') do sc config "SysMain" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\diagtrack_service_backup.txt"') do sc config "DiagTrack" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\wdservicehost_service_backup.txt"') do sc config "WdiServiceHost" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\wdissystemhost_service_backup.txt"') do sc config "WdiSystemHost" %%a
for /f "tokens=*" %%a in ('type "%recovery_folder%\usersvc_service_backup.txt"') do sc config "UserSvc" %%a
echo Services reverted.

echo All changes have been reverted to their previous states.
pause
exit /b

:basic_optimization
cls
echo Running Basic Optimization...
echo Please run this batch file with administrator privileges.


echo Creating a recovery folder and saving current settings...
set "recovery_folder=%cd%\recovery"
if not exist "%recovery_folder%" mkdir "%recovery_folder%"


REG EXPORT "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" "%recovery_folder%\startup_backup.reg"
REG EXPORT "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" "%recovery_folder%\startup_once_backup.reg"

:: Backup service states
sc qc "Fax" > "%recovery_folder%\fax_service_backup.txt"
sc qc "XblGameSave" > "%recovery_folder%\xblgamesave_service_backup.txt"
sc qc "wuauserv" > "%recovery_folder%\wuauserv_service_backup.txt"
sc qc "BluetoothSupportService" > "%recovery_folder%\bluetoothsupport_service_backup.txt"
sc qc "Print Spooler" > "%recovery_folder%\printspooler_service_backup.txt"
sc qc "SecurityCenter" > "%recovery_folder%\securitycenter_service_backup.txt"
sc qc "Windows Defender Antivirus Service" > "%recovery_folder%\windows_defender_service_backup.txt"
sc qc "SysMain" > "%recovery_folder%\sysmain_service_backup.txt"
sc qc "DiagTrack" > "%recovery_folder%\diagtrack_service_backup.txt"
sc qc "WdiServiceHost" > "%recovery_folder%\wdservicehost_service_backup.txt"
sc qc "WdiSystemHost" > "%recovery_folder%\wdissystemhost_service_backup.txt"
sc qc "UserSvc" > "%recovery_folder%\usersvc_service_backup.txt"
echo Current startup apps and services saved.

echo Disabling unnecessary services...
sc config "Fax" start= disabled
sc config "XblGameSave" start= disabled
sc config "wuauserv" start= disabled
sc config "Print Spooler" start= disabled
sc config "SecurityCenter" start= disabled
sc config "DiagTrack" start= disabled
echo Unnecessary services have been disabled.

echo Clearing temp folders...
del /q /f /s %TEMP%\* > nul
del /q /f /s C:\Windows\Temp\* > nul
echo Temp folders cleared.


echo Running defragmentation on C: drive...
defrag C: /O
echo Defragmentation completed.

echo Basic optimization completed. A recovery file has been created in the current folder.
echo Please restart your computer for changes to take effect.
pause
exit /b


:advanced_optimization
cls
echo Running Advanced Optimization...
echo Please run this batch file with administrator privileges.


echo Creating a recovery folder and saving current settings...
set "recovery_folder=%cd%\recovery"
if not exist "%recovery_folder%" mkdir "%recovery_folder%"

REG EXPORT "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" "%recovery_folder%\startup_backup.reg"
REG EXPORT "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" "%recovery_folder%\startup_once_backup.reg"


sc qc "Fax" > "%recovery_folder%\fax_service_backup.txt"
sc qc "XblGameSave" > "%recovery_folder%\xblgamesave_service_backup.txt"
sc qc "wuauserv" > "%recovery_folder%\wuauserv_service_backup.txt"
sc qc "BluetoothSupportService" > "%recovery_folder%\bluetoothsupport_service_backup.txt"
sc qc "Print Spooler" > "%recovery_folder%\printspooler_service_backup.txt"
sc qc "SecurityCenter" > "%recovery_folder%\securitycenter_service_backup.txt"
sc qc "Windows Defender Antivirus Service" > "%recovery_folder%\windows_defender_service_backup.txt"
sc qc "SysMain" > "%recovery_folder%\sysmain_service_backup.txt"
sc qc "DiagTrack" > "%recovery_folder%\diagtrack_service_backup.txt"
sc qc "WdiServiceHost" > "%recovery_folder%\wdservicehost_service_backup.txt"
sc qc "WdiSystemHost" > "%recovery_folder%\wdissystemhost_service_backup.txt"
sc qc "UserSvc" > "%recovery_folder%\usersvc_service_backup.txt"
echo Current startup apps and services saved.

echo Disabling more unnecessary services...
sc config "Fax" start= disabled
sc config "XblGameSave" start= disabled
sc config "wuauserv" start= disabled
sc config "Print Spooler" start= disabled
sc config "SecurityCenter" start= disabled
sc config "WdiServiceHost" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "RemoteRegistry" start= disabled
sc config "Spooler" start= disabled
sc config "Themes" start= disabled
echo More services disabled.

echo Clearing temp folders...
del /q /f /s %TEMP%\* > nul
del /q /f /s C:\Windows\Temp\* > nul
echo Temp folders cleared.


echo Running defragmentation on C: drive...
defrag C: /O
echo Defragmentation completed.


echo Advanced optimization completed. A recovery file has been created in the current folder.
echo Please restart your computer for changes to take effect.
pause
exit /b
