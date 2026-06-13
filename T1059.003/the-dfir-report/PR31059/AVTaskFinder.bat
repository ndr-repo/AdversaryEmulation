@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
echo ---------------
ECHO TIME TO FIND AV
echo ---------------
REM Define a list of "process:Antivirus Name" pairs
SET "av_list=MsMpEng.exe:Windows_Defender,MpDefenderCoreService.exe:Windows_Defender_Core_Service,MBCloudEA.exe:Malwarebytes_Endpoint_Agent,MBAMService.exe:Malwarebytes_Service,ntrtscan.exe:Trend_Micro_Security,avp.exe:Kaspersky_Endpoint_Security,WRSA.exe:Webroot,egui.exe:ESET,AvastUI.exe:Avast"

FOR %%A IN (%av_list%) DO (
    SET "av_pair=%%A"
    REM Split the pair into process and name
    FOR /F "tokens=1,2 delims=:" %%B IN ("!av_pair!") DO (
        SET "proc_name=%%B"
        SET "av_name=%%C"
        
        REM Check if the process is running and suppress all output
        tasklist /fi "imagename eq !proc_name!" 2>nul | find /i "!proc_name!" >nul
        
        REM If the find command was successful (errorlevel 0), echo the AV name
        IF !errorlevel! == 0 (
            ECHO Antivirus found: !av_name! 
            ECHO To disable: cmd /c taskkill /F /IM !proc_name!
        )
    )
)

ENDLOCAL
echo ---------------
echo Created by Gabriel H. @weekndr_sec
echo "https://github.com/weekndr-sec | http://weekndr.me"
echo Adversary Emulation - T1059.003 - Local Antivirus Fingerprinting via Windows Command Shell [Situational Awareness]
echo ---------------