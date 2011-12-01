title Easy Restore Tool v2.0
@echo off

REM Script de restauracion de datos para equipos Windows
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

echo                ****** Easy Restore Tool ****** 
ECHO                             V 1.0
echo.
echo.
echo.

echo		Script de restauracion de datos y configuraciones
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

echo Restauracion de archivos
echo.
echo.
echo !!!! AVISO!!!!!!!! 
echo Antes de continuar
echo Asegurese de estar logado con el usuario a copiar.
echo.
echo.
echo.

pause




:: Verificacion de usuario


Set /P verif=Se encuentra logado con el usuario correcto. 1=Si 2=No 
If "%verif%"=="1" (
					goto restore
					
					) else goto verificacion

cls
:verificacion
cls
echo VD. ha indicado no estar logado en el perfil a restaurar, o ha pulsado una opcion incorrecta.
echo Por favor, pulse cualquier tecla para volver a elegir y seleccione la opcion correcta.
pause>nul
cls
Set /p verif=Se encuentra logado con el usuario correcto. 1=Si, Otra tecla=Salir
If "%verif%"=="1" (
					goto restore
					) else goto salida


cls
:restore

::Informacion al usuario
echo.
echo.
echo.
echo.
echo.
echo Este programa restaurara a continuacion las carpetas del perfil del usuario actual.
echo Si necesita restaurar carpetas de otra ubicacion se le solicitara mas adelante. 

echo Presione una tecla cuando esté listo para copiar el perfil.
echo.
echo.
pause>nul
set/p Rutarestore=Introduzca la ruta donde se encuentre el backup:	 
echo.
echo.
echo.
echo.
echo Va a iniciarse la restauracion de archivos del perfil.
echo.
echo.
echo.
pause
cls
echo.
md "%Rutarestore%\Logs"
xcopy %Rutarestore%\ "%userprofile%\*.*"  /i /s /e /k /z /r /c /y>"%Rutarestore%\Logs\restorePerfil.log"


echo Va a iniciarse la restauracion de archivos de correo.
echo.
echo.
pause
:: restauracion de perfiles y cuentas de correo

reg import "%Rutarestore%\profileOutlook.reg">"%Rutarestore%\Logs\RestorePerfilesOutlook.log"

xcopy "%Rutarestore%\backup_outlook\signatures\*.*" "c:\documents and settings\%username%\aplication data\Microsoft\Signatures\"  /i /s /e /k /z /r /c/y>"%Rutarestore%\Logs\RestoreFirmaOutlook.log"

xcopy "%Rutarestore%\backup_outlook\*.nk2" "c:\documents and settings\%username%\aplication data\Microsoft\Outlook\" /i /s /e /k /z /r /c/y>"%Rutarestore%\Logs\RestoreNK2.log"

xcopy "%Rutarestore%\backup_outlook\*.pst" "c:\documents and settings\%username%\Local Settings\Application Data\Microsoft\Outlook\" /i /s /e /k /z /r /c/y>"%Rutarestore%\Logs\RestorePST.log"

cls
echo La operacion de copia se ha realizado, revise los archivos de Log,en "carpeta del backup de origen\logs" para ver posibles errores.
echo.
echo.
echo Se va a proceder a copiar el resto de configuraciones.
echo.
echo.
echo.
echo.
echo.
pause
cls
REM //Printers

reg import "%Rutarestore%\printers.reg">"%Rutarestore%\Logs\ImportPrinter.log"

REM //NET DRIVES

reg import "%Rutarestore%\networkdrives.reg">"%Rutarestore%\Logs\ImportNetworkDrives.log"

REM //ODBC USER

reg import "%Rutarestore%\ODBCUSER.reg">"%Rutarestore%\Logs\ImportODBCUser.log"

REM //ODBC System

reg import "%Rutarestore%\ODBCSYSTEM.reg">"%Rutarestore%\Logs\ImportODCSystem.log"

REM //Computer Name

::reg import "%Rutarestore%\ComputerName "%Rutarestore%\computername.reg">"%Rutarestore%\Logs\ImportComputerName.log"

echo La operacion de restauracion se ha realizado, revise los archivos de Log,en "carpeta de origen del backup\logs" para ver posibles errores.
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

echo Si lo desea puede añadir mas carpetas a la restauracion.
echo.
echo.



set/p extrarest=¿Desea añadir mas carpetas? 1=Si 0=Salir 

If "%extrarest%"=="1" (goto extrabackup) else goto salida
      


echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
::copia de carpetas extra
:extrarest


set/p RutabackupExtra=Introduzca la ruta de la carpeta que desee realizar la restauracion:      
set/p RutaDestino=Introduzca la ruta de destino:    
xcopy "%RutarestoreExtra%\*.*" %RutaDestino%\ /i /s /e /k /z /r /c /y>>"%Rutarestore%\Logs\RestoreExtra.log"


:verifextra
cls
echo VD. ha indicado una opcion no valida.
set/p verifextra=Por favor, pulse 1 para volver a elegir y seleccione la opcion correcta o cualquier otra tecla para salir.
If "%verifextra%"=="1" (goto extrarest) else goto salida   


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




		     