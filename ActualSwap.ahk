;;--- Head --- Informations --- AHK ---

;;	Compatibility: Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	Use as a developpement tool for AHK
;;	This entire thing (work) is a developpement tool for AHK scripting.
;;	Use an external DLL file for icon is shit load of job and the final quality is less.

;;--- Softwares Variables ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2

	SetEnv, title, ActualSwap
	SetEnv, mode, Get the actual size of the page file.
	SetEnv, version, Version 2017-11-24-1258
	SetEnv, Author, LostByteSoft
	SetEnv, logoicon, ico_options.ico
	SetEnv, debug, 0

	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_debug.ico, ico_debug.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, ico_options.ico
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), ico_pause.ico
	Menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

Start:
	Menu, Tray, Icon, ico_options.ico

	RegRead, TestKey, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management ,PagingFiles
	IfEqual, debug, 1, MsgBox, START :`n`nTestKey=%TestKey%
	IfEqual, TestKey,, SetEnv, TestKey, DISABLED
	MsgBox, 4, %title%, Actual swap file is %TestKey%.`n`n`tChange value ?
	IfMsgBox, Yes, Goto, change
	goto, ExitApp

change:
	InputBox, NewSwapSize, %title%, Insert new value size in MB. It will be c:\YourNewSize.swap !!! Only numbers !!! Exemple: 1024 or 2048 or 4096 or 8192
	IfEqual, debug, 1, MsgBox, CHANGE :`n`nNewSwapSize=%NewSwapSize%
	if ErrorLevel
		Goto, ExitApp
	IfEqual, NewSwapSize,, SetEnv, NewSwapSize, Disabled
	RegRead, TestKey2, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management ,PagingFiles
	MsgBox, 4, %title%, Old value = %TestKey2% : New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, changevalue
	IfMsgBox, NO, Goto, ExitApp

changevalue:

	IfEqual, NewSwapSize, Disabled, SetEnv, NewSwapSize,
	IfEqual, debug, 1, MsgBox, CHANGEVALUE :`n`n NewSwapSize=%NewSwapSize%`n`n Writen data C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	MsgBox, 1, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. Cancel apply changes but not reboot.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, CANCEL, Goto, ExitApp

;;--- Debug Pause ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0

	debug0:
	SetEnv, debug, 0
	TrayTip, %title%, Deactivated ! debug=%debug%, 1, 2
	Goto, Start

	debug1:
	SetEnv, debug, 1
	TrayTip, %title%, Activated ! debug=%debug%, 1, 2
	Goto, Start

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused

	paused:
	SetEnv, pause, 1
	goto, sleep

	unpaused:	
	Menu, Tray, Icon, %logoicon%
	SetEnv, pause, 0
	Goto, start

	sleep:
	Menu, Tray, Icon, ico_pause.ico
	sleep2:
	sleep, 500000
	goto, sleep2

;;--- Quit (escape , esc) ---

ButtonQuit:
	Gui, destroy
	goto, ExitApp

doReload:
	Gui, destroy
	Reload
	sleep, 500

ESCAPE::
ExitApp:
	Gui, destroy
	ExitApp

reboot:
	Shutdown, 6
	exit

;;--- Tray Bar (must be at end of file) ---

about:
	TrayTip, %title%, %mode% by %author%, 2, 1
	Sleep, 500
	Return

secret:
	RegRead, NewTestKey, REG_SZ, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles
	MsgBox, 64, WMC Fit Screen, All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author%.`n`nNewTestKey=%NewTestKey%
	Return

version:
	TrayTip, %title%, %version%, 2, 2
	Sleep, 500
	Return

ButtonAuthor:
	author:
		MsgBox, 64, %title%, %title% %mode% %version% %author% This software is usefull to place automaticly a windows in a specified resolutionand use as a developpement tool for AHK. Usefull for windows doesn't have the ability to do this.`n`n`tGo to https://github.com/LostByteSoft
		Return


GuiLogo:
	Ico_common := A_ScriptDir . "\Ico_common.dll"
	Gui, 4:Add, Picture, x25 y25 w400 h400 Icon8 AltSubmit, %Ico_common%
	Gui, 4:Show, w450 h450, %title% Logo
	Gui, 4:Color, 000000
	Sleep, 500
	Return

4GuiClose:
	Gui 4:Cancel
	return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;		     NO FUCKING WARRANTY AT ALL
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;      LostByteSoft no copyright or copyleft we are in the center.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---