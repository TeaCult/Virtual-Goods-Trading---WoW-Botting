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


;SOURCES
;http://msdn.microsoft.com/en-us/library/aa377522%28VS.85%29.aspx
;http://msdn.microsoft.com/en-us/library/ms679360%28v=VS.85%29.aspx
;http://msdn.microsoft.com/en-us/library/aa377542%28VS.85%29.aspx
;http://www.autoitscript.com/forum/topic/83348-check-internet-connection/ ---PIECE OF BULLSHIP :P

Sleep(45) ; 45 seconds sleep 45000ms
$Connected=True;

while($Connected)
sleep(300);Drastically improves performance -----DONT REMOVE------
$connect = _GetNetworkConnect()
If $connect Then
    MsgBox(64, "Connections", $connect)
Else
    MsgBox(48, "Warning", "There is no connection")
			$Connected=False;
EndIf
WEnd

#cs
Func _GetNetworkConnect()
    Local Const $NETWORK_ALIVE_LAN = 0x1 ;net card connection ;http://msdn.microsoft.com/en-us/library/aa377542%28VS.85%29.aspx
    Local Const $NETWORK_ALIVE_WAN = 0x2 ;RAS (internet) connection

    Local $aRet, $iResult

    $aRet = DllCall("sensapi.dll", "Bool", "IsNetworkAlive","void",$NETWORK_ALIVE_WAN, 0)
	msgbox(0,"",$aRet,5)
	if (not _WinAPI_GetLastError()) and $aRet Then
		$iResult="RAS(WAN) is Connected"
	Else
		$iResult="RAS(WAN) is not Connected"
	return $iResult
	EndIf
EndFunc
#ce


Func _GetNetworkConnect()
	if @error==0 and (_WinAPI_IsNetworkAlive()) Then
		return("RAS is connected")
	Else
		return("RAS is not connected")
	EndIf

EndFunc

Func _WinAPI_IsNetworkAlive()

	Local $Ret = DllCall('sensapi.dll', 'int', 'IsNetworkAlive', 'int*', 0)

	If (@error) Or (Not $Ret[0]) Or (_WinAPI_GetLastError()) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[1]
EndFunc   ;==>_WinAPI_IsNetworkAlive


;##########################################################################
