@echo off
call :RequestAdminElevation "%~dpfs0" %* || goto:eof
mode con: cols=100 lines=50
title -Spotify Adblock (by: Stowe)-
echo +++++++++++++++++++++++++++++++++++++++++++++++++
echo + -Script Adblock Spotify V 1.1.4.197 +
echo + Test and make by @Corey-Stowe (2020/11/07)   +
echo + Block spotify upgrade +
echo
echo +++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo For the best experience, buy premium on spotify
echo.
pause
TASKKILL /IM Spotify.exe /F 2> nul
copy %SystemRoot%\system32\drivers\etc\hosts %SystemRoot%\system32\drivers\etc\hosts.backup
echo. >>"%SystemRoot%\system32\drivers\etc\hosts"
echo. >>"%SystemRoot%\system32\drivers\etc\hosts"
echo # ad block and disabled Spotify update check>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 0.0.0.0 upgrade.spotify.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 0.0.0.0 www.spotify-desktop.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 0.0.0.0 sto3-accesspoint-a88.sto3.spotify.net>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 0.0.0.0 upgrade.scdn.co>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 0.0.0.0 prod.spotify.map.fastlylb.net>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 spclient.wg.spotify.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 www.google-analytics.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 cdn.hptos.firepit.tools>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 pagead2.googlesyndication.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 tpc.googlesyndication.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 b.scorecardresearch.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 securepubads.g.doubleclick.net>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 www.googletagservices.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 adservice.google.es>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 csi.gstatic.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 dntcl.qualaroo.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 platform-lookaside.fbsbx.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 s3.amazonaws.com>>"%SystemRoot%\system32\drivers\etc\hosts"
echo 127.0.0.0 content-lht6-1.xx.fbcdn.net>>"%SystemRoot%\system32\drivers\etc\hosts"
echo # >>"%SystemRoot%\system32\drivers\etc\hosts"
cd %appdata%\Spotify\Apps
del /f /q ad.spa
IF NOT EXIST ad.spa echo. >ad.spa
cd..
Start Spotify.exe
msg * Thành công|ok !
exit
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:RequestAdminElevation FilePath %* || goto:eof
:: 
:: By:   Stowe,     v1.1.4.197 - 2020/11/07 - Changed the admin rights test method from cacls to fltmc
:: Func: opens an admin elevation prompt. If elevated, runs everything after the function call, with elevated rights.
:: Returns: -1 if elevation was requested
::           0 if elevation was successful
::           1 if an error occured
:: 
:: USAGE:
:: If function is copied to a batch file:
::     call :RequestAdminElevation "%~dpf0" %* || goto:eof
::
:: If called as an external library (from a separate batch file):
::     set "_DeleteOnExit=0" on Options
::     (call :RequestAdminElevation "%~dpf0" %* || goto:eof) && CD /D %CD%
::
:: If called from inside another CALL, you must set "_ThisFile=%~dpf0" at the beginning of the file
::     call :RequestAdminElevation "%_ThisFile%" %* || goto:eof
::
:: If you need to use the ! char in the arguments, the calling must be done like this, and afterwards you must use %args% to get the correct arguments:
::      set "args=%* "
::      call :RequestAdminElevation .....   use one of the above but replace the %* with %args:!={a)%
::      set "args=%args:{a)=!%" 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal ENABLEDELAYEDEXPANSION & set "_FilePath=%~1"
  if NOT EXIST "!_FilePath!" (echo/Read RequestAdminElevation usage information)
  :: UAC.ShellExecute only works with 8.3 filename, so use %~s1
  set "_FN=_%~ns1" & echo/%TEMP%| findstr /C:"(" >nul && (echo/ERROR: %%TEMP%% path can not contain parenthesis &pause &endlocal &fc;: 2>nul & goto:eof)
  :: Remove parenthesis from the temp filename
  set _FN=%_FN:(=%
  set _vbspath="%temp:~%\%_FN:)=%.vbs" & set "_batpath=%temp:~%\%_FN:)=%.bat"

  :: Test if we gave admin rights
  fltmc >nul 2>&1 || goto :_getElevation

  :: Elevation successful
  (if exist %_vbspath% ( del %_vbspath% )) & (if exist %_batpath% ( del %_batpath% )) 
  :: Set ERRORLEVEL 0, set original folder and exit
  endlocal & CD /D "%~dp1" & ver >nul & goto:eof

  :_getElevation