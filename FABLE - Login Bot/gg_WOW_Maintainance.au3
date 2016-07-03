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

func WOWEnvCheckAndMaintainance()

If not FileExists("D:\WORKBENCH 1") Then
	MsgBox(0, "WOW ENV Check", "Folder:(D:\WORKBENCH 1) does not exist, Quitting in 10 seconds",10)
	Exit
EndIf

If not FileExists("D:\WORKBENCH 1\World of Warcraft") Then
	MsgBox(0, "WOW ENV Check", "Folder:(D:\WORKBENCH 1\World of Warcraft) does not exist, Quitting in 10 seconds",10)
	Exit
EndIf

If not FileExists("D:\WORKBENCH 1\HB") Then
	MsgBox(0, "WOW ENV Check", "Folder:(D:\WORKBENCH 1\HB) does not exist, Quitting in 10 seconds",10)
	Exit
EndIf

If not FileExists("D:\WORKBENCH 1\HB") Then
	MsgBox(0, "WOW ENV Check", "Folder:(D:\WORKBENCH 1\HB) does not exist, Quitting in 10 seconds",10)
	Exit
EndIf

If not FileExists("C:\Program Files (x86)\HMA! Pro VPN\bin\HMA! Pro VPN.exe") Then
	MsgBox(0, "WOW ENV Check", "HIDE MY ASS HMA VPN is NOT Installed Ignore if you use other VPN \n will continue in 10 seconds",10)
EndIf

MsgBox(0, "WOW FOLDER MAINTAINANCE", "Cleaning WTF(Account) Folder",1)
DirRemove("D:\WORKBENCH 1\World of Warcraft\WTF\Account\",1)
MsgBox(0, "WOW FOLDER MAINTAINANCE", "Cleaning Logs Folder",1)
FileDelete("D:\WORKBENCH 1\World of Warcraft\Logs\*.*")
MsgBox(0, "WOW FOLDER MAINTAINANCE", "Cleaning Errors Folder",1)
FileDelete("D:\WORKBENCH 1\World of Warcraft\Errors\*.*")
MsgBox(0, "WOW FOLDER MAINTAINANCE", "Cleaning Screenshot Folder",1)
FileDelete("D:\WORKBENCH 1\World of Warcraft\Screenshots\*.*")
MsgBox(0, "WOW FOLDER MAINTAINANCE", "Cleaning Cache(Item costs,NPC dialogs,Trackable Activities) Folder",1)
DirRemove("D:\WORKBENCH 1\World of Warcraft\Cache\ADB\",1)
DirRemove("D:\WORKBENCH 1\World of Warcraft\Cache\WDB\",1)
MsgBox(0, "WOW FOLDER MAINTAINANCE", "Cleaning Interface\Addons Folder",1)
DirRemove("D:\WORKBENCH 1\World of Warcraft\Interface\AddOns\",1)

MsgBox(0, "WOW FOLDER MAINTAINANCE", "Cleaning WTF(Account) Folder",1)
DirRemove("D:\WORKBENCH 1\World of Warcraft\WTF\Account\",1)

EndFunc


