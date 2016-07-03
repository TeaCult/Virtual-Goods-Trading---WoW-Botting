#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=source java.ico
#AutoIt3Wrapper_outfile=NetCheck.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;**** WRITTEN BY GEDIZ GURSU  21-6-2011*****
;*** WOW LOGIN AUTOMATION PROGRAM in AUTOIT ***
#include <WinAPI.au3>
#include <Array.au3>
#include <Date.au3>
#include <WindowsConstants.au3>


$Connected=True;

while($Connected)
#cs	if(NOT Ping("www.google.com",20000)) Then
		CloseHBandWOW_SysRestartIn(60)
		$Connected=False;
	EndIf
#ce

	if NOT(ProcessExists("FABLE(B).exe")) AND isBankingTime() Then
		KillFableClones()
		KillWoWandHBandScheduleRestart()
		sleep(60)
		Run("D:\WORKBENCH 1\FABLE(B).exe")
	Endif

	If NOT(ProcessExists("FABLE(W).exe")) AND (NOT isBankingTime()) Then
		KillFableClones()
		KillWoWandHBandScheduleRestart()
		sleep(60)
		Run("D:\WORKBENCH 1\FABLE(W).exe")
	EndIf
WEnd
;########################################################################
Func isBankingTime()
	$temp1 = _Date_Time_GetLocalTime()
	$localtime = _Date_Time_SystemTimeToTimeStr($temp1)
		If $localtime> "18:00:00" And $localtime < "19:30:00" Then
			Return true;
		Else
			Return False
		EndIf
EndFunc
;##########################################################################
Func KillFableClones()
	RunWait('"' & @ComSpec & '" /c taskkill /F /T /IM FABLE(B).exe', '', @SW_HIDE)
	RunWait('"' & @ComSpec & '" /c taskkill /F /T /IM FABLE(W).exe', '', @SW_HIDE)
EndFunc
;##########################################################################
Func KillWoWandHBandScheduleRestart()
	RunWait('"' & @ComSpec & '" /c taskkill /F /T /IM wow.exe', '', @SW_HIDE)
	RunWait('"' & @ComSpec & '" /c taskkill /F /T /IM honorbuddy.exe', '', @SW_HIDE)
	RunWait('"' & @ComSpec & '" /c shutdown /a', '', @SW_HIDE)
	RunWait('"' & @ComSpec & '" /c shutdown /f /r /t 108000', '', @SW_HIDE)
EndFunc
;##########################################################################
