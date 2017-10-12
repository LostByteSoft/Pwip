;;--- Head --- Informations --- AHK ---

;;	Compatibility: Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares Variables ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2

	SetEnv, title, Pwip
	SetEnv, mode, Put Windows In Place
	SetEnv, version, Version 2017-10-12-0922
	SetEnv, Author, LostByteSoft
	SetEnv, logoicon, ico_Windows.ico
	SetEnv, Persistant, 0

	SysGet, Mon1, Monitor, 1
	FileInstall, ico_Windows.ico, ico_Windows.ico, 0	;; Needed for icon
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, --= %mode% =--, about
	Menu, Tray, Icon, --= %mode% =--, %logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	menu, tray, add
	Menu, tray, add, Exit, ExitApp				; GuiClose exit program
	Menu, Tray, Icon, Exit, ico_shut.ico
	Menu, tray, add, Refresh, doReload				; Reload the script.
	Menu, Tray, Icon, Refresh, ico_reboot.ico
	menu, tray, add
	menu, tray, add, Set persistant in tray, persistant
	menu, tray, add
	menu, tray, add, --= Show Gui =--, start
	Menu, Tray, Icon, --= Show Gui =--, ico_options.ico
	menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

start:
	Gui, destroy
	SetEnv, fromlogo, 0
	Gui, Add, Text, x25 y30 w430 h40 , Click on a resolution you want AND click on a windows you want to be resize. (esc or cancel to quit) Persistant=%persistant%
	Gui, Add, Button, x50 y75 w75 h30 , 640x480
	Gui, Add, Button, x50 y125 w75 h30 , 800x600
	Gui, Add, Button, x50 y175 w75 h30 , 1024x768
	Gui, Add, Button, x50 y225 w75 h30 , 1152x864
	Gui, Add, Button, x150 y75 w75 h30 , 1280x720
	Gui, Add, Button, x150 y125 w75 h30 , 1360x768
	Gui, Add, Button, x150 y175 w75 h30 , 1680x1050
	Gui, Add, Button, x150 y225 w75 h30 , 1920x1080
	Gui, Add, Button, x250 y175 w75 h30 , SetPersistant
	Gui, Add, Button, x250 y225 w75 h30 , FitToScreen
	Gui, Add, Button, x350 y75 w75 h30 , LogoIcon
	Gui, Add, Button, x350 y125 w75 h30 , Secret
	Gui, Add, Button, x350 y175 w75 h30 , Author
	Gui, Add, Button, x350 y225 w75 h30 , Cancel
	Gui, Show, x1095 y420 h300 w500, %title% %mode%
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
	Goto, ButtonCancel

Button800x600:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 800, 600
	WinActivate, %activeWindow%
	Goto, ButtonCancel

Button1024x768:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1024, 768
	WinActivate, %activeWindow%
	Goto, ButtonCancel

Button1152x864:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1152, 864
	WinActivate, %activeWindow%
	Goto, ButtonCancel

Button1280x720:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1280, 720
	WinActivate, %activeWindow%
	Goto, ButtonCancel

Button1360x768:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1360, 768
	WinActivate, %activeWindow%
	Goto, ButtonCancel

Button1600x900:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1600, 900
	WinActivate, %activeWindow%
	Goto, ButtonCancel

Button1680x1050:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1680, 1050
	WinActivate, %activeWindow%
	Goto, ButtonCancel

Button1920x1080:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , x, y, 1920, 1080
	WinActivate, %activeWindow%
	Goto, ButtonCancel

ButtonFitToScreen:
	Gui, destroy
	TrayTip, %title%, %mode% Click on a windows with LEFT mouse., 2, 1
	KeyWait, LButton, D
	WinGetTitle, activeWindow, A
	WinGetPos, X, Y
	WinMove, %activeWindow%, , 0, 0, %Mon1Right%, %Mon1Bottom%
	WinActivate, %activeWindow%
	Goto, ButtonCancel

tray:
	Gui, destroy
	Sleep, 500000
	Goto, tray

ButtonSetPersistant:
persistant:
	Ifequal, persistant, 1, goto, remove
	SetEnv, persistant, 1
	Goto, tray

	Remove:
	SetEnv, persistant, 0
	Goto, start

;;--- Quit (escape , esc) ---

ButtonCancel:
	IfEqual, persistant, 1, Goto, tray
	goto, ExitApp

doReload:
	Gui, destroy
	Reload
	sleep, 500

ExitApp:
	Gui, destroy
	ExitApp

Escape::		; Debug purpose, or here just quit.
	Gui, destroy
	IfEqual, persistant, 1, Goto, tray
	ExitApp

GuiClose:
	IfEqual, persistant, 1, Goto, tray
	IfEqual, fromlogo, 1, Goto, start
	Goto, ExitApp

;;--- Tray Bar (must be at end of file) ---

ButtonSecret:
secret:
	MsgBox, 64, WMC Fit Screen, All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author%.`n`nPersistant=%persistant%
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
	MsgBox, 64, %title%, %title% %mode% %version% %author% This software is usefull to place automaticly a windows in a specified resolution. Usefull for windows doesn't have the ability to do this.`n`n`tGo to https://github.com/LostByteSoft
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