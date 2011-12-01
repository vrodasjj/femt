echo @off

REM // Outloook

reg export "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles" c:\profilesOutlook.reg


REM //Printers

reg export HKLM\System\CurrentControlSet\Control\Print\Printers c:\printers.reg

REM //NET DRIVES

reg export HKCU\Network c:\networkdrives.reg

REM //ODBC USER

reg export HKCU\Software\ODBC c:\ODBCUSER.reg

REM //ODBC System

reg export HKLM\Software\ODBC c:\ODBCSYSTEM.reg


echo @on