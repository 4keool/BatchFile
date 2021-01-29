@echo off
title	IP 주소 변경

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
echo	1.사무실
echo	2.집
echo	3.매니저PC
echo	4.로컬PC
echo	5.종료
echo.

set	/p num=번호를 입력하세요 :

if	"%num%"=="1"	goto 사무실
if	"%num%"=="2"	goto 집
if	"%num%"=="3"	goto 매니저PC
if	"%num%"=="4"	goto 로컬PC번호
if	"%num%"=="5"	goto 종료
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:사무실
netsh -c int ip set address name="무선 네트워크 연결" static %COMPANY_IP% %COMPANY_SUBNET% %COMPANY_GATEWAY%
netsh -c int ip set dns name="무선 네트워크 연결" static %COMPANY_DNS%
netsh -c int ip add dns name="무선 네트워크 연결" static %COMPANY_SUBDNS%
goto _Success

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:집
netsh -c int ip set address name="이더넷" source=dhcp
netsh -c int ip set dns name="이더넷" source=dhcp
goto _Success
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:매니저PC
netsh -c int ip set address name="무선 네트워크 연결" static %MANAGER_IP% %MANAGER_SUBNET%
netsh -c int ip set dns name="무선 네트워크 연결" dhcp
goto _Success
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:로컬PC번호
echo	디버깅 필요.

set	/p nLocalPC=로컬 PC의 번호를 입력하세요 :
if	"%nLocalPC%"=="1"	netsh -c int ip set address name="이더넷" source=dhcp
if	"%nLocalPC%"=="2"	netsh -c int ip set address name="이더넷" static %LOCAL2_IP% %LOCAL_SUBNET%
if	"%nLocalPC%"=="3"	netsh -c int ip set address name="이더넷" static %LOCAL3_IP% %LOCAL_SUBNET%
if	"%nLocalPC%"=="4"	netsh -c int ip set address name="이더넷" static %LOCAL4_IP% %LOCAL_SUBNET%
if	"%nLocalPC%"=="5"	netsh -c int ip set address name="이더넷" static %LOCAL5_IP% %LOCAL_SUBNET%

echo	로컬 %nLocalPC%가 선택되었습니다.
goto 로컬CAM개수
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:로컬CAM개수
set	/p nLocalCAM=CAM 개수를 입력하세요 :

set	COUNT=1
for /f "usebackq delims=:" %%f in (`ipconfig /all ^| find /I "이더넷 어댑터"`) do (
set z_lan=%%f

if	"%COUNT%"  GTR "%nLocalCAM%"
	(
	echo	반복문 완료 %COUNT%
	goto 반복아웃
	)
if	"%nLocalCAM%" EQU "0"
	(
	echo	CAM 개수는 0가 될 수 없습니다.
	goto 반복아웃
	)


if	"%COUNT%" EQU "1" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address %z_lan% static %LOCAL_CAM1% %LOCAL_SUBNET%
	)

if	"%COUNT%" EQU "2" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address %z_lan% static %LOCAL_CAM1% %LOCAL_SUBNET%
	)

if	"%COUNT%" EQU "3" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address %z_lan% static %LOCAL_CAM1% %LOCAL_SUBNET%
	)

if	"%COUNT%" EQU "4" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address %z_lan% static %LOCAL_CAM1% %LOCAL_SUBNET%
	)

if	"%COUNT%" EQU "5" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address %z_lan% static %LOCAL_CAM1% %LOCAL_SUBNET%
	)

echo	증가
%COUNT%=%COUNT%+1
echo	%COUNT%

)

:반복아웃
echo	반복아웃
timeout 5
goto _Success







if	"%nLocalCAM%" GEQ "1" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address name="무선 네트워크 연결2" static %LOCAL_CAM1% %LOCAL_SUBNET%
)
if	"%nLocalCAM%" GEQ "2" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address name="무선 네트워크 연결3" static %LOCAL_CAM2% %LOCAL_SUBNET%
)
if	"%nLocalCAM%" GEQ "3" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address name="무선 네트워크 연결4" static %LOCAL_CAM3% %LOCAL_SUBNET%
)
if	"%nLocalCAM%" GEQ "4" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address name="무선 네트워크 연결5" static %LOCAL_CAM4% %LOCAL_SUBNET%
)
if	"%nLocalCAM%" GEQ "5" (
	echo	카메라 %nLocalCAM%가 변경되었습니다.
	netsh -c int ip set address name="무선 네트워크 연결6" static %LOCAL_CAM5% %LOCAL_SUBNET%
)
timeout 5
goto _Success
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:유선네트워크



:무선네트워크






::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:종료
echo	종료합니다.
pause > nul
goto _END
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_Success
cls
echo.
echo.
echo	IP 설정이 완료되었습니다.
echo.
pause
goto _SETUP
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_END
exit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::