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
@ echo.             mysql102    → 请输入3
@ echo.             mysql101    → 请输入4
@ echo.             mysql100    → 请输入5
@ echo.             mariadb102  → 请输入6
@ echo.             mariadb101  → 请输入7
@ echo.             mariadb100  → 请输入8
@ echo.
@ echo.             退出脚本 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" set ServiceName=apache24
if /i "%export%"=="1" Goto SelectMenu
if /i "%export%"=="2" set ServiceName=httpd
if /i "%export%"=="2" Goto SelectMenu
if /i "%export%"=="3" set ServiceName=mysql102
if /i "%export%"=="3" Goto SelectMenu
if /i "%export%"=="4" set ServiceName=mysql101
if /i "%export%"=="4" Goto SelectMenu
if /i "%export%"=="5" set ServiceName=mysql100
if /i "%export%"=="5" Goto SelectMenu
if /i "%export%"=="6" set ServiceName=mariadb102
if /i "%export%"=="6" Goto SelectMenu
if /i "%export%"=="7" set ServiceName=mariadb101
if /i "%export%"=="7" Goto SelectMenu
if /i "%export%"=="8" set ServiceName=mariadb100
if /i "%export%"=="8" Goto SelectMenu
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SelectService
:SelectMenu
Cls
@ echo.
@ echo.　　           【服务操作选项】
@ echo.
@ echo.             开启服务 → 请输入1
@ echo.
@ echo.             关闭服务 → 请输入2
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
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SelectMenu
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
if /i "%export%"=="1" Goto SetSelect
if /i "%export%"=="2" Goto SetSelect
if /i "%export%"=="3" Goto SetSelect
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="0" exit
:SetSelect
Cls
@ echo.
@ echo.             设置%ServiceName%为%SetSelect%...
sc config %ServiceName% start=%SetSelect%
ping -n 2 127.1>nul
Goto SelectService
