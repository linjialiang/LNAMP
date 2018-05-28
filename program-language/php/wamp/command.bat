@echo off
mode con cols=120 lines=40
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
:SelectService
Cls
@ echo.
@ echo.　　           【选择系统服务】
@ echo.
@ echo.             apache24    → 请输入1
@ echo.             httpd       → 请输入2
@ echo.             mysql103    → 请输入3
@ echo.             mysql102    → 请输入4
@ echo.             mysql101    → 请输入5
@ echo.             mysql100    → 请输入6
@ echo.             mariadb103  → 请输入7
@ echo.             mariadb102  → 请输入8
@ echo.             mariadb101  → 请输入9
@ echo.             mariadb100  → 请输入10
@ echo.
@ echo.             64位103组合  → 请输入643
@ echo.             64位102组合  → 请输入642
@ echo.             64位101组合  → 请输入641
@ echo.             64位100组合  → 请输入640
@ echo.             32位103组合  → 请输入323
@ echo.             32位102组合  → 请输入322
@ echo.             32位101组合  → 请输入321
@ echo.             32位100组合  → 请输入320
@ echo.
@ echo.             退出脚本 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" set ServiceName=apache24
if /i "%export%"=="1" Goto AloneMenu
if /i "%export%"=="2" set ServiceName=httpd
if /i "%export%"=="2" Goto AloneMenu
if /i "%export%"=="3" set ServiceName=mysql103
if /i "%export%"=="3" Goto AloneMenu
if /i "%export%"=="4" set ServiceName=mysql102
if /i "%export%"=="4" Goto AloneMenu
if /i "%export%"=="5" set ServiceName=mysql101
if /i "%export%"=="5" Goto AloneMenu
if /i "%export%"=="6" set ServiceName=mysql100
if /i "%export%"=="6" Goto AloneMenu
if /i "%export%"=="7" set ServiceName=mariadb103
if /i "%export%"=="7" Goto AloneMenu
if /i "%export%"=="8" set ServiceName=mariadb102
if /i "%export%"=="8" Goto AloneMenu
if /i "%export%"=="9" set ServiceName=mariadb101
if /i "%export%"=="9" Goto AloneMenu
if /i "%export%"=="10" set ServiceName=mariadb100
if /i "%export%"=="10" Goto AloneMenu
if /i "%export%"=="643" set HttpdName=apache24
if /i "%export%"=="643" set MySQLName=mysql103
if /i "%export%"=="643" Goto GroupMenu
if /i "%export%"=="642" set HttpdName=apache24
if /i "%export%"=="642" set MySQLName=mysql102
if /i "%export%"=="642" Goto GroupMenu
if /i "%export%"=="641" set HttpdName=apache24
if /i "%export%"=="641" set MySQLName=mysql101
if /i "%export%"=="641" Goto GroupMenu
if /i "%export%"=="640" set HttpdName=apache24
if /i "%export%"=="640" set MySQLName=mysql100
if /i "%export%"=="640" Goto GroupMenu
if /i "%export%"=="323" set HttpdName=httpd
if /i "%export%"=="323" set MySQLName=mariadb103
if /i "%export%"=="323" Goto GroupMenu
if /i "%export%"=="322" set HttpdName=httpd
if /i "%export%"=="322" set MySQLName=mariadb102
if /i "%export%"=="322" Goto GroupMenu
if /i "%export%"=="321" set HttpdName=httpd
if /i "%export%"=="321" set MySQLName=mariadb101
if /i "%export%"=="321" Goto GroupMenu
if /i "%export%"=="320" set HttpdName=httpd
if /i "%export%"=="320" set MySQLName=mariadb100
if /i "%export%"=="320" Goto GroupMenu

if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SelectService
:AloneMenu
Cls
@ echo.
@ echo.　　           【服务操作选项】
@ echo.
@ echo.             开启服务 → 请输入1
@ echo.
@ echo.             关闭服务 → 请输入2
@ echo.
@ echo.             重启服务 → 请输入5
@ echo.
@ echo.             配置服务 → 请输入3
@ echo.
@ echo.             返回菜单 → 请输入4
@ echo.
@ echo.             退出脚本 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto StartService
if /i "%export%"=="2" Goto StopService
if /i "%export%"=="3" Goto SetService
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="5" Goto RestartService
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto AloneMenu
:GroupMenu
Cls
@ echo.
@ echo.　　           【服务操作选项】
@ echo.
@ echo.             开启服务 → 请输入1
@ echo.
@ echo.             关闭服务 → 请输入2
@ echo.
@ echo.             重启服务 → 请输入5
@ echo.
@ echo.             配置服务 → 请输入3
@ echo.
@ echo.             返回菜单 → 请输入4
@ echo.
@ echo.             退出脚本 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto StartGroup
if /i "%export%"=="2" Goto StopGroup
if /i "%export%"=="3" Goto SetGroup
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="5" Goto RestartGroup
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto GroupMenu
:SetService
Cls
@ echo.
@ echo.　　         【配置服务选项】
@ echo.
@ echo.             自动 → 请输入1
@ echo.
@ echo.             手动 → 请输入2
@ echo.
@ echo.             禁用 → 请输入3
@ echo.
@ echo.             返回 → 请输入4
@ echo.
@ echo.             退出脚本 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" set SetName=auto
if /i "%export%"=="2" set SetName=demand
if /i "%export%"=="3" set SetName=disabled
if /i "%export%"=="1" Goto RetuenSetService
if /i "%export%"=="2" Goto RetuenSetService
if /i "%export%"=="3" Goto RetuenSetService
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SetService
:SetGroup
Cls
@ echo.
@ echo.　　         【配置服务选项】
@ echo.
@ echo.             自动 → 请输入1
@ echo.
@ echo.             手动 → 请输入2
@ echo.
@ echo.             禁用 → 请输入3
@ echo.
@ echo.             返回 → 请输入4
@ echo.
@ echo.             退出脚本 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" set SetName=auto
if /i "%export%"=="2" set SetName=demand
if /i "%export%"=="3" set SetName=disabled
if /i "%export%"=="1" Goto RetuenSetGroup
if /i "%export%"=="2" Goto RetuenSetGroup
if /i "%export%"=="3" Goto RetuenSetGroup
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SetGroup
:StartService
Cls
@ echo.
@ echo.             开启%ServiceName%中...
net start %ServiceName%
ping -n 2 127.1>nul
Goto SelectService
:StopService
Cls
@ echo.
@ echo.             关闭%ServiceName%中...
net stop %ServiceName%
ping -n 2 127.1>nul
Goto SelectService
:RestartService
Cls
@ echo.
@ echo.             重启%ServiceName%中...
net stop %ServiceName%
net start %ServiceName%
@ echo.
@ echo.             重启%ServiceName%成功...
ping -n 2 127.1>nul
Goto SelectService
:RetuenSetService
Cls
@ echo.
@ echo.             设置%ServiceName%为%SetName%...
sc config %ServiceName% start=%SetName%
ping -n 2 127.1>nul
Goto SelectService
:StartGroup
Cls
@ echo.
@ echo.             开启%HttpdName%中...
net start %HttpdName%
ping -n 2 127.1>nul
@ echo.
@ echo.             开启%MySQLName%中...
net start %MySQLName%
ping -n 2 127.1>nul
Goto SelectService
:StopGroup
Cls
@ echo.
@ echo.             关闭%HttpdName%中...
net stop %HttpdName%
ping -n 2 127.1>nul
@ echo.
@ echo.             关闭%MySQLName%中...
net stop %MySQLName%
ping -n 2 127.1>nul
Goto SelectService
:RestartGroup
Cls
@ echo.
@ echo.             重启%HttpdName% %MySQLName%中...
net stop %HttpdName%
net stop %MySQLName%
net start %HttpdName%
net start %MySQLName%
@ echo.
@ echo.             重启%MySQLName% %MySQLName%成功...
ping -n 2 127.1>nul
Goto SelectService
:RetuenSetGroup
Cls
@ echo.
@ echo.             设置%HttpdName%为%SetName%...
sc config %HttpdName% start=%SetName%
ping -n 2 127.1>nul
@ echo.
@ echo.             设置%MySQLName%为%SetName%...
sc config %MySQLName% start=%SetName%
ping -n 2 127.1>nul
Goto SelectService