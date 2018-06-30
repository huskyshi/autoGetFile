@echo on
setlocal EnableDelayedExpansion

for /f "skip=1 tokens=1,2,3,4,5" %%a in (config\serverInfo.list) do (
set IP=%%a
echo !IP!
set USERNAME=%%b
echo !USERNAME!
set PASSWORD=%%c
echo !PASSWORD!
set DIRECTORY=%%d
echo !DIRECTORY!
set FILES=%%e
echo !FILES!


md "C:\github\autoGetFile\"%date:~0,4%%date:~5,2%%date:~8,2%\!IP!
set LOCALDIR="C:\github\autoGetFile\"%date:~0,4%%date:~5,2%%date:~8,2%\!IP!

echo. >> tmp\sftp.log_!IP!
echo [%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%] [INFO] Start to get files from server !IP!, please wait!. >> tmp\sftp.log_!IP!

echo cd !DIRECTORY! > tmp\sftp.txt_!IP!
echo lcd !LOCALDIR! >> tmp\sftp.txt_!IP!
echo mget !FILES! >> tmp\sftp.txt_!IP!
echo bye >> tmp\sftp.txt_!IP!

if /i "%PROCESSOR_IDENTIFIER:~0,3%" == "X86" (
bin\psftp_x86 !IP! -l !USERNAME! -pw !PASSWORD! < tmp\sftp.txt_!IP! >> tmp\sftp.log_!IP!
) else (
bin\psftp_x64 !IP! -l !USERNAME! -pw !PASSWORD! < tmp\sftp.txt_!IP! >> tmp\sftp.log_!IP!
)
echo done. >> tmp\sftp.log_!IP!
echo [%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%] [INFO] End to get files from server !IP! successfully!. >> tmp\sftp.log_!IP!
echo done. >> tmp\sftp.log_!IP!

)
pause