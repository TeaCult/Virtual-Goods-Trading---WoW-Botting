#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=source java.ico
#AutoIt3Wrapper_outfile=nets.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;**** WRITTEN BY GEDIZ GURSU  21-6-2011*****
;*** WOW LOGIN AUTOMATION PROGRAM in AUTOIT ***
#include <WinAPI.au3>
#include <Array.au3>
#include <Date.au3>



CheckNetwork()
;###################################
;###################################
Func CheckKeybLayout()
if Not(String(@KBLayout)=="00000409") Then
	MsgBox(0,@KBLayout,"Please change your keyboard layout to English",99999)
EndIf
EndFunc
;###################################
;###################################
Func CheckNetwork()
	$Str="winmgmts:\\localhost\root\CIMV2"
	$objWMI = ObjGet($Str)
	$objItems = $objWMI.ExecQuery("SELECT * FROM CIM_NetworkAdapter", "WQL", 0x10 + 0x20)

	$wbemFlagReturnImmediately = 0x10
	$wbemFlagForwardOnly = 0x20
	dim $Adress

		If IsObj($objItems) Then
		For $objItem In $objItems
			$val=$objItem.NetworkAddresses
		Next
		EndIf
MsgBox(0,"test","Value:"& $val & @CRLF,5)

EndFunc
;###################################
;###################################


		; "Number Of WOWs machine can run: " & $canRunSimul

; Change KB L using WMI later
;CheckChange Windows UI (No Visual Enchantments)
;CheckChange Admin Privillages on Wow - FABLE and HB
;CheckChange
;Exit(0)
