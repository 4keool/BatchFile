@echo off
title	IP �ּ� ����

::############���� �ʿ�############
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::��Ʈ��ũ ����� �̸�:::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set ADAPT_NAME=Wi-Fi
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::����� ����:::::::::::::::::::
:::::::::HJH=1, KJY=2, RYS=3:::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set USER=3
################################




::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::â ũ��:::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
mode con cols=60 lines=30
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::  IP LIST  ::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set	HJH_IP=10.40.215.34
set	KJY_IP=10.40.215.39
set	RYS_IP=10.40.215.91
set	INTERNAL_SUBNET=255.255.255.0
set	INTERNAL_GATEWAY=10.40.214.1
set	INTERNAL_DNS=165.243.17.15
set	INTERNAL_SUBDNS=111.222.333.444
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::





:_����
cls
echo.
echo	1.���θ�
echo	2.�ܺθ�
echo	3.�����
echo.

set	/p num=��ȣ�� �Է��ϼ��� :

if "%num%"=="1" (
goto _���θ�
) else if  "%num%"=="2" (
goto _�ܺθ�
) else if "%num%"=="3" (
goto _�����
)
else (
goto _����
)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_���θ�

cls
echo.

if "0"=="%USER%" (
  goto _���������
) else (
  goto _���������
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_���������

  echo.  ����ڰ� �����Դϱ�?
  echo.
  echo.  1. ����ȣ
  echo.
  echo.  2. ���ؿ�
  echo.
  echo.  3. �����
  echo.
  set  /p num=��ȣ�� �Է��ϼ���:

  if  "1"=="%num%" (
    netsh -c int ip set address name="%ADAPT_NAME%" static %HJH_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else if "2"=="%num%" (
    netsh -c int ip set address name="%ADAPT_NAME%" static %KJY_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else if "3"=="%num%" (
    netsh -c int ip set address name="%ADAPT_NAME%" static %RYS_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else (
    echo.
    echo �߸� �Է��ϼ̽��ϴ�.
    echo.
    pause
    cls
    goto _���������
)
  netsh -c int ip set dns name="%ADAPT_NAME%" static %INTERNAL_DNS%
  ::netsh -c int ip add dns name="%ADAPT_NAME%" static %INTERNAL_SUBDNS%
goto _�Ϸ�
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_���������
  if  "1"=="%USER%" (
    echo.
    echo.
    echo ��������� : ����ȣ
    echo.
    netsh -c int ip set address name="%ADAPT_NAME%" static %HJH_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else if "%USER%"=="2" (
    echo.
    echo.
    echo ��������� : ���ؿ�
    echo.
    netsh -c int ip set address name="%ADAPT_NAME%" static %KJY_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else if "3"=="%USER%" (
    echo.
    echo.
    echo ��������� : �����
    echo.
    netsh -c int ip set address name="%ADAPT_NAME%" static %RYS_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else (
    echo.
    echo �߸� ���Դϴ�.
    echo.
    echo ����� ���� �Ķ���͸� �������ּ���.
    echo.
    echo HJH=1, KJY=2, RYS=3
    echo.
    set  /p USER=��ȣ�� �Է��ϼ���:
    cls
    goto _���������
  )
  netsh -c int ip set dns name="%ADAPT_NAME%" static %INTERNAL_DNS%
  ::netsh -c int ip add dns name="%ADAPT_NAME%" static %INTERNAL_SUBDNS%
goto _�Ϸ�
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_�ܺθ�
netsh -c int ip set address name="%ADAPT_NAME%" source=dhcp
netsh -c int ip set dns name="%ADAPT_NAME%" source=dhcp
goto _�Ϸ�
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_�����
echo "�����"
set /p line=���� ��ȣ�� �Է��ϼ���:
netsh -c int ip set address name="�̴���" static 192.168.%line%.44 %INTERNAL_SUBNET%
echo 192.168.%line%.44/%INTERNAL_SUBNET%
goto _�Ϸ�
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:����
echo	�����մϴ�.
pause > nul
goto _��
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_�Ϸ�
::cls
echo.
echo.
echo	IP ������ �Ϸ�Ǿ����ϴ�.
echo.
pause
goto _����
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_��
exit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::