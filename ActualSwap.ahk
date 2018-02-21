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
	SetEnv, version, Version 2018-02-21-1142
	SetEnv, Author, LostByteSoft
	SetEnv, debug, 0
	SetEnv, icofolder, C:\Program Files\Common Files

	;; Specific Icons (or files)

	;; Common ico

	FileInstall, ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, ico_pause.ico, %icofolder%\ico_pause.ico, 0

	SetEnv, logoicon, ico_options.ico

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, %icofolder%\ico_options.ico
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), %icofolder%\ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

Start:
	Menu, Tray, Icon, %icofolder%\ico_options.ico

	RegRead, TestKey, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles
	IfEqual, TestKey,, SetEnv, TestKey, Disabled

	IfEqual, debug, 1, MsgBox, START :`n`nTestKey=%TestKey%


	;Gui, Add, Text, x25 y25 w550 h40 , Actual swap file is %TestKey%. Change value ?
	;Gui, Add, Button, x125 y175 w75 h40 , Yes
	;Gui, Add, Button, x225 y175 w75 h40 , No
	;Gui, Add, Button, x325 y175 w75 h40 , Preset
	;Gui, Show, h250 w550, %title% %mode%
	;Return



	;; Top lines
	Gui, Add, Text, x25 y5 w550 h40 , Actual swap file is %TestKey%.

	Gui, Add, Text, x200 y20 w300 h20 , Change value ?


	Gui, Add, Button, x50 y75 w75 h40 , Yes
	Gui, Add, Button, x50 y125 w75 h40 , No
	Gui, Add, Button, x50 y175 w75 h40 , Disable


	Gui, Add, Text, x170 y50 w35 h20 , Preset
	Gui, Add, Button, x150 y75 w75 h40 , Preset_4095
	Gui, Add, Button, x150 y125 w75 h40 , Preset_8192
	Gui, Add, Button, x150 y175 w75 h40 , Preset_12gb (ram+swap)
	Gui, Add, Text, x50 y225 w550 h20, Preset_12gb (ram+swap) : It will take the ram capacity and add swap to go to 12 gb.

	Gui, Add, Text, x270 y50 w35 h20 , Read
	Gui, Add, Button, x250 y75 w75 h40 , Read

	Gui, Add, Text, x570 y50 w35 h20 , Options
	Gui, Add, Button, x550 y75 w75 h40 , LogoIcon
	Gui, Add, Button, x550 y125 w75 h40 , Secret
	Gui, Add, Button, x550 y175 w75 h40 , Author
	Gui, Add, Button, x550 y225 w75 h40 , Exit
	Gui, Add, Button, x550 y275 w75 h40 , ReLoad

	Gui, Show, h320 w650, %title% %mode%
	Return

ButtonRead:
	;;RegRead, NewTestKey1, REG_SZ, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles
	RegRead, NewTestKey1, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles
	IfEqual, NewTestKey1,, SetEnv, NewTestKey, Disabled
	MsgBox, NewTestKey (or swap value) = %NewTestKey1%
	Goto, Start

ButtonYes:
change:
	InputBox, NewSwapSize, %title%, Insert new value size in MB. It will be c:\YourNewSize.swap !!! Only numbers !!! Exemple: 1024 or 2048 or 4096 or 8192
	IfEqual, debug, 1, MsgBox, CHANGE :`n`nNewSwapSize=%NewSwapSize%
	if ErrorLevel
		Goto, start
	IfEqual, NewSwapSize,, SetEnv, NewSwapSize, Disabled
	RegRead, TestKey2, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management ,PagingFiles
	MsgBox, 4, %title%, Old value = %TestKey2% : New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, changevalue
	IfMsgBox, NO, Goto, ExitApp

ButtonDisable:
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles,
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. Cancel apply changes but not reboot. New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, No, Goto, ExitApp

changevalue:
	IfEqual, NewSwapSize,, SetEnv, NewSwapSize, Disabled
	IfEqual, debug, 1, MsgBox, CHANGEVALUE :`n`n NewSwapSize=%NewSwapSize%`n`n Writen data C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. Cancel apply changes but not reboot. New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, No, Goto, ExitApp

ButtonPreset_4095:
	SetEnv, NewSwapSize, C:\PagingFiles.swp 4095 4095
	IfEqual, debug, 1, MsgBox, Total Physical Memory 12gb=%12gb% TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. Cancel apply changes but not reboot. New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

ButtonPreset_8192:
	SetEnv, NewSwapSize, C:\PagingFiles.swp 8192 8192
	IfEqual, debug, 1, MsgBox, Total Physical Memory 12gb=%12gb% TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. Cancel apply changes but not reboot. New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

ButtonPreset_12gb(ram+swap):
	;; https://autohotkey.com/board/topic/33622-report-physical-ram-installed/#entry213392
	Gui, destroy
	VarSetCapacity( MEMORYSTATUSEX,64,0 ), NumPut( 64,MEMORYSTATUSEX ) 
	DllCall( "GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX )
	TotalPhys := NumGet( MEMORYSTATUSEX,8,"Int64"),   VarSetCapacity( PhysMem,16,0 )
	DllCall( "shlwapi.dll\StrFormatByteSize64A", Int64,TotalPhys, Str,PhysMem, UInt,16 )
	;; StrFormatByteSize64 : http://msdn.microsoft.com/en-us/library/bb759971(VS.85).aspx
	;;MsgBox, 64, Total Physical Memory, %TotalPhys% Bytes`n= %PhysMem%
	MsgBox, 64, Total Physical Memory, TotalPhys = %TotalPhys% Bytes`n`nThe preset valut set swap to 12 gb (ram + swap = 12 gb)
	;; 4236345344
	;; 12288000000
	;; max swap 16777216
	SetEnv, 12gb, 13288000000
	12gb -= TotalPhys
	;;12gb *= -1
	SetEnv, NewSwapSize, %12gb%
	NewSwapSize /= 1000000
	IfEqual, debug, 1, MsgBox, Total Physical Memory 12gb=%12gb% TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. Cancel apply changes but not reboot. New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

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
	Menu, Tray, Icon, %icofolder%\%logoicon%
	SetEnv, pause, 0
	Goto, start

	sleep:
	Menu, Tray, Icon, %icofolder%\ico_pause.ico
	sleep2:
	sleep, 500000
	goto, sleep2

;;--- Quit (escape , esc) ---

ButtonNo:
ButtonQuit:
ButtonExit:
	Gui, destroy
	goto, ExitApp

ButtonReload:
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

ButtonSecret:
secret:
	RegRead, NewTestKey, REG_SZ, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles
	IfEqual, NewTestKey,, SetEnv, NewTestKey, Disabled
	MsgBox, 64, WMC Fit Screen, All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author%.`n`nNewTestKey=%NewTestKey%
	Return

version:
	TrayTip, %title%, %version%, 2, 2
	Sleep, 500
	Return

ButtonAuthor:
author:
		MsgBox, 64, %title%, %title% %mode% %version% %author% This software is usefull to ....`n`n`tGo to https://github.com/LostByteSoft
		Return

ButtonLogoIcon:
GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	;;Gui, 4:Color, 000000
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