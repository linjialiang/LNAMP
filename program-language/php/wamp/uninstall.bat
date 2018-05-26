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
@ echo.             卸载 → 请输入1
@ echo.
@ echo.             极速 → 请输入2
@ echo.
@ echo.             退出 → 请输入0
@ echo.
@ echo.             提示：建议大家只选择一种位数卸载，如果是64位可直接选择极速卸载！
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto UnInstall
if /i "%export%"=="2" Goto SpeedUnInstall
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto Menu
:UnInstall
Goto SelectDigit
:SelectDigit
Cls
@ echo.
@ echo.              【位数选项】
@ echo.
@ echo.             64位 → 请输入1
@ echo.
@ echo.             32位 → 请输入2
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" set Digit=64
if /i "%export%"=="1" set ApacheName=apache24
if /i "%export%"=="1" set MySQLName=mysql
if /i "%export%"=="1" Goto SlecteApache24
if /i "%export%"=="2" set Digit=32
if /i "%export%"=="2" set ApacheName=httpd
if /i "%export%"=="2" set MySQLName=mariadb
if /i "%export%"=="2" Goto SlecteApache24
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SelectDigit
:SlecteApache24
Cls
@ echo.
@ echo.　　　      【是否卸载 apache24】
@ echo.
@ echo.             继续卸载 → 请输入1
@ echo.
@ echo.             跳过卸载 → 请输入2
@ echo.
@ echo.             重新选择位数 → 请输入3
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto ReturnApache24
if /i "%export%"=="2" Goto SlecteMySQLVersions
if /i "%export%"=="3" Goto SelectDigit
if /i "%export%"=="0" exit
@ echo.
echo                选择无效，请重新输入
ping -n 2 127.1>nul
Goto SlecteApache24
:SlecteMySQLVersions
Cls
@ echo.
@ echo.　　　　       【选择 mariadb 版本】
@ echo.
@ echo.             mariadb 10.2 → 请输入1
@ echo.
@ echo.             mariadb 10.1 → 请输入2
@ echo.
@ echo.             mariadb 10.0 → 请输入3
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" SET MySQLVersion=102
if /i "%export%"=="1" Goto SlecteMySQL
if /i "%export%"=="2" SET MySQLVersion=101
if /i "%export%"=="2" Goto SlecteMySQL
if /i "%export%"=="3" SET MySQLVersion=100
if /i "%export%"=="3" Goto SlecteMySQL
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SlecteMySQLVersions
:SlecteMySQL
Cls
@ echo.
@ echo.　　　      【是否卸载 mariadb】
@ echo.
@ echo.             继续卸载 → 请输入1
@ echo.
@ echo.             取消卸载 → 请输入2
@ echo.
@ echo.             重选mariadb版本 → 请输入3
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto ReturnMySQL
if /i "%export%"=="2" exit
if /i "%export%"=="3" Goto SlecteMySQLVersions
if /i "%export%"=="0" exit
@ echo.
echo                选择无效，请重新输入
ping -n 2 127.1>nul
Goto SlecteMySQL
:ReturnApache24
Cls
@ echo.
@ echo              将%ApacheName%从系统服务里卸载...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k uninstall -n %ApacheName%
@ echo.
@ echo              %ApacheName%卸载成功！
ping -n 2 127.1>nul
Goto SlecteMySQL
:ReturnMySQL
Cls
@ echo.
@ echo              将%MySQLName%%MySQLVersion%从系统服务里卸载...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe remove %MySQLName%%MySQLVersion%
@ echo.
@ echo              卸载%MySQLName%%MySQLVersion%成功！
ping -n 2 127.1>nul
@ echo.
echo                按任意键退出...
pause>nul
exit
:SpeedUnInstall
Cls
set Digit=64
set ApacheName=apache24
set MySQLVersion=102
set MySQLName=mysql
@ echo.
@ echo              将%ApacheName%从系统服务里卸载...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k uninstall -n %ApacheName%
@ echo.
@ echo              %ApacheName%卸载成功！
ping -n 2 127.1>nul
@ echo.
@ echo              将%MySQLName%%MySQLVersion%从系统服务里卸载...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe remove %MySQLName%%MySQLVersion%
@ echo.
@ echo              卸载%MySQLName%%MySQLVersion%成功！
ping -n 2 127.1>nul
@ echo.
echo                按任意键退出...
pause>nul
exit