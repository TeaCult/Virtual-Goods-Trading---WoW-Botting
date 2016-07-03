; WOW - HB Login Funcs
dim $WOWPIDS[100];
dim $HBPIDS[100];
dim $WowPositionsX[100]
dim $WowPositionsY[100]
$SessionNumber=0;
$WowPositionsX[0]=0;
$WowPositionsY[0]=0;

;##########################################################################
;##########################################################################
;##########################################################################
;##########################################################################
Func CacheWowAndHbByLoadingOnce()
	Run("D:\WORKBENCH 1\World of Warcraft\Wow.exe")
	WinWaitActive("World")
	wait(20)
	Run("""D:\WORKBENCH 1\HB\Honorbuddy.exe"" /autostart")
	wait(5)
	RunWait('"' & @ComSpec & '" /c taskkill /F /T /IM Wow.exe', '', @SW_HIDE)
	RunWait('"' & @ComSpec & '" /c taskkill /F /T /IM Honorbuddy.exe', '', @SW_HIDE)
EndFunc
;##########################################################################
Func CloseHBandWOW_SysRestartIn($DurationSecs)
	RunWait('"' & @ComSpec & '" /c taskkill /F /T /IM Wow.exe', '', @SW_HIDE)
	RunWait('"' & @ComSpec & '" /c taskkill /F /T /IM Honorbuddy.exe', '', @SW_HIDE)
	Run("shutdown /a")
	Run("shutdown /f /r /t "& $DurationSecs)
	wait($SHORTSLEEP)

EndFunc
;##########################################################################
;##########################################################################
;################################################################
;##########################################################################

;##########################################################################
Func StartVirtualWorker($Wowindex)
	$WowPid=RunWowInLowRes()
	LogInToWOW($Wowindex)
	ChangeRealmAndLogInTo(1,1)

	$WowPositionsX[$Wowindex]=Mod($WowIndex,6)*$Width
	$WowPositionsY[$Wowindex]=Floor($Wowindex/6)*$Height
	WinMove("", "", $WowPositionsX[$Wowindex], $WowPositionsY[$Wowindex], $Width, $Height, 10)
	$UserName=$UserNames[$Wowindex]
	WinSetTitle("World","",$UserName)

	$HBPid=RunStartPositionAndMinimizeHB($WowPid,$Wowindex)
	$WowPIDS[$Wowindex]=$WowPid
	$HBPIDS[$Wowindex]=$HBPid
EndFunc  ;==>StartVirtualWorker
;##########################################################################
;##########################################################################
Func StartVirtualBanker($Wowindex)
	$WowPid=RunWowInLowRes()
	LogInToWOW($Wowindex)
	ChangeRealmAndLogInTo(1,2) ; ONLY th WORKER in First REALM Changes compared to StartVirtualWorker Func
	$WowPositionsX[$Wowindex]=Mod($WowIndex,6)*$Width
	$WowPositionsY[$Wowindex]=Floor($Wowindex/6)*$Height
	WinMove("", "", $WowPositionsX[$Wowindex], $WowPositionsY[$Wowindex], $Width, $Height, 10)
	wait($SHORTSLEEP)
	$HBPid=RunStartPositionAndMinimizeHB($WowPid,$WowIndex)
	wait($SHORTSLEEP)
	$WowPIDS[$Wowindex]=$WowPid
	$HBPIDS[$Wowindex]=$HBPid
EndFunc   ;==>StartVirtualBanker
;##########################################################################
;##########################################################################
Func RunWowInLowRes()
	$WowPID=Run("""D:\WORKBENCH 1\World of Warcraft\Wow.exe""" & " -console")
	WinWaitActive("World")
	SleepRandomSecs($MIDSLEEP)
	$WowWinHandle=WinGetHandle(WinActive("World"))
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
;##########################################################################
Func TwoRealmsFix($UserName,$UserNameWithTwoRealms)
	If $UserName== $UserNameWithTwoRealms Then
		SendLikeHuman("{ENTER}")
		SleepRandomSecs($MIDSLEEP)
	EndIf
EndFunc
	;##########################################################################
Func LogInToWOW($Wowindex)
	$UserName=$UserNames[$Wowindex]
	$Password=$Passwords[$Wowindex]
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
EndFunc   ;==>LogInToWOW
;##########################################################################
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
;##########################################################################
Func RunStartPositionAndMinimizeHB($WowPid,$WowIndex)
	$hbstr="""D:\WORKBENCH 1\HB\Honorbuddy.exe"" /pid="& $WowPid
	$HBPID=Run("""D:\WORKBENCH 1\HB\Honorbuddy.exe""  /pid="&$WowPid,"D:\WORKBENCH 1\HB\")
	;ShellExecute($hbstr)
	;$HBPID=WinGetProcess("buddy")
	SleepRandomSecs($MIDSLEEP)


	$positionBL = WinGetPos(WinGetTitle("[active]"))
	;MsgBox(0, String($positionBL[0])&" "&String($positionBL[1]), "Checking",5)
	MouseMove($positionBL[0] + 153, $positionBL[1] + 96, 21) ;Login Window Pos  496 290 / login button 649 386
	SleepRandomSecs($ONESEC)
	MouseClick("left")
	SleepRandomSecs($SHORTSLEEP)




	$posX=Mod($WowIndex,6)*$Width
	$posY=Floor($Wowindex/6)*$Height
	WinMove(WinGetTitle("[active]"), "", $posX, $posY+100, 400, 400, 10)
	wait($SHORTSLEEP)

	$positionBS = WinGetPos(WinGetTitle("[active]"))
	MouseMove($positionBS[0] + 322, $positionBS[1] + 358, 21) ;HB Window Pos  204 173 / Start button 526 531
	SleepRandomSecs($ONESEC)
	MouseClick("left")
	SleepRandomSecs($SHORTSLEEP)

	$UserName=$UserNames[$Wowindex]
	WinSetTitle(WinGetTitle("[active]"),"",$UserName&" buddy")
	SleepRandomSecs($SHORTSLEEP)

	WinSetState(WinGetTitle("[active]"), "", @SW_MINIMIZE)
	SleepRandomSecs($SHORTSLEEP)
	Return $HBPID
EndFunc   ;==>RunStartPositionAndMinimizeHB
;##########################################################################