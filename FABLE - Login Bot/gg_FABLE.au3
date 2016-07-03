#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=source java.ico
#AutoIt3Wrapper_outfile=FABLE(W).exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;**** WRITTEN BY GEDIZ GURSU  21-6-2011*****
;*** WOW LOGIN AUTOMATION PROGRAM in AUTOIT ***
#include <WinAPI.au3>
#include <Array.au3>
#include <Date.au3>
#include <WindowsConstants.au3>
#include <gg_FABLESettings.au3>
#include <LoginWoW3.au3>
#include <gg_humanInputMimic.au3>
#include <gg_WowHBLoginPIDArray.au3>




wait($SystemStartupWaitTime)
CloseHBandWOW_SysRestartIn(10800) ; Use when running standalone

if WinExists("System Shutdown") then
	winMove("System Shutdown","",1000,1000,100,100,5)
EndIf
wait(10)

for $i=0 To $NumberOfAccounts-1 Step 1
	$j=0
	While ($j<$NumberOfExcludes) and not ($i=$Exclude[$j])
		$j=$j+1
	WEnd
	if  ($j=$NumberOfExcludes) Then
		BlockInput(1)
		StartVirtualWorker($i)
		;StartVirtualBanker($i)
		BlockInput(0)
	EndIf
Next

sleep(2147400000);dangles untill killed % 24 days sleep time no restart -Use With netcheck





