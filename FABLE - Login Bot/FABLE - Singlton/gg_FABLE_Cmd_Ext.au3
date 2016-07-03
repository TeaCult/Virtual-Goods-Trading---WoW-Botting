#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=source java.ico
#AutoIt3Wrapper_outfile=FL.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;**** WRITTEN BY GEDIZ GURSU  21-6-2011*****
;*** WOW LOGIN AUTOMATION PROGRAM in AUTOIT ***
#include <WinAPI.au3>
#include <Array.au3>
#include <Date.au3>
#include <WindowsConstants.au3>


$SPEED = 3;
$WRITINGSPEED = 2;
$LONGSLEEP = 30 / $SPEED;
$MIDSLEEP = 15 / $SPEED;
$SHORTSLEEP = 5 / $SPEED;
$ONESEC = 1 / $SPEED;
$KeyPixelColor1 = 14180386
$Width =150
$Height=175

#include <gg_humanInputMimic.au3>


$Acc=$CmdLine[1]
$Pass=$CmdLine[2]

StartVirtualWorker($Acc,$Pass)

Func StartVirtualWorker($Acc,$Pass)
	$WowPid=RunWowInLowRes($Acc,$Pass)
	LogInToWOW($Acc,$Pass)
	ChangeRealmAndLogInTo(1,1)
	;$WowPositionsX[$Wowindex]=Mod($WowIndex,6)*$Width
	;$WowPositionsY[$Wowindex]=Floor($Wowindex/6)*$Height
	;WinMove("", "", $WowPositionsX[$Wowindex], $WowPositionsY[$Wowindex], $Width, $Height, 10)
	$HBPid=RunStartPositionAndMinimizeHB($WowPid)
EndFunc  ;==>StartVirtualWorker

Func RunWowInLowRes($Acc,$Pass)
	$WowPID=Run("""D:\WORKBENCH 1\World of Warcraft\Wow.exe""" & " -console")
	Wait($SHORTSLEEP)
	WinSetTitle("World","",$Acc)
	WinSetOnTop($Acc,"",1)
	WinActivate($Acc)
	SendKeepActive($Acc)

	SleepRandomSecs($MIDSLEEP)
	WriteLikeHuman("`")
	SleepRandomSecs($ONESEC)
	WriteLikeHuman("gxResolution 720x576")
	SleepRandomSecs($ONESEC)
	SendLikeHuman("{ENTER}")
	WriteLikeHuman("gxRestart")
	SleepRandomSecs($ONESEC)
	SendLikeHuman("{ENTER}")
	SleepRandomSecs($SHORTSLEEP)
	WriteLikeHuman("`")
	Return $WowPID
EndFunc   ;==>RunWowInLowRes

Func LogInToWOW($Acc,$Pass)
	$UserName=$Acc
	$Password=$Pass
	SleepRandomSecs($SHORTSLEEP)
	WriteLikeHuman($UserName)
	SleepRandomSecs($ONESEC)
	SendLikeHuman("{TAB}")
	SleepRandomSecs($ONESEC)
	WriteLikeHuman($Password)
	SleepRandomSecs($ONESEC)
	SendLikeHuman("{ENTER}")
	SleepRandomSecs($MIDSLEEP)
	TwoRealmsFix($UserName,"uyelikonbir@hotmail.com")
	WinSetOnTop($Acc,"",0)

EndFunc   ;==>LogInToWOW

Func RunStartPositionAndMinimizeHB($WowPid)
	$HBPID=Run("""D:\WORKBENCH 1\HB\Honorbuddy.exe"" /autostart /pid="& $WowPid,"D:\WORKBENCH 1\HB\")
	$HBWinHandle=WinGetHandle("buddy")
	SleepRandomSecs($SHORTSLEEP)
	WinSetState("", "", @SW_MINIMIZE)
	SleepRandomSecs($SHORTSLEEP)
	Return $HBPID
EndFunc   ;==>RunStartPositionAndMinimizeHB

Func ChangeRealmAndLogInTo($thRealm,$thWorker) ; does not work after 9 th worker
	;Changing Realm ;Change Realm Pos 	643 306 Window Pos 		352 128  First Realm Pos 	703 303 New Character Pixel Color 15717120
	$position = WinGetPos("World of Warcraft")
	MouseMove($position[0] + 620, $position[1] + 65, 21) ;Window Pos + 620 69
	SleepRandomSecs(3)
	$checkPixel = PixelGetColor($position[0] + 620, $position[1] + 65)
	;if $checkPixel==15717120 Then
	If $checkPixel > $KeyPixelColor1-10000 And $checkPixel < $KeyPixelColor1 +10000 Then
		SendLikeHuman("{ESC}")
	EndIf
	SleepRandomSecs($SHORTSLEEP)
	MouseClick("left")
	SleepRandomSecs($SHORTSLEEP)
	MouseMove($position[0] + 350, $position[1] + 165+15*($thRealm-1), 29) ;Window Pos + 620 69
	SleepRandomSecs($SHORTSLEEP)
	MouseClick("left")
	MouseClick("left")
	SleepRandomSecs($SHORTSLEEP)
	MouseMove($position[0] + 620, $position[1] + 90+45*($thWorker-1), 21) ;Window Pos + 620 69
	SleepRandomSecs($SHORTSLEEP)
	MouseClick("left")
	MouseClick("left")
	SleepRandomSecs($LONGSLEEP)
EndFunc

Func TwoRealmsFix($UserName,$UserNameWithTwoRealms)
	If $UserName== $UserNameWithTwoRealms Then
		SendLikeHuman("{ENTER}")
		SleepRandomSecs($MIDSLEEP)
	EndIf
EndFunc
;#################################################
;#################################################
;Human Input Mimicing Functions

Func SleepRandomSecs($Secs)
	Sleep($Secs * (900 + Floor(Random(0, 200))))
EndFunc   ;==>SleepRandomSecs
;##########################################################################
Func Wait($var) ;encapsulation
	SleepRandomSecs($var)
EndFunc   ;==>Wait
;##########################################################################
Func WriteLikeHuman($aString)
	For $i = 1 To StringLen($aString) Step 1
		;Changing Stroke Delays
		Opt("SendKeyDelay", 6/$WRITINGSPEED + Floor(Random(0, 14/$WRITINGSPEED))) ;5 milliseconds
		Opt("SendKeyDownDelay", 12/$WRITINGSPEED + Floor(Random(0, 21/$WRITINGSPEED))) ;1 millisecond
		;Mistype
		$isATypo = Floor(Random(0, 35));
		If $isATypo == 32 Then
			SendLikeHuman(String(StringMid($aString, $i - 1, 2)))
			Sleep(270/$WRITINGSPEED+ Floor(Random(0, 162/$WRITINGSPEED)))
			SendLikeHuman("{BACKSPACE}")
			Sleep(20/$WRITINGSPEED + Floor(Random(0, 10/$WRITINGSPEED)))
			SendLikeHuman("{BACKSPACE}")
		EndIf
		;Type key by key
		$keyToSend = StringMid($aString, $i, 1)
		SendLikeHuman(String($keyToSend))

	Next
EndFunc   ;==>WriteLikeHuman
;##########################################################################
Func SendLikeHuman($aString)
	Wait(0.05)
	Send($aString)
EndFunc   ;==>SendLikeHuman
;##########################################################################
;NEEDS TO BE FURTHER DEVELOPED
;##########################################################################
Func MouseMoveLikeHuman($xLocation, $yLocation, $SPEED)
	MouseMove($xLocation + Random(5, 10), $yLocation + Random(5, 10), $SPEED)
	Wait(0.1)
	MouseMove($xLocation, $yLocation, $SPEED)
EndFunc   ;==>MouseMoveLikeHuman
;##########################################################################
Func MouseClickLikeHuman()
EndFunc   ;==>MouseClickLikeHuman