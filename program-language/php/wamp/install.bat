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
@ echo.����           ���˵�ѡ�
@ echo.
@ echo.             ��װ �� ������1
@ echo.
@ echo.             ���� �� ������2
@ echo.
@ echo.             �˳� �� ������0
@ echo.
@ echo.             ��ʾ��������ֻѡ��һ��λ����װ�������64λ��ֱ��ѡ���ٰ�װ��
@ echo.
set /p export=      �������ְ��س���
if /i "%export%"=="1" Goto Install
if /i "%export%"=="2" Goto SpeedInstall
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto HomeMenu
:Install
Goto SelectDigit
:SelectDigit
Cls
@ echo.
@ echo.              ��λ��ѡ�
@ echo.
@ echo.             64λ �� ������1
@ echo.
@ echo.             32λ �� ������2
@ echo.
@ echo.             �˳� �� ������0
@ echo.
set /p export=      �������ְ��س���
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
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SelectDigit
:IfHttpd
Cls
@ echo.
@ echo.������      ���Ƿ�װ apache24��
@ echo.
@ echo.             ������װ �� ������1
@ echo.
@ echo.             ������װ �� ������2
@ echo.
@ echo.             ����ѡ��λ�� �� ������3
@ echo.
@ echo.             �˳� �� ������0
@ echo.
set /p export=      �������ְ��س���
if /i "%export%"=="1" Goto ReturnHttpd
if /i "%export%"=="2" Goto SelecteMySQL
if /i "%export%"=="3" Goto SelectDigit
if /i "%export%"=="0" exit
@ echo.
echo                ѡ����Ч������������
ping -n 2 127.1>nul
Goto IfHttpd
:SelecteMySQL
Cls
@ echo.
@ echo.��������       ��ѡ�� mariadb �汾��
@ echo.
@ echo.             mariadb 10.3 �� ������1
@ echo.
@ echo.             mariadb 10.2 �� ������2
@ echo.
@ echo.             mariadb 10.1 �� ������3
@ echo.
@ echo.             mariadb 10.0 �� ������4
@ echo.
@ echo.             �˳� �� ������0
@ echo.
set /p export=      �������ְ��س���
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
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SelecteMySQL
:IfMySQL
Cls
@ echo.
@ echo.������      ���Ƿ�װ mariadb��
@ echo.
@ echo.             ������װ �� ������1
@ echo.
@ echo.             ȡ����װ �� ������2
@ echo.
@ echo.             ��ѡmariadb�汾 �� ������3
@ echo.
@ echo.             �˳� �� ������0
@ echo.
set /p export=      �������ְ��س���
if /i "%export%"=="1" Goto ReturnMySQL
if /i "%export%"=="2" exit
if /i "%export%"=="3" Goto SelecteMySQL
if /i "%export%"=="0" exit
@ echo.
echo                ѡ����Ч������������
ping -n 2 127.1>nul
Goto IfMySQL
:ReturnHttpd
Cls
@ echo.
@ echo              ��%ServiceHttpd%��װ��ϵͳ����...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k install -n %ServiceHttpd%
@ echo.
@ echo              %ServiceHttpd%��װ�ɹ���
ping -n 2 127.1>nul
Goto IfMySQL
:ReturnMySQL
Cls
@ echo.
@ echo              ��%ServiceMySQL%%MySQLVersion%��װ��ϵͳ����...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe --install %ServiceMySQL%%MySQLVersion% --defaults-file=c:\wamp\conf\my.ini
@ echo.
@ echo              ��װ%ServiceMySQL%%MySQLVersion%�ɹ���
ping -n 2 127.1>nul
@ echo.
echo                ��������˳�...
pause>nul
exit
:SpeedInstall
Cls
set Digit=64
set ServiceHttpd=apache24
set MySQLVersion=103
set ServiceMySQL=mysql
@ echo.
@ echo              ��%ServiceHttpd%��װ��ϵͳ����...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k install -n %ServiceHttpd%
@ echo.
@ echo              %ServiceHttpd%��װ�ɹ���
ping -n 2 127.1>nul
@ echo.
@ echo              ��%ServiceMySQL%%MySQLVersion%��װ��ϵͳ����...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe --install %ServiceMySQL%%MySQLVersion% --defaults-file=c:\wamp\conf\my.ini
@ echo.
@ echo              ��װ%ServiceMySQL%%MySQLVersion%�ɹ���
ping -n 2 127.1>nul
@ echo.
echo                ��������˳�...
pause>nul
exit