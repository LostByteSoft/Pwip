;;--- Head --- Informations --- AHK ---

;;	Compatibility: Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	Use as a developpement tool for AHK
;;	This entire thing (work) is a developpement tool for AHK scripting.

;;--- Softwares Variables ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2

	SetEnv, title, Pwip
	SetEnv, mode, Put Windows In Place. AHK developpement tool.
	SetEnv, version, Version 2017-10-27-1103
	SetEnv, Author, LostByteSoft
	SetEnv, logoicon, ico_Windows.ico
	SetEnv, fromlogo, 0

	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	;; 	SysGet, Mon3, Monitor, 3

	FileInstall, ico_Windows.ico, ico_Windows.ico, 0	;; Needed for icon
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_debug.ico, ico_debug.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0
	;FileInstall, Ico_common.dll, Ico_common.dll, 0

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
	menu, tray, add
	menu, tray, add, Show Gui, start
	menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

	goto, sleep2

start:
	Gui, destroy
	SetEnv, fromlogo, 0
	Gui, Add, Text, x25 y30 w500 h40 , Click on a resolution you want AND click on a windows you want to be resize.

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
	Gui, Add, Button, x150 y175 w75 h30 , 1600x900
	Gui, Add, Button, x150 y225 w75 h30 , 1920x1080

	;; 3 col
	Gui, Add, Text, x270 y50 w35 h20 , 16 / 10
	Gui, Add, Button, x250 y75 w75 h30 , 1680x1050

	;; 4 col
	Gui, Add, Text, x370 y50 w35 h20 , Vary
	Gui, Add, Button, x350 y75 w75 h30 , FitToScreen
	Gui, Add, Text, x370 y155 w35 h20 , Get the
	Gui, Add, Button, x350 y175 w75 h30 , Win_Res
	Gui, Add, Button, x350 y225 w75 h30 , Scr_Res

	;; 5 col
	Gui, Add, Text, x470 y50 w35 h20 , Options
	Gui, Add, Button, x450 y75 w75 h30 , LogoIcon
	Gui, Add, Button, x450 y125 w75 h30 , Secret
	Gui, Add, Button, x450 y175 w75 h30 , Author
	Gui, Add, Button, x450 y225 w75 h30 , Icon_Viewer
	Gui, Add, Button, x450 y275 w75 h30 , Cancel

	Gui, Add, Text, x150 y275 w300 h20 , Screen 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%
	Gui, Add, Text, x150 y290 w300 h20 , Screen 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%

	Gui, Show, h320 w585, %title% %mode%
	Return

;;--- Resolutions ---

Button640x480:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 640, 480
	WinActivate, %activeWindow%
	Goto, sleep2

Button800x600:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 800, 600
	WinActivate, %activeWindow%
	Goto, sleep2

Button1024x768:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1024, 768
	WinActivate, %activeWindow%
	Goto, sleep2

Button1152x864:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1152, 864
	WinActivate, %activeWindow%
	Goto, sleep2

Button1280x720:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1280, 720
	WinActivate, %activeWindow%
	Goto, sleep2

Button1360x768:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1360, 768
	WinActivate, %activeWindow%
	Goto, sleep2

Button1600x900:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1600, 900
	WinActivate, %activeWindow%
	Goto, sleep2

Button1600x1200:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1600, 1200
	WinActivate, %activeWindow%
	Goto, sleep2

Button1680x1050:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1680, 1050
	WinActivate, %activeWindow%
	Goto, sleep2

Button1920x1080:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1920, 1080
	WinActivate, %activeWindow%
	Goto, sleep2

ButtonFitToScreen:
	Gui, destroy
	SysGet, Mon10, MonitorWorkArea
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , 0, 0, %Mon10Right%, %Mon10Bottom%
	WinActivate, %activeWindow%
	Goto, sleep2

ShowWinRes:
ButtonWin_Res:
	Gui, destroy
	TrayTip, %title%, Click on a Windows with left mouse button !, 1, 2
	KeyWait, LButton, D
	Sleep, 250
	WinGetTitle, WinTitle, A
	WinGetPos , X, Y, Width, Height, A
	Sleep, 750
	TrayTip, %title%, %WinTitle% is at x=%x% y=%y% w=%width% h=%height% : Data is in clipboard., 3, 2
	clipboard = %WinTitle% is at x=%x% y=%y% w=%width% h=%height% : %WinTitle% %x% %y% %width% %height%
	goto, sleep2

ButtonIcon_Viewer:
	;; This is a developpement version for an DLL file icons library. This is not really implemented.
	SetEnv, icons, 1
	Gui, destroy
	nexticon2:
	Ico_common := A_ScriptDir . "\Ico_common.dll"	 ; Icon path
	Gui, Font, s10
	Gui, Add, Text, x275 y10 cWhite, A_ScriptDirr=%A_ScriptDir%
	Gui, Add, Text, x357 y25 cWhite, Icons Number=%Icons% 
	Gui Add, Picture, x25 y60 w400 h400 Icon%icons% AltSubmit, %Ico_common%		; you can add X20 Y20 for position AND Icon1 means that the first icon of the DLL or EXE
	Gui, Font, s14
	Gui, Add, Button, x5 y5 , Next_Ico
	Gui, Add, Button, x100 y5 , Change_Tray
	Gui, Add, Picture, Icon50, "%A_ScriptDir%"\Ico_common.dll
	Gui, Show, , %title% Logo
	Gui, Color, add8e6		; Hex color light blue
	SetEnv, fromlogo, 1
	Return

	ButtonNext_Ico:
		IfEqual, icons, 7, goto, start
		EnvAdd, icons, 1
		Goto, nexticon2

	ButtonChange_Tray:
		Menu, Tray, Icon, %Ico_common%,%icons%
		Goto, nexticon2

ShowScrRes:
ButtonScr_Res:
	Gui, destroy
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	IfEqual, MonitorCOunt, 2, goto, 2monitor
	TrayTip, %title%, MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% : Data is in clipboard., 3, 2
	clipboard = MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% Mon 1 : %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% : %Monitorcount% %MonitorPrimary% %Mon1Left% %Mon1Top% %Mon1Right% %Mon1Bottom%
	goto, sleep2

	2monitor:
		SysGet, Mon1, Monitor, 2
		TrayTip, %title%, MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%`n`nMon 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%. : Data is in clipboard., 3, 2
		clipboard = MonitorCount=%Monitorcount% MonitorPrimary=%MonitorPrimary% Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom% Mon 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%. : %Monitorcount% %MonitorPrimary% %Mon1Left% %Mon1Top% %Mon1Right% %Mon1Bottom% %Mon2Left% %Mon2Top% %Mon2Right% %Mon2Bottom%
		goto, sleep2

;;--- Debug Pause ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0

	debug0:
	SetEnv, debug, 0
	goto, start

	debug1:
	SetEnv, debug, 1
	goto, start

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

ButtonCancel:
	Gui, destroy
	goto, sleep2

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

;Escape::		; Debug purpose, or here just quit.
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
	Gui, Destroy
GuiLogo:
	Gui, Add, Picture, x25 y25 w400 h400 , %logoicon%
	Gui, Show, w450 h450, %title% Logo
	Gui, Color, 000000
	SetEnv, fromlogo, 1
	Return

Goto, Start

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
;              LostByteSoft no copyright or copyleft.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---