title Easy Backup Tool v2.0
@echo off

REM Script de migracion de equipos Windows
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

echo                ****** Easy Backup Tool ****** 
ECHO                             V 2.0
echo.
echo.
echo.

echo		Script para migracion de perfiles y configuraciones
echo.
echo.
echo.

echo		Relizado por:
echo.
echo.
echo.
		
echo		vrodasjj
echo.
echo.
echo.
echo.
echo.
echo.
		
pause		
cls
@echo off

echo BACKUP INICIAL
echo.
echo.
echo !!!! AVISO!!!!!!!! 
echo Antes de continuar
echo Asegurese de estar logado con el usuario a copiar.
echo.
echo.
echo.

pause

:seleccion


:: Verificacion de usuario


Set /P verif=Se encuentra logado con el usuario correcto. 1=Si 2=No 
If "%verif%"=="1" (
					goto Backup
					) else goto verificacion


:verificacion
cls
echo VD. ha indicado no estar logado en el perfil a migrar, o ha pulsado una opcion incorrecta.
echo Por favor, pulse cualquier tecla para volver a elegir y seleccione la opcion correcta.
pause>nul
cls
Set /p verif=Se encuentra logado con el usuario correcto. 1=Si, Otra tecla=Salir
If "%verif%"=="1" (goto seleccion) else goto salida
		     

:Backup 
cls

::Informacion al usuario
echo.
echo.
echo.
echo.
echo.
echo Este programa copiara a continuacion las carpetas del perfil del usuario actual.
echo Si necesita copiar carpetas de otra ubicacion se le solicitara mas adelante. 
echo Asegurese de tenerlas todas en la misma ubicacion.
echo Presione una tecla cuando esté listo para copiar el perfil.
echo.
echo.
pause>nul
set/p Rutabackup=Introduzca la ruta donde desee realizar el backup:	 
echo.
echo.
echo.
echo.
echo Va a iniciarse la copia de archivos del perfil.
echo.
echo.
echo.
pause
cls
echo.
md "%RutaBackup%\Logs"
xcopy "%userprofile%\*.*" %RutaBackup%\ /i /s /e /k /z /r /c /y>"%RutaBackup%\Logs\CopiaPerfil.log"

echo Va a iniciarse la copia de archivos de correo.
echo.
echo.

:: Copia de perfiles y cuentas de correo

reg export "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles" "%RutaBackup%\profileOutlook.reg">"%RutaBackup%\Logs\CopiaPerfilesOutlook.log"

xcopy "c:\documents and settings\%username%\aplication data\Microsoft\Signatures\*.*" "%RutaBackup%\backup_outlook\signatures\" /i /s /e /k /z /r /c/y>"%RutaBackup%\Logs\CopiaFirmaOutlook.log"

xcopy "c:\documents and settings\%username%\aplication data\Microsoft\Outlook\*.nk2" "%RutaBackup%\backup_outlook\" /i /s /e /k /z /r /c/y>"%RutaBackup%\Logs\CopiaNK2.log"

xcopy "c:\documents and settings\%username%\Local Settings\Application Data\Microsoft\Outlook\*.pst" "%RutaBackup%\backup_outlook\" /i /s /e /k /z /r /c/y>"%RutaBackup%\Logs\CopiaPST.log"

cls
echo La operacion de copia se ha realizado, revise los archivos de Log,en "carpeta de destino del backup\logs" para ver posibles errores.
echo.
echo.
echo Se va a proceder a copiar el resto de configuraciones.
echo.
echo.
echo.
echo.
echo.

cls
REM //Printers

reg export HKLM\System\CurrentControlSet\Control\Print\Printers "%RutaBackup%\printers.reg">"%RutaBackup%\Logs\exportPrinter.log"

REM //NET DRIVES

reg export HKCU\Network "%RutaBackup%\networkdrives.reg">"%RutaBackup%\Logs\ExportNetworkDrives.log"

REM //ODBC USER

reg export HKCU\Software\ODBC "%RutaBackup%\ODBCUSER.reg">"%RutaBackup%\Logs\ExportODBCUser.log"

REM //ODBC System

reg export HKLM\Software\ODBC "%RutaBackup%\ODBCSYSTEM.reg">"%RutaBackup%\Logs\ExportODCSystem.log"

REM //Computer Name

reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName "%RutaBackup%\computername.reg">"%RutaBackup%\Logs\CopiaPST.log"

echo La operacion de copia se ha realizado, revise los archivos de Log,en "carpeta de destino del backup\logs" para ver posibles errores.
echo.
echo.
echo.

pause

cls

echo.
echo.
echo.
echo.
echo.

echo Si lo desea puede añadir mas carpetas al backup.
echo.
echo.



set/p extrabckp=¿Desea añadir mas carpetas? 1=Si 0=Salir 

If "%extrabckp%"=="1" (goto extrabackup) else goto salida
      


echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
::copia de carpetas extra
:extrabackup


set/p RutabackupExtra=Introduzca la ruta de la carpeta que desee realizar el backup:
xcopy "%RutabackupExtra%\*.*" %RutaBackup%\ /i /s /e /k /z /r /c /y>>"%RutaBackup%\Logs\CopiaExtra.log"


:verificacion2
cls
echo VD. ha indicado una opcion no valida.
set/p verifextra=Por favor, pulse 1 para volver a elegir y seleccione la opcion correcta o pulse 0 para salir del programa.
If "%verifextra%"=="1" goto extrabackup
else if "verifextra"=="0" goto salida   


cls


:salida
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo	    	     Esta herramienta es de uso libre y gratuito.
echo           Su distribucion, no esta permitida con fines lucrativos.
echo Esta permitida la distribucion y modificacion del codigo de esta aplicacion,
echo                   añadiendo mencion a el autor original.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo               Codigo y compilacion realizada por: Vrodasjj
echo.
echo.
echo.
echo.
pause


exit

















