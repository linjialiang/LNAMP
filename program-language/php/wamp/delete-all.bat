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
@ echo.             ǿɾ������ط��� �� ������1
@ echo.
@ echo.             ж��������ط��� �� ������2
@ echo.
@ echo.             �˳� �� ������0
@ echo.
@ echo.             ���棺�ò���Σ�գ�����ѡ��
@ echo.
set /p export=      �������ְ��س���
if /i "%export%"=="1" Goto DeleteAll
if /i "%export%"=="2" Goto UnInstallAll
if /i "%export%"=="0" exit
@ echo.
@ echo              ѡ����Ч������������
ping -n 2 127.1>nul
Goto Menu
:DeleteAll
@ echo.
@ echo.             ɾ��apache24
sc delete apache2
ping -n 2 127.1>nul
@ echo.             ɾ��httpd
sc delete httpd
ping -n 2 127.1>nul
@ echo.             ɾ��mysql103
sc delete mysql103
ping -n 2 127.1>nul
@ echo.             ɾ��mysql102
sc delete mysql102
ping -n 2 127.1>nul
@ echo.             ɾ��mysql101
sc delete mysql101
ping -n 2 127.1>nul
@ echo.             ɾ��mysql100
sc delete mysql100
ping -n 2 127.1>nul
@ echo.             ɾ��mariadb103
sc delete mariadb103
ping -n 2 127.1>nul
@ echo.             ɾ��mariadb102
sc delete mariadb102
ping -n 2 127.1>nul
@ echo.             ɾ��mariadb101
sc delete mariadb101
ping -n 2 127.1>nul
@ echo.             ɾ��mariadb100
sc delete mariadb100
ping -n 2 127.1>nul
@ echo.
@ echo              ǿ��ɾ��������ط�����ϣ����ɾ���˲���ɾ���ģ�����£��뷴����
echo                ��������˳�...
pause>nul
exit
:UnInstallAll
@ echo.
@ echo              ж��apache24
@ c:
@ cd c:\wamp\64\apache24\bin\
@ httpd.exe -k uninstall -n apache24
ping -n 2 127.1>nul
@ echo.
@ echo              ж��httpd
cd c:\wamp\32\apache24\bin\
httpd.exe -k uninstall -n httpd
ping -n 2 127.1>nul
@ echo.
@ echo              ��mysql103��ϵͳ������ж��...
@ cd c:\wamp\64\mariadb103\bin\
@ mysqld.exe remove mysql103
ping -n 2 127.1>nul
@ echo.
@ echo              ��mysql102��ϵͳ������ж��...
@ cd c:\wamp\64\mariadb102\bin\
@ mysqld.exe remove mysql102
ping -n 2 127.1>nul
@ echo.
@ echo              ��mysql101��ϵͳ������ж��...
@ cd c:\wamp\64\mariadb101\bin\
@ mysqld.exe remove mysql101
ping -n 2 127.1>nul
@ echo.
@ echo              ��mysql100��ϵͳ������ж��...
@ cd c:\wamp\64\mariadb100\bin\
@ mysqld.exe remove mysql100
ping -n 2 127.1>nul
@ echo.
@ echo              ��mariadb103��ϵͳ������ж��...
@ cd c:\wamp\32\mariadb103\bin\
@ mysqld.exe remove mariadb103
ping -n 2 127.1>nul
@ echo.
@ echo              ��mariadb102��ϵͳ������ж��...
@ cd c:\wamp\32\mariadb102\bin\
@ mysqld.exe remove mariadb102
ping -n 2 127.1>nul
@ echo.
@ echo              ��mariadb101��ϵͳ������ж��...
@ cd c:\wamp\32\mariadb101\bin\
@ mysqld.exe remove mariadb101
ping -n 2 127.1>nul
@ echo.
@ echo              ��mariadb100��ϵͳ������ж��...
@ cd c:\wamp\32\mariadb100\bin\
@ mysqld.exe remove mariadb100
ping -n 2 127.1>nul
@ echo.
@ echo              ж����������ط������ɾ���˲���ɾ���ģ�����£��뷴����
echo                ��������˳�...
pause>nul
exit