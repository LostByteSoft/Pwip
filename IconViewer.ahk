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

	SetEnv, version, Version 2018-03-12-1949
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, C:\Program Files\Common Files\

	SharedIcons :=  "C:\Program Files\Common Files\SharedIcons.dll"				; Icon path

start:
	setenv, icons, 1

nexticon2:

	Gui, Font, s10
	Gui, Add, Text, x275 y10 cBlack, ScriptDir=%A_ScriptDir%
	Gui, Add, Text, x357 y25 cBlack, Icon Number=%Icons% 
	Gui, Add, Picture, x25 y60 w400 h400 Icon%icons% AltSubmit, %SharedIcons%		; you can add X20 Y20 for position AND Icon1 means that the first icon of the DLL or EXE
	Gui, Font, s14
	Gui, Add, Button, x5 y5 w75 , Next
	Gui, Add, Button, x90 y5 w75 , Tray
	Gui, Add, Button, x175 y5 w75 , Exit
	Gui, Add, Picture, Icon50, %A_ScriptDir%\SharedIcons.dll,%icons%
	Gui, Color, add8e6								; Hex color light blue
	Gui, -MinimizeBox
	Gui, Show, , %title% Logo
	Return

	ButtonNext:
		EnvAdd, icons, 1
		IfEqual, icons, 11, goto, start
		Goto, nexticon2

	ButtonTray:
		Menu, Tray, Icon, SharedIcons.dll, %icons%
		Goto, nexticon2

;;--- Quit (escape , esc) ---

GuiClose:
ButtonExit:
	ExitApp