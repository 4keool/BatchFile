@echo off
title	IP 주소 변경

::############변경 필요############
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::네트워크 어댑터 이름:::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set ADAPT_NAME=Wi-Fi
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::사용자 고정:::::::::::::::::::
:::::::::HJH=1, KJY=2, RYS=3:::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set USER=3
################################




::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::창 크기:::::::::::::::::::::::
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





:_시작
cls
echo.
echo	1.내부망
echo	2.외부망
echo	3.디버그
echo.

set	/p num=번호를 입력하세요 :

if "%num%"=="1" (
goto _내부망
) else if  "%num%"=="2" (
goto _외부망
) else if "%num%"=="3" (
goto _디버그
)
else (
goto _시작
)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_내부망

cls
echo.

if "0"=="%USER%" (
  goto _유동사용자
) else (
  goto _고정사용자
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_유동사용자

  echo.  사용자가 누구입니까?
  echo.
  echo.  1. 한지호
  echo.
  echo.  2. 곽준영
  echo.
  echo.  3. 류용상
  echo.
  set  /p num=번호를 입력하세요:

  if  "1"=="%num%" (
    netsh -c int ip set address name="%ADAPT_NAME%" static %HJH_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else if "2"=="%num%" (
    netsh -c int ip set address name="%ADAPT_NAME%" static %KJY_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else if "3"=="%num%" (
    netsh -c int ip set address name="%ADAPT_NAME%" static %RYS_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else (
    echo.
    echo 잘못 입력하셨습니다.
    echo.
    pause
    cls
    goto _유동사용자
)
  netsh -c int ip set dns name="%ADAPT_NAME%" static %INTERNAL_DNS%
  ::netsh -c int ip add dns name="%ADAPT_NAME%" static %INTERNAL_SUBDNS%
goto _완료
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_고정사용자
  if  "1"=="%USER%" (
    echo.
    echo.
    echo 고정사용자 : 한지호
    echo.
    netsh -c int ip set address name="%ADAPT_NAME%" static %HJH_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else if "%USER%"=="2" (
    echo.
    echo.
    echo 고정사용자 : 곽준영
    echo.
    netsh -c int ip set address name="%ADAPT_NAME%" static %KJY_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else if "3"=="%USER%" (
    echo.
    echo.
    echo 고정사용자 : 류용상
    echo.
    netsh -c int ip set address name="%ADAPT_NAME%" static %RYS_IP% %INTERNAL_SUBNET% %INTERNAL_GATEWAY%
  ) else (
    echo.
    echo 잘못 값입니다.
    echo.
    echo 사용자 고정 파라미터를 수정해주세요.
    echo.
    echo HJH=1, KJY=2, RYS=3
    echo.
    set  /p USER=번호를 입력하세요:
    cls
    goto _고정사용자
  )
  netsh -c int ip set dns name="%ADAPT_NAME%" static %INTERNAL_DNS%
  ::netsh -c int ip add dns name="%ADAPT_NAME%" static %INTERNAL_SUBDNS%
goto _완료
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_외부망
netsh -c int ip set address name="%ADAPT_NAME%" source=dhcp
netsh -c int ip set dns name="%ADAPT_NAME%" source=dhcp
goto _완료
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_디버그
echo "디버그"
set /p line=라인 번호를 입력하세요:
netsh -c int ip set address name="이더넷" static 192.168.%line%.44 %INTERNAL_SUBNET%
echo 192.168.%line%.44/%INTERNAL_SUBNET%
goto _완료
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:종료
echo	종료합니다.
pause > nul
goto _끝
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_완료
::cls
echo.
echo.
echo	IP 설정이 완료되었습니다.
echo.
pause
goto _시작
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:_끝
exit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::