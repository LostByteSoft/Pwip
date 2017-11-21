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

	SetEnv, title, Pwip
	SetEnv, mode, Put Windows In Place. AHK developpement tool.
	SetEnv, version, Version 2017-11-15-1506
	SetEnv, Author, LostByteSoft
	SetEnv, logoicon, Ico_Windows.ico

	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2

	FileInstall, ico_Windows.ico, ico_Windows.ico, 0
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_debug.ico, ico_debug.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0
	;; FileInstall, Ico_common.dll, Ico_common.dll, 0			; Space wasted.

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
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, ico_options.ico
	menu, tray, add
	menu, tray, add, Get the Win Resolution, ShowWinRes
	menu, tray, add, Get the Scr Resolution, ShowScrRes
	menu, tray, add, Get the Work Resolution, ShowWorkArea
	menu, tray, add
	menu, tray, add, Show Gui, start
	Menu, Tray, Icon, Show Gui, %logoicon%
	menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

	TrayTip, %title%, %title% L win + Z, 2, 1

	goto, sleep2

<#Z::
start:
	Menu, Tray, Icon, %Ico_common%,8
	Gui, destroy
	IfEqual, reimage, 1, SetEnv, checked, checked

	;; Top lines
	Gui, Add, Text, x25 y5 w550 h40 , Click on a resolution you want AND click on a windows you want to be resize. MonitorCount=%MonitorCount% MonitorPrimary=%MonitorPrimary%

	Gui, Add, Checkbox, x25 y20 w125 h20 vReImage %checked%, Do not close GUI.

	Gui, Add, Text, x200 y20 w300 h20 , Screen 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%
	IfEqual, MonitorCOunt, 1, goto, 1monitor
	Gui, Add, Text, x200 y33 w300 h20 , Screen 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%
	Goto, 2monitors
	1monitor:
	Gui, Add, Text, x200 y33 w300 h20 , Screen 2 is not installed.
	2monitors:

	;; 1 col
	Gui, Add, Text, x70 y50 w35 h20 , 4 / 3
	Gui, Add, Button, x50 y75 w75 h30 , 640x480
	Gui, Add, Button, x50 y125 w75 h30 , 800x600
	Gui, Add, Button, x50 y175 w75 h30 , 1024x768
	Gui, Add, Button, x50 y225 w75 h30 , 1152x864
	Gui, Add, Button, x50 y275 w75 h30 , 1600x1200

	;; 2 col
	Gui, Add, Text, x170 y50 w35 h20 , 16 / 9
	Gui, Add, Button, x150 y75 w75 h30 , 1280x720
	Gui, Add, Button, x150 y125 w75 h30 , 1360x768
	; Space for 1366x768
	Gui, Add, Button, x150 y225 w75 h30 , 1600x900
	Gui, Add, Button, x150 y275 w75 h30 , 1920x1080

	;; 3 col
	Gui, Add, Text, x270 y50 w35 h20 , 16 / 10
	Gui, Add, Button, x250 y75 w75 h30 , 1680x1050
	Gui, Add, Text, x275 y160 w40 h20 , Vary
	Gui, Add, Button, x250 y175 w38 h30 , 1/2 L
	Gui, Add, Button, x287 y175 w38 h30 , 1/2 R
	Gui, Add, Button, x250 y225 w75 h30 , FitToScreen

	;; 4 col
	Gui, Add, Text, x370 y50 w50 h20 , Exe call
	Gui, Add, Button, x350 y75 w75 h30 , HddTemp
	Gui, Add, Button, x350 y125 w75 h30 , WindowInfo
	Gui, Add, Button, x350 y175 w75 h30 , ProcestList
	Gui, Add, Button, x350 y225 w75 h30 , Actual Swap

	;; 5 col x450

	Gui, Add, Text, x470 y50 w35 h20 , Get the
	Gui, Add, Button, x450 y75 w75 h30 , Win_Res
	Gui, Add, Button, x450 y125 w75 h30 , Scr_Res
	Gui, Add, Button, x450 y175 w75 h30 , Scr_Wrk

	;; 6 col x550

	Gui, Add, Text, x570 y50 w35 h20 , Options
	Gui, Add, Button, x550 y75 w75 h30 , LogoIcon
	Gui, Add, Button, x550 y125 w75 h30 , Secret
	Gui, Add, Button, x550 y175 w75 h30 , Author
	Gui, Add, Button, x550 y225 w75 h30 , Icon_Viewer
	Gui, Add, Button, x550 y275 w75 h30 , ReLoad

	Gui, Show, h320 w650, %title% %mode%
	Return

;;--- Resolutions ---

Button640x480:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 640, 480
	WinActivate, %activeWindow%
	Goto, sleep2

Button800x600:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 800, 600
	WinActivate, %activeWindow%
	Goto, sleep2

Button1024x768:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 1024, 768
	WinActivate, %activeWindow%
	Goto, sleep2

Button1152x864:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 1152, 864
	WinActivate, %activeWindow%
	Goto, sleep2

Button1280x720:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 1280, 720
	WinActivate, %activeWindow%
	Goto, sleep2

Button1360x768:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 1360, 768
	WinActivate, %activeWindow%
	Goto, sleep2

Button1600x900:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 1600, 900
	WinActivate, %activeWindow%
	Goto, sleep2

Button1600x1200:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 1600, 1200
	WinActivate, %activeWindow%
	Goto, sleep2

Button1680x1050:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 1680, 1050
	WinActivate, %activeWindow%
	Goto, sleep2

Button1920x1080:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , , , 1920, 1080
	WinActivate, %activeWindow%
	Goto, sleep2

ButtonFitToScreen:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	SysGet, Mon10, MonitorWorkArea
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , 0, 0, %Mon10Right%, %Mon10Bottom%
	WinActivate, %activeWindow%
	Goto, sleep2

ButtonIcon_Viewer:
	;; This is a developpement version for an DLL file icons library. This is not really implemented.
	SetEnv, icons, 1
	;;GuiControlGet, ReImage,, Reimage
	;;IfEqual, reimage, 0, Gui, destroy
	Gui, destroy
	nexticon2:
	Ico_common := A_ScriptDir . "\Ico_common.dll"					; Icon path
	Gui, Font, s10
	Gui, Add, Text, x275 y10 cBlack, A_ScriptDirr=%A_ScriptDir%
	Gui, Add, Text, x357 y25 cBlack, Icons Number=%Icons% 
	Gui, Add, Picture, x25 y60 w400 h400 Icon%icons% AltSubmit, %Ico_common%		; you can add X20 Y20 for position AND Icon1 means that the first icon of the DLL or EXE
	Gui, Font, s14
	Gui, Add, Button, x5 y5 w75 , Next
	Gui, Add, Button, x90 y5 w75 , Tray
	Gui, Add, Button, x175 y5 w75 , Menu
	Gui, Add, Picture, Icon50, "%A_ScriptDir%"\Ico_common.dll
	Gui, Show, , %title% Logo
	Gui, Color, add8e6		; Hex color light blue
	SetEnv, fromlogo, 1
	Return

	ButtonNext:
		IfEqual, icons, 8, goto, start
		EnvAdd, icons, 1
		Goto, nexticon2

	ButtonTray:
		Menu, Tray, Icon, %Ico_common%,%icons%
		Goto, nexticon2

	ButtonMenu:
		Goto, start

Button1/2L:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	SysGet, Mon15, MonitorWorkArea
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	SetEnv, Mon15Right1, %Mon15Right%
	Mon15Right1 /= 2
	;; MsgBox, Mon 15 Left: %Mon15Left% -- Top: %Mon15Top% -- Right: %Mon15Right% -- Bottom %Mon15Bottom% -- Right1=%Mon15Right1% -- activeWindow=%activeWindow%
	WinMove, %activeWindow%, , 0, 0, %Mon15Right1%, %Mon15Bottom%
	WinActivate, %activeWindow%
	Goto, sleep2

Button1/2R:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	SysGet, Mon16, MonitorWorkArea
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	SetEnv, Mon16Right1, %Mon16Right%
	Mon16Right1 /= 2
	;; MsgBox, Mon 16 Left: %Mon16Left% -- Top: %Mon16Top% -- Right: %Mon16Right% -- Bottom %Mon16Bottom% -- Mon16Right1=%Mon16Right1% -- activeWindow=%activeWindow% -- %Mon16Right1% 0 %Mon16Right1% %Mon16Bottom%
	WinMove, %activeWindow%, , %Mon16Right1%, 0, %Mon16Right1%, %Mon16Bottom%
	WinActivate, %activeWindow%
	Goto, sleep2

ShowWinRes:
ButtonWin_Res:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	TrayTip, %title%, Click on a Windows with left mouse button !, 1, 2
	KeyWait, LButton, D
	Sleep, 250
	WinGetTitle, WinTitle, A
	WinGetPos , X, Y, Width, Height, A
	Sleep, 750
	TrayTip, %title%, %WinTitle% is at x=%x% y=%y% w=%width% h=%height% : Data is in clipboard., 3, 2
	clipboard = %WinTitle% is at x=%x% y=%y% w=%width% h=%height% : %WinTitle% %x% %y% %width% %height%
	goto, sleep2

ShowScrRes:
ButtonScr_Res:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	IfEqual, MonitorCOunt, 2, goto, 2monitor
	TrayTip, %title%, MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% - Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% - Data is in clipboard., 3, 2
	clipboard = MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% - Mon 1 : %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% - %Monitorcount% %MonitorPrimary% %Mon1Left% %Mon1Top% %Mon1Right% %Mon1Bottom%
	goto, sleep2

	2monitor:
		SysGet, Mon1, Monitor, 2
		TrayTip, %title%, MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% - Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% - Mon 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%. - Data is in clipboard., 3, 2
		clipboard = MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% - Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% - Mon 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%. - %Monitorcount% %MonitorPrimary% %Mon1Left% %Mon1Top% %Mon1Right% %Mon1Bottom% %Mon2Left% %Mon2Top% %Mon2Right% %Mon2Bottom%
		goto, sleep2

ShowWorkArea:
ButtonScr_Wrk:
	SysGet, Mon1, MonitorWorkArea, 1
	IfEqual, MonitorCOunt, 2, goto, 2monitor
	TrayTip, %title%, MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% - Data is in clipboard., 3, 2
	clipboard = MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% - Mon 1 : %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% - %Monitorcount% %MonitorPrimary% %Mon1Left% %Mon1Top% %Mon1Right% %Mon1Bottom%
	goto, sleep2

	2workmon:
		SysGet, Mon2, MonitorWorkArea, 2
		TrayTip, %title%, MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% - Mon 2 : %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom% - Data is in clipboard., 3, 2
		clipboard = MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% - Mon 1 : %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% - Mon 2 : %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom% - %Monitorcount% %MonitorPrimary% %Mon1Left% %Mon1Top% %Mon1Right% %Mon1Bottom%
		goto, sleep2

;;--- Debug Pause ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0

	debug0:
	SetEnv, debug, 0
	TrayTip, %title%, Deactivated ! debug=%debug%, 1, 2
	Goto, sleep2

	debug1:
	SetEnv, debug, 1
	TrayTip, %title%, Activated ! debug=%debug%, 1, 2
	Goto, sleep2

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

;;--- Function Exe Call ---

ButtonWindowInfo:
	Run, ActiveWindowInfo.dll
	Goto, start

ButtonHddTemp:
	Run, HddTemp.dll
	Goto, start

ButtonProcestList:
	Run, processlist.dll
	Goto, start

ButtonActualSwap:
	Run, actualswap.dll
	Goto, start

;;--- Quit (escape , esc) ---

ButtonQuit:
	Gui, destroy
	goto, sleep2

ButtonReload:
doReload:
	Gui, destroy
	Reload
	sleep, 500

ExitApp:
	Gui, destroy
	ExitApp

GuiClose:
	Gui, destroy
	IfEqual, fromlogo, 1, Goto, start
	Goto, sleep2

;	Escape::		; Debug purpose, cause some bizzare thing if always activated.
	Gui, destroy
	ExitApp

;;--- Tray Bar (must be at end of file) ---

ButtonSecret:
secret:
	MsgBox, 64, WMC Fit Screen, All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author%.`n`nClipboard (if text)=%clipboard%
	Return

about:
	TrayTip, %title%, %mode% by %author%, 2, 1
	Sleep, 500
	Return

version:
	TrayTip, %title%, %version%, 2, 2
	Sleep, 500
	Return

ButtonAuthor:
	author:
		MsgBox, 64, %title%, %title% %mode% %version% %author% This software is usefull to place automaticly a windows in a specified resolutionand use as a developpement tool for AHK. Usefull for windows doesn't have the ability to do this.`n`n`tGo to https://github.com/LostByteSoft
		Return

ButtonLogoIcon:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy

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