@echo off
mode con cols=120 lines=40
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
:Menu
Cls
@ echo.
@ echo.　　           【菜单选项】
@ echo.
@ echo.             强删所有相关服务 → 请输入1
@ echo.
@ echo.             卸载所有相关服务 → 请输入2
@ echo.
@ echo.             退出 → 请输入0
@ echo.
@ echo.             警告：该操作危险，慎重选择！
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto DeleteAll
if /i "%export%"=="2" Goto UnInstallAll
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto Menu
:DeleteAll
@ echo.
@ echo.             删除apache24
sc delete apache2
ping -n 2 127.1>nul
@ echo.             删除httpd
sc delete httpd
ping -n 2 127.1>nul
@ echo.             删除mysql103
sc delete mysql103
ping -n 2 127.1>nul
@ echo.             删除mysql102
sc delete mysql102
ping -n 2 127.1>nul
@ echo.             删除mysql101
sc delete mysql101
ping -n 2 127.1>nul
@ echo.             删除mysql100
sc delete mysql100
ping -n 2 127.1>nul
@ echo.             删除mariadb103
sc delete mariadb103
ping -n 2 127.1>nul
@ echo.             删除mariadb102
sc delete mariadb102
ping -n 2 127.1>nul
@ echo.             删除mariadb101
sc delete mariadb101
ping -n 2 127.1>nul
@ echo.             删除mariadb100
sc delete mariadb100
ping -n 2 127.1>nul
@ echo.
@ echo              强制删除所有相关服务完毕，如果删除了不该删除的，请见谅！请反馈！
echo                按任意键退出...
pause>nul
exit
:UnInstallAll
@ echo.
@ echo              卸载apache24
@ c:
@ cd c:\wamp\64\apache24\bin\
@ httpd.exe -k uninstall -n apache24
ping -n 2 127.1>nul
@ echo.
@ echo              卸载httpd
cd c:\wamp\32\apache24\bin\
httpd.exe -k uninstall -n httpd
ping -n 2 127.1>nul
@ echo.
@ echo              将mysql103从系统服务里卸载...
@ cd c:\wamp\64\mariadb103\bin\
@ mysqld.exe remove mysql103
ping -n 2 127.1>nul
@ echo.
@ echo              将mysql102从系统服务里卸载...
@ cd c:\wamp\64\mariadb102\bin\
@ mysqld.exe remove mysql102
ping -n 2 127.1>nul
@ echo.
@ echo              将mysql101从系统服务里卸载...
@ cd c:\wamp\64\mariadb101\bin\
@ mysqld.exe remove mysql101
ping -n 2 127.1>nul
@ echo.
@ echo              将mysql100从系统服务里卸载...
@ cd c:\wamp\64\mariadb100\bin\
@ mysqld.exe remove mysql100
ping -n 2 127.1>nul
@ echo.
@ echo              将mariadb103从系统服务里卸载...
@ cd c:\wamp\32\mariadb103\bin\
@ mysqld.exe remove mariadb103
ping -n 2 127.1>nul
@ echo.
@ echo              将mariadb102从系统服务里卸载...
@ cd c:\wamp\32\mariadb102\bin\
@ mysqld.exe remove mariadb102
ping -n 2 127.1>nul
@ echo.
@ echo              将mariadb101从系统服务里卸载...
@ cd c:\wamp\32\mariadb101\bin\
@ mysqld.exe remove mariadb101
ping -n 2 127.1>nul
@ echo.
@ echo              将mariadb100从系统服务里卸载...
@ cd c:\wamp\32\mariadb100\bin\
@ mysqld.exe remove mariadb100
ping -n 2 127.1>nul
@ echo.
@ echo              卸载了所有相关服务，如果删除了不该删除的，请见谅！请反馈！
echo                按任意键退出...
pause>nul
exit