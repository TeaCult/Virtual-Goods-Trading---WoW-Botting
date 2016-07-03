#include <WinAPI.au3>
#include <Array.au3>
#include <Date.au3>
#include <WindowsConstants.au3>
#include <gg_constants.au3>
#include <gg_humanInputMimic.au3>
#include <gg_WowHBLogin.au3>
#include <gg_DependentSession.au3>


	$position = WinGetPos("World of Warcraft")
	WinActivate("World of Warcraft")
	MouseMove($position[0] + 620, $position[1] + 65, 21) ;Window Pos + 620 69
	SleepRandomSecs(3)
	$checkPixel = PixelGetColor($position[0] + 620, $position[1] + 65)
	;if $checkPixel==15717120 Then
	MsgBox(64,"",$checkPixel,120)


;##########################################################################
;##########################################################################
Func ScanCurrentImagePixels($x1, $x2, $y1, $y2, $winPtr)
	Dim $myString[$x2 + 1][$y2 + 1]
	For $x = $x1 To $x2 Step 1
		For $y = $y1 To $y2 Step 1
			$val = PixelGetColor($x, $y, $winPtr)
			$myString[$x][$y] = "x=" & $x & " y=" & $y & " pixelColor=" & $val
		Next
	Next
	_ArrayDisplay($myString, "Pixel Scan")
EndFunc   ;==>ScanCurrentImagePixels
;##########################################################################
;##########################################################################