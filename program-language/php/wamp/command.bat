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
@ echo.����           ��ѡ��ϵͳ����
@ echo.
@ echo.             apache24    �� ������1
@ echo.             httpd       �� ������2
@ echo.             mysql102    �� ������3
@ echo.             mysql101    �� ������4
@ echo.             mysql100    �� ������5
@ echo.             mariadb102  �� ������6
@ echo.             mariadb101  �� ������7
@ echo.             mariadb100  �� ������8
@ echo.
@ echo.             �˳��ű� �� ������0
@ echo.
set /p export=      �������ְ��س���
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
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SelectService
:SelectMenu
Cls
@ echo.
@ echo.����           ���������ѡ�
@ echo.
@ echo.             �������� �� ������1
@ echo.
@ echo.             �رշ��� �� ������2
@ echo.
@ echo.             ���÷��� �� ������3
@ echo.
@ echo.             ���ز˵� �� ������4
@ echo.
@ echo.             �˳��ű� �� ������0
@ echo.
set /p export=      �������ְ��س���
if /i "%export%"=="1" Goto StartService
if /i "%export%"=="2" Goto StopService
if /i "%export%"=="3" Goto SetService
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SelectMenu
:StartService
Cls
@ echo.
@ echo.             ����%ServiceName%��...
net start %ServiceName%
ping -n 2 127.1>nul
Goto SelectService
:StopService
Cls
@ echo.
@ echo.             �ر�%ServiceName%��...
net stop %ServiceName%
ping -n 2 127.1>nul
Goto SelectService
:SetService
Cls
@ echo.
@ echo.����         �����÷���ѡ�
@ echo.
@ echo.             �Զ� �� ������1
@ echo.
@ echo.             �ֶ� �� ������2
@ echo.
@ echo.             ���� �� ������3
@ echo.
@ echo.             ���� �� ������4
@ echo.
@ echo.             �˳��ű� �� ������0
@ echo.
set /p export=      �������ְ��س���
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
@ echo.             ����%ServiceName%Ϊ%SetName%...
sc config %ServiceName% start=%SetName%
ping -n 2 127.1>nul
Goto SelectService
