@echo off
mode con cols=120 lines=40
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
:HomeMenu
Cls
@ echo.
@ echo.　　           【菜单选项】
@ echo.
@ echo.             安装 → 请输入1
@ echo.
@ echo.             极速 → 请输入2
@ echo.
@ echo.             退出 → 请输入0
@ echo.
@ echo.             提示：建议大家只选择一种位数安装，如果是64位可直接选择极速安装！
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto Install
if /i "%export%"=="2" Goto SpeedInstall
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto HomeMenu
:Install
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
if /i "%export%"=="1" set ServiceHttpd=apache24
if /i "%export%"=="1" set ServiceMySQL=mysql
if /i "%export%"=="1" Goto IfHttpd
if /i "%export%"=="2" set Digit=32
if /i "%export%"=="2" set ServiceHttpd=httpd
if /i "%export%"=="2" set ServiceMySQL=mariadb
if /i "%export%"=="2" Goto IfHttpd
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SelectDigit
:IfHttpd
Cls
@ echo.
@ echo.　　　      【是否安装 apache24】
@ echo.
@ echo.             继续安装 → 请输入1
@ echo.
@ echo.             跳过安装 → 请输入2
@ echo.
@ echo.             重新选择位数 → 请输入3
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto ReturnHttpd
if /i "%export%"=="2" Goto SelecteMySQL
if /i "%export%"=="3" Goto SelectDigit
if /i "%export%"=="0" exit
@ echo.
echo                选择无效，请重新输入
ping -n 2 127.1>nul
Goto IfHttpd
:SelecteMySQL
Cls
@ echo.
@ echo.　　　　       【选择 mariadb 版本】
@ echo.
@ echo.             mariadb 10.3 → 请输入1
@ echo.
@ echo.             mariadb 10.2 → 请输入2
@ echo.
@ echo.             mariadb 10.1 → 请输入3
@ echo.
@ echo.             mariadb 10.0 → 请输入4
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" SET MySQLVersion=103
if /i "%export%"=="1" Goto IfMySQL
if /i "%export%"=="2" SET MySQLVersion=102
if /i "%export%"=="2" Goto IfMySQL
if /i "%export%"=="3" SET MySQLVersion=101
if /i "%export%"=="3" Goto IfMySQL
if /i "%export%"=="4" SET MySQLVersion=100
if /i "%export%"=="4" Goto IfMySQL
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SelecteMySQL
:IfMySQL
Cls
@ echo.
@ echo.　　　      【是否安装 mariadb】
@ echo.
@ echo.             继续安装 → 请输入1
@ echo.
@ echo.             取消安装 → 请输入2
@ echo.
@ echo.             重选mariadb版本 → 请输入3
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto ReturnMySQL
if /i "%export%"=="2" exit
if /i "%export%"=="3" Goto SelecteMySQL
if /i "%export%"=="0" exit
@ echo.
echo                选择无效，请重新输入
ping -n 2 127.1>nul
Goto IfMySQL
:ReturnHttpd
Cls
@ echo.
@ echo              将%ServiceHttpd%安装到系统服务...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k install -n %ServiceHttpd%
@ echo.
@ echo              %ServiceHttpd%安装成功！
ping -n 2 127.1>nul
Goto IfMySQL
:ReturnMySQL
Cls
@ echo.
@ echo              将%ServiceMySQL%%MySQLVersion%安装到系统服务...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe --install %ServiceMySQL%%MySQLVersion% --defaults-file=c:\wamp\conf\my.ini
@ echo.
@ echo              安装%ServiceMySQL%%MySQLVersion%成功！
ping -n 2 127.1>nul
@ echo.
echo                按任意键退出...
pause>nul
exit
:SpeedInstall
Cls
set Digit=64
set ServiceHttpd=apache24
set MySQLVersion=103
set ServiceMySQL=mysql
@ echo.
@ echo              将%ServiceHttpd%安装到系统服务...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k install -n %ServiceHttpd%
@ echo.
@ echo              %ServiceHttpd%安装成功！
ping -n 2 127.1>nul
@ echo.
@ echo              将%ServiceMySQL%%MySQLVersion%安装到系统服务...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe --install %ServiceMySQL%%MySQLVersion% --defaults-file=c:\wamp\conf\my.ini
@ echo.
@ echo              安装%ServiceMySQL%%MySQLVersion%成功！
ping -n 2 127.1>nul
@ echo.
echo                按任意键退出...
pause>nul
exit