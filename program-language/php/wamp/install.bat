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
Goto Menu
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
if /i "%export%"=="1" set ApacheName=apache24
if /i "%export%"=="1" set MySQLName=mysql
if /i "%export%"=="1" Goto SlecteApache24
if /i "%export%"=="2" set Digit=32
if /i "%export%"=="2" set ApacheName=httpd
if /i "%export%"=="2" set MySQLName=mariadb
if /i "%export%"=="2" Goto SlecteApache24
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SelectDigit
:SlecteApache24
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
if /i "%export%"=="1" Goto ReturnApache24
if /i "%export%"=="2" Goto SlecteMySQLVersions
if /i "%export%"=="3" Goto SelectDigit
if /i "%export%"=="0" exit
@ echo.
echo                ѡ����Ч������������
ping -n 2 127.1>nul
Goto SlecteApache24
:SlecteMySQLVersions
Cls
@ echo.
@ echo.��������       ��ѡ�� mariadb �汾��
@ echo.
@ echo.             mariadb 10.2 �� ������1
@ echo.
@ echo.             mariadb 10.1 �� ������2
@ echo.
@ echo.             mariadb 10.0 �� ������3
@ echo.
@ echo.             �˳� �� ������0
@ echo.
set /p export=      �������ְ��س���
if /i "%export%"=="1" SET MySQLVersion=102
if /i "%export%"=="1" Goto SlecteMySQL
if /i "%export%"=="2" SET MySQLVersion=101
if /i "%export%"=="2" Goto SlecteMySQL
if /i "%export%"=="3" SET MySQLVersion=100
if /i "%export%"=="3" Goto SlecteMySQL
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto SlecteMySQLVersions
:SlecteMySQL
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
if /i "%export%"=="3" Goto SlecteMySQLVersions
if /i "%export%"=="0" exit
@ echo.
echo                ѡ����Ч������������
ping -n 2 127.1>nul
Goto SlecteMySQL
:ReturnApache24
Cls
@ echo.
@ echo              ��%ApacheName%��װ��ϵͳ����...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k install -n %ApacheName%
@ echo.
@ echo              %ApacheName%��װ�ɹ���
ping -n 2 127.1>nul
Goto SlecteMySQL
:ReturnMySQL
Cls
@ echo.
@ echo              ��%MySQLName%%MySQLVersion%��װ��ϵͳ����...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe install %MySQLName%%MySQLVersion%
@ echo.
@ echo              ��װ%MySQLName%%MySQLVersion%�ɹ���
ping -n 2 127.1>nul
@ echo.
echo                ��������˳�...
pause>nul
exit
:SpeedInstall
Cls
set Digit=64
set ApacheName=apache24
set MySQLVersion=102
set MySQLName=mysql
@ echo.
@ echo              ��%ApacheName%��װ��ϵͳ����...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k install -n %ApacheName%
@ echo.
@ echo              %ApacheName%��װ�ɹ���
ping -n 2 127.1>nul
@ echo.
@ echo              ��%MySQLName%%MySQLVersion%��װ��ϵͳ����...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe install %MySQLName%%MySQLVersion%
@ echo.
@ echo              ��װ%MySQLName%%MySQLVersion%�ɹ���
ping -n 2 127.1>nul
@ echo.
echo                ��������˳�...
pause>nul
exit