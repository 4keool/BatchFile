::@echo off
title	IP �ּ� ����

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::COMPANY::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set	COMPANY_IP=192.168.123.174
set	COMPANY_SUBNET=255.255.255.0
set	COMPANY_GATEWAY=192.168.123.254
set	COMPANY_DNS=203.248.252.2
set	COMPANY_SUBDNS=164.124.101.2

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::MANAGER::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set	MANAGER_IP=192.168.1.10
set	MANAGER_SUBNET=255.255.255.0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::LOCAL::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set	LOCAL1_IP=192.168.1.11
set	LOCAL2_IP=192.168.1.12
set	LOCAL3_IP=192.168.1.13
set	LOCAL4_IP=192.168.1.14
set	LOCAL5_IP=192.168.1.15

set	LOCAL_CAM1=169.254.1.1
set	LOCAL_CAM2=169.254.2.1
set	LOCAL_CAM3=169.254.3.1
set	LOCAL_CAM4=169.254.4.1
set	LOCAL_CAM5=169.254.5.1

set	LOCAL_SUBNET=255.255.255.0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_SETUP
cls
echo.
echo	1.�繫��
echo	2.��
echo	3.�Ŵ���PC
echo	4.����PC
echo	5.����
echo.

set	/p num=��ȣ�� �Է��ϼ��� :

if	"%num%"=="1"	goto �繫��
if	"%num%"=="2"	goto ��
if	"%num%"=="3"	goto �Ŵ���PC
if	"%num%"=="4"	goto ����PC��ȣ
if	"%num%"=="5"	goto ����
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:�繫��
netsh -c int ip set address name="���� ��Ʈ��ũ ����" static %COMPANY_IP% %COMPANY_SUBNET% %COMPANY_GATEWAY%
netsh -c int ip set dns name="���� ��Ʈ��ũ ����" static %COMPANY_DNS%
netsh -c int ip add dns name="���� ��Ʈ��ũ ����" static %COMPANY_SUBDNS%
goto _Success

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:��
netsh -c int ip set address name="�̴���" source=dhcp
netsh -c int ip set dns name="�̴���" source=dhcp
goto _Success
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:�Ŵ���PC
netsh -c int ip set address name="���� ��Ʈ��ũ ����" static %MANAGER_IP% %MANAGER_SUBNET%
netsh -c int ip set dns name="���� ��Ʈ��ũ ����" dhcp
goto _Success
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:����PC��ȣ
echo	����� �ʿ�.

set	/p nLocalPC=���� PC�� ��ȣ�� �Է��ϼ��� :
if	"%nLocalPC%"=="1"	netsh -c int ip set address name="�̴���" source=dhcp
if	"%nLocalPC%"=="2"	netsh -c int ip set address name="�̴���" static %LOCAL2_IP% %LOCAL_SUBNET%
if	"%nLocalPC%"=="3"	netsh -c int ip set address name="�̴���" static %LOCAL3_IP% %LOCAL_SUBNET%
if	"%nLocalPC%"=="4"	netsh -c int ip set address name="�̴���" static %LOCAL4_IP% %LOCAL_SUBNET%
if	"%nLocalPC%"=="5"	netsh -c int ip set address name="�̴���" static %LOCAL5_IP% %LOCAL_SUBNET%

echo	���� %nLocalPC%�� ���õǾ����ϴ�.

goto ����CAM����
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:����CAM����

set	/p nLocalPC=���� PC�� ��ȣ�� �Է��ϼ��� :
echo	���� %nLocalPC%�� ���õǾ����ϴ�.









timeout 5
goto _Success
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::





::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:����
echo	�����մϴ�.
pause > nul
goto _END
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_Success
cls
echo.
echo.
echo	IP ������ �Ϸ�Ǿ����ϴ�.
echo.
pause
goto _SETUP
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_END
exit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::