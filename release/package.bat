
@SET VERSION=0.2
@SET SOURCE_DIR=..\
@SET TARGET=NewThreeKindomBot
@SET TARGET_DIR=.\

@SET ZIP_7Z_FILE=7z\7z.exe
@SET ARCHIVE_FILE_NAME=%TARGET%_%VERSION%.zip

rmdir /Q /S %TARGET_DIR%\%TARGET%
mkdir %TARGET_DIR%\%TARGET%

copy %SOURCE_DIR%\NewThreeKingdomBot.exe %TARGET_DIR%\%TARGET%\ 

::============================================
:: Archive zip file..
::============================================
del /F/Q/S %ARCHIVE_FILE_NAME%
%ZIP_7Z_FILE% a -tzip %TARGET_DIR%\%ARCHIVE_FILE_NAME% %TARGET_DIR%\%TARGET%

pause
