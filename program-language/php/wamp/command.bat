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
@ echo.             mysql103    �� ������3
@ echo.             mysql102    �� ������4
@ echo.             mysql101    �� ������5
@ echo.             mysql100    �� ������6
@ echo.             mariadb103  �� ������7
@ echo.             mariadb102  �� ������8
@ echo.             mariadb101  �� ������9
@ echo.             mariadb100  �� ������10
@ echo.
@ echo.             64λ103���  �� ������643
@ echo.             64λ102���  �� ������642
@ echo.             64λ101���  �� ������641
@ echo.             64λ100���  �� ������640
@ echo.             32λ103���  �� ������323
@ echo.             32λ102���  �� ������322
@ echo.             32λ101���  �� ������321
@ echo.             32λ100���  �� ������320
@ echo.
@ echo.             �˳��ű� �� ������0
@ echo.
set /p export=      �������ְ��س���
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
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SelectService
:AloneMenu
Cls
@ echo.
@ echo.����           ���������ѡ�
@ echo.
@ echo.             �������� �� ������1
@ echo.
@ echo.             �رշ��� �� ������2
@ echo.
@ echo.             �������� �� ������5
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
if /i "%export%"=="5" Goto RestartService
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto AloneMenu
:GroupMenu
Cls
@ echo.
@ echo.����           ���������ѡ�
@ echo.
@ echo.             �������� �� ������1
@ echo.
@ echo.             �رշ��� �� ������2
@ echo.
@ echo.             �������� �� ������5
@ echo.
@ echo.             ���÷��� �� ������3
@ echo.
@ echo.             ���ز˵� �� ������4
@ echo.
@ echo.             �˳��ű� �� ������0
@ echo.
set /p export=      �������ְ��س���
if /i "%export%"=="1" Goto StartGroup
if /i "%export%"=="2" Goto StopGroup
if /i "%export%"=="3" Goto SetGroup
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="5" Goto RestartGroup
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto GroupMenu
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
if /i "%export%"=="1" Goto RetuenSetService
if /i "%export%"=="2" Goto RetuenSetService
if /i "%export%"=="3" Goto RetuenSetService
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SetService
:SetGroup
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
if /i "%export%"=="1" Goto RetuenSetGroup
if /i "%export%"=="2" Goto RetuenSetGroup
if /i "%export%"=="3" Goto RetuenSetGroup
if /i "%export%"=="4" Goto SelectService
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SetGroup
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
:RestartService
Cls
@ echo.
@ echo.             ����%ServiceName%��...
net stop %ServiceName%
net start %ServiceName%
@ echo.
@ echo.             ����%ServiceName%�ɹ�...
ping -n 2 127.1>nul
Goto SelectService
:RetuenSetService
Cls
@ echo.
@ echo.             ����%ServiceName%Ϊ%SetName%...
sc config %ServiceName% start=%SetName%
ping -n 2 127.1>nul
Goto SelectService
:StartGroup
Cls
@ echo.
@ echo.             ����%HttpdName%��...
net start %HttpdName%
ping -n 2 127.1>nul
@ echo.
@ echo.             ����%MySQLName%��...
net start %MySQLName%
ping -n 2 127.1>nul
Goto SelectService
:StopGroup
Cls
@ echo.
@ echo.             �ر�%HttpdName%��...
net stop %HttpdName%
ping -n 2 127.1>nul
@ echo.
@ echo.             �ر�%MySQLName%��...
net stop %MySQLName%
ping -n 2 127.1>nul
Goto SelectService
:RestartGroup
Cls
@ echo.
@ echo.             ����%HttpdName% %MySQLName%��...
net stop %HttpdName%
net stop %MySQLName%
net start %HttpdName%
net start %MySQLName%
@ echo.
@ echo.             ����%MySQLName% %MySQLName%�ɹ�...
ping -n 2 127.1>nul
Goto SelectService
:RetuenSetGroup
Cls
@ echo.
@ echo.             ����%HttpdName%Ϊ%SetName%...
sc config %HttpdName% start=%SetName%
ping -n 2 127.1>nul
@ echo.
@ echo.             ����%MySQLName%Ϊ%SetName%...
sc config %MySQLName% start=%SetName%
ping -n 2 127.1>nul
Goto SelectService