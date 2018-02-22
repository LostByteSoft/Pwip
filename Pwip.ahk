;;--- Head --- Informations --- AHK ---

;;	Compatibility: Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	Use as a developpement tool for AHK
;;	This entire thing (work) is a developpement tool for AHK scripting.
;;	Use an external EXE or DLL file for icon is shit load of job and the final quality is less.

;;--- Softwares Variables ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2

	SetEnv, title, Pwip
	SetEnv, mode, Put Windows In Place. Left click here !
	SetEnv, version, Version 2018-02-22-1249
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, C:\Program Files\Common Files\
	SetEnv, logoicon, ico_Windows.ico
	SetEnv, debug, 0

	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2

	;; Specific Icons (or files)

	FileInstall, ico_Windows.ico, %icofolder%\ico_Windows.ico, 0

	;; Common ico

	FileInstall, ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, ico_pause.ico, %icofolder%\ico_pause.ico, 0

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
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, %icofolder%\ico_options.ico
	menu, tray, add
	menu, tray, add, Get the Win Resolution, ButtonWinRes
	menu, tray, add, Get the Scr Resolution, ButtonScrRes
	menu, tray, add, Get the Work Resolution, ButtonScrWork
	menu, tray, add, Get the Sys Uptime, ButtonUptime
	menu, tray, add
	menu, tray, add, Show Gui, start
	Menu, Tray, Icon, Show Gui, %icofolder%\%logoicon%
	menu, tray, add,
	Menu, Tray, Tip, %mode% Win + Z

;;--- Software start here ---

	Goto, sleep2

#Z::
start:
	Gui, destroy
	Menu, Tray, Icon, %icofolder%\%logoicon%
	IfEqual, reimage, 1, SetEnv, checked, checked

	;; Top lines
	Gui, Add, Text, x25 y5 w550 h40 , Click on a resolution you want AND click on a windows you want to be resize. MonitorCount=%MonitorCount% MonitorPrimary=%MonitorPrimary%

	Gui, Add, Checkbox, x25 y20 w125 h15 vReImage %checked%, Do not close GUI.
	;Gui, Add, Checkbox, x25 y35 w175 h15 vMonitor2 %checked%, Open second monitor GUI

	Gui, Add, Text, x200 y20 w300 h20 , Screen 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%
	IfEqual, MonitorCOunt, 1, goto, 1monitor
	Gui, Add, Text, x200 y33 w300 h20 , Screen 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%
	Goto, 2monitors
	1monitor:
	Gui, Add, Text, x200 y33 w300 h20 , Screen 2 is not installed.
	2monitors:

	;; 1 col x50
	Gui, Add, Text, x70 y50 w35 h20 , 4 / 3
	Gui, Add, Button, x50 y75 w75 h30 , 640x480
	Gui, Add, Button, x50 y125 w75 h30 , 800x600
	Gui, Add, Button, x50 y175 w75 h30 , 1024x768
	Gui, Add, Button, x50 y225 w75 h30 , 1152x864
	Gui, Add, Button, x50 y275 w75 h30 , 1600x1200

	;; 2 col x150
	Gui, Add, Text, x170 y50 w35 h20 , 16 / 9
	Gui, Add, Button, x150 y75 w75 h30 , 1280x720
	Gui, Add, Button, x150 y125 w75 h30 , 1360x768
	; Space for 1366x768
	Gui, Add, Button, x150 y225 w75 h30 , 1600x900
	Gui, Add, Button, x150 y275 w75 h30 , 1920x1080

	;; 3 col x2«50
	Gui, Add, Text, x270 y50 w35 h20 , 16 / 10
	Gui, Add, Button, x250 y75 w75 h30 , 1680x1050
	Gui, Add, Text, x275 y107 w40 h20 , Vary
	Gui, Add, Button, x250 y175 w38 h30 , 1/2 L
	Gui, Add, Button, x287 y175 w38 h30 , 1/2 R
	Gui, Add, Button, x250 y225 w75 h30 , FitToScreen
	Gui, Add, Button, x250 y275 w75 h30 , Icon Viewer

	;; 4 col x350
	Gui, Add, Text, x370 y50 w50 h20 , Exe call
	Gui, Add, Button, x350 y75 w75 h30 , HddTemp
	Gui, Add, Button, x350 y125 w75 h30 , WindowInfo
	Gui, Add, Button, x350 y175 w75 h30 , ProcestList
	Gui, Add, Button, x350 y225 w75 h30 , Actual Swap

	;; 5 col x450
	Gui, Add, Text, x470 y50 w35 h20 , Get the
	Gui, Add, Button, x450 y75 w75 h30 , Win Res
	Gui, Add, Button, x450 y125 w75 h30 , Scr Res
	Gui, Add, Button, x450 y175 w75 h30 , Scr Work
	Gui, Add, Button, x450 y225 w75 h30 , Uptime

	;; 6 col x550
	Gui, Add, Text, x570 y50 w35 h20 , Options
	Gui, Add, Button, x550 y75 w75 h30 , LogoIcon
	Gui, Add, Button, x550 y125 w75 h30 , Secret
	Gui, Add, Button, x550 y175 w75 h30 , Author
	Gui, Add, Button, x550 y225 w75 h30 , Exit
	Gui, Add, Button, x550 y275 w75 h30 , ReLoad

	Gui, Show, h320 w650, %title% %mode%

	;;IfEqual, vMonitor2, checked, add, Text, x250 y300 w35 h20 , CHECKED MONITOR GUI
	Return

	Goto, start

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

ButtonWinRes:
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

ButtonScrRes:
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

ButtonScrWork:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
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

ButtonUptime:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy

	;; 1000 = 1 sec
	;; 60000 = 1 min
	;; 3 600 000 = 1 hour
	;; 86400000 = 24 hour
	;; 2147483647 = 24 days ; maximum

	t_TimeFormat := "HH:mm:ss dddd"
	t_StartTime :=                          		; Clear variable = A_Now
	t_UpTime := A_TickCount // 1000				; Elapsed seconds since start
	t_StartTime += -t_UpTime, Seconds       		; Same as EnvAdd with empty time
	FormatTime t_NowTime, , %t_TimeFormat%  		; Empty time = A_Now
	FormatTime t_StartTime, %t_StartTime%, %t_TimeFormat%
	t_UpTime := % t_UpTime // 86400 " days " mod(t_UpTime // 3600, 24) ":" mod(t_UpTime // 60, 60) ":" mod(t_UpTime, 60)

	IfEqual, debug, 1, msgbox, a_dd=%a_dd% a_hour=%a_hour%

	MsgBox, 64, Get Uptime (Time out 10 sec(NO)), Start time: `t" %t_StartTime% "`nTime now:`t" %t_NowTime% "`n`nElapsed time:`t" %t_UpTime% "`n`n(Time out 10 sec), 10
		if ErrorLevel
			goto, sleep2
	goto, sleep2

ButtonIconViewer:
	;; This is a developpement version for an DLL file icons library. This is not really implemented.
	SetEnv, icons, 1
	;;GuiControlGet, ReImage,, Reimage
	Gui, destroy

	nexticon2:

	SharedIcons :=  "C:\Program Files\Common Files\SharedIcons.dll"		; Icon path

	Gui, Font, s10
	Gui, Add, Text, x275 y10 cBlack, ScriptDir=%A_ScriptDir%
	Gui, Add, Text, x357 y25 cBlack, Icon Number=%Icons% 
	Gui, Add, Picture, x25 y60 w400 h400 Icon%icons% AltSubmit, %SharedIcons%		; you can add X20 Y20 for position AND Icon1 means that the first icon of the DLL or EXE
	Gui, Font, s14
	Gui, Add, Button, x5 y5 w75 , Next
	Gui, Add, Button, x90 y5 w75 , Tray
	Gui, Add, Button, x175 y5 w75 , Menu
	Gui, Add, Picture, Icon50, %A_ScriptDir%\SharedIcons.dll,%icons%
	Gui, Show, , %title% Logo
	Gui, Color, add8e6		; Hex color light blue
	Return

	ButtonNext:
		IfEqual, icons, 10, goto, start
		EnvAdd, icons, 1
		Goto, nexticon2

	ButtonTray:
		Menu, Tray, Icon, SharedIcons.dll, %icons%
		Goto, nexticon2

	ButtonMenu:
		Gui, destroy
		Goto, start

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
	Menu, Tray, Icon, %icofolder%\ico_pause.ico
	sleep2:
	sleep, 500000
	goto, sleep2

;;--- Function Exe Call ---

ButtonWindowInfo:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	IfNotExist, ActiveWindowInfo.exe, MsgBox, All *.exe files must be in same folder of Pwip.exe
	Run, ActiveWindowInfo.exe
	Goto, start

ButtonHddTemp:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	IfNotExist, HddTemp.exe, MsgBox, All *.exe files must be in same folder of Pwip.exe
	Run, HddTemp.exe
	Goto, start

ButtonProcestList:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	IfNotExist, processlist.exe, MsgBox, All *.exe files must be in same folder of Pwip.exe
	Run, processlist.exe
	Goto, start

ButtonActualSwap:
	GuiControlGet, ReImage,, Reimage
	IfEqual, reimage, 0, Gui, destroy
	IfNotExist, actualswap.exe, MsgBox, All *.exe files must be in same folder of Pwip.exe
	Run, actualswap.exe
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

ButtonExit:
ExitApp:
	Gui, destroy
	ExitApp

GuiClose:
	Gui, destroy
	;;IfEqual, fromlogo, 1, Goto, start
	Goto, sleep2

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

;;;	%icofolder%\SharedIcons.dll := A_ScriptDir . "\%icofolder%\SharedIcons.dll"
;;;	Gui, 4:Add, Picture, x25 y25 w400 h400 Icon8 AltSubmit, %icofolder%\SharedIcons.dll

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