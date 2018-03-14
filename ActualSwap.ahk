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
	SetEnv, version, Version 2018-03-05-1948
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
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, %icofolder%\ico_options.ico
	menu, tray, add, Disable, ButtonDisable
	Menu, Tray, add, Show GUI, start
	menu, tray, add,
	Menu, Tray, Default, Show GUI
	menu, tray, add,
	Menu, Tray, Click, 1
	Menu, Tray, Tip, %mode%

;;--- Software start here (menu) ---

Start:
	Menu, Tray, Icon, %icofolder%\ico_options.ico

	;; https://autohotkey.com/board/topic/33622-report-physical-ram-installed/#entry213392
	Gui, destroy
	VarSetCapacity( MEMORYSTATUSEX,64,0 ), NumPut( 64,MEMORYSTATUSEX ) 
	DllCall( "GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX )
	TotalPhys := NumGet( MEMORYSTATUSEX,8,"Int64"),   VarSetCapacity( PhysMem,16,0 )
	DllCall( "shlwapi.dll\StrFormatByteSize64A", Int64,TotalPhys, Str,PhysMem, UInt,16 )
	;; StrFormatByteSize64 : http://msdn.microsoft.com/en-us/library/bb759971(VS.85).aspx
	IfEqual, debug, 1, MsgBox, 64, Total Physical Memory, TotalPhys=%TotalPhys% Bytes`n PhysMem = %PhysMem%

	RegRead, TestKey, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles
	IfEqual, TestKey,, SetEnv, TestKey, Disabled

gui:
	IfEqual, debug, 1, MsgBox, START :`n`nTestKey=%TestKey%

	;; Top lines
	Gui, Add, Text, x25 y10 w550 h30 , Actual swap file is %TestKey%. Ram is = %TotalPhys%
	;;Gui, Add, Text, x325 y5 w550 h30 , Change value ?

	;; 1 col
	Gui, Add, Text, x70 y50 w50 h20 , Change ?
	Gui, Add, Button, x50 y75 w75 h30 , Yes
	Gui, Add, Button, x50 y125 w75 h30 , No
	;;Gui, Add, Button, x50 y175 w75 h30 ,
	Gui, Add, Button, x50 y225 w75 h30 , Disable

	;; 2 col x150
	Gui, Add, Text, x170 y50 w50 h20 , Preset ?
	Gui, Add, Button, x150 y75 w75 h30 , Preset_2048
	Gui, Add, Button, x150 y125 w75 h30 , Preset_4096
	Gui, Add, Button, x150 y175 w75 h30 , Preset_8192
	Gui, Add, Button, x150 y225 w75 h30 , Preset_16384

	;; 3 col x250
	Gui, Add, Text, x270 y50 w50 h20 , Total ?
	Gui, Add, Button, x250 y75 w75 h30 , Total_4096
	Gui, Add, Button, x250 y125 w75 h30 , Total_8192
	Gui, Add, Button, x250 y175 w75 h30 , Total_16384
	Gui, Add, Button, x250 y225 w75 h30 , Total_32768
	Gui, Add, Text, x250 y275 w200 h50, Total is ram + swap. It will take the ram capacity and add swap to go to X mb.

	;; 4 col
	Gui, Add, Text, x370 y50 w50 h20 , Read ?
	Gui, Add, Button, x350 y75 w75 h30 , Read

	;; 5 col x450
	;;Gui, Add, Text, x470 y50 w35 h20 ,
	;;Gui, Add, Button, x450 y75 w75 h30 ,
	Gui, Add, Button, x450 y275 w75 h30 , Reboot

	;; 6 col x550
	Gui, Add, Text, x570 y50 w50 h20 , Options !
	Gui, Add, Button, x550 y75 w75 h30 , LogoIcon
	Gui, Add, Button, x550 y125 w75 h30 , Secret
	Gui, Add, Button, x550 y175 w75 h30 , Author
	Gui, Add, Button, x550 y225 w75 h30 , ReLoad
	Gui, Add, Button, x550 y275 w75 h30 , Exit

	;; title
	Gui, Show, h320 w650, %title% and change.
	Return

;;--- Codes lines ---

ButtonYes:
change:
	InputBox, NewSwapSize, %title%, Insert new value size in MB. It will be C:\pagefile.sys !!! Only numbers !!! Exemple: 1024 or 8192. If you write nothing it disable the swap.
	IfEqual, debug, 1, MsgBox, CHANGE :`n`nNewSwapSize=%NewSwapSize%
	if ErrorLevel
		Goto, start
	IfEqual, NewSwapSize,, SetEnv, NewSwapSize, Disabled
	RegRead, TestKey2, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management ,PagingFiles
	MsgBox, 4, %title%, Old value = %TestKey2% : New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, changevalue
	IfMsgBox, NO, Goto, ExitApp

	changevalue:
	IfEqual, NewSwapSize,, SetEnv, NewSwapSize, Disabled
	IfEqual, debug, 1, MsgBox, CHANGEVALUE :`n`n NewSwapSize=%NewSwapSize%`n`n Writen data C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. Cancel apply changes but not reboot. New value = %NewSwapSize% MB.`n`n`t(NO changes is made at this time) Click YES to make change.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, No, Goto, ExitApp

ButtonDisable:
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles,
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. NewSwapSize=%NewSwapSize%
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, No, Goto, ExitApp

ButtonPreset_2048:
	SetEnv, NewSwapSize, C:\PagingFiles.swp 2048 2048
	IfEqual, debug, 1, MsgBox, Total Physical Memory TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. NewSwapSize=%NewSwapSize%
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp
	Goto, start

ButtonPreset_4096:
	SetEnv, NewSwapSize, C:\PagingFiles.swp 4095 4095
	IfEqual, debug, 1, MsgBox, Total Physical Memory TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. NewSwapSize=%NewSwapSize%
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

ButtonPreset_6144:
	SetEnv, NewSwapSize, C:\PagingFiles.swp 6144 6144
	IfEqual, debug, 1, MsgBox, Total Physical Memory TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. NewSwapSize=%NewSwapSize%
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp
	Goto, start

ButtonPreset_8192:
	SetEnv, NewSwapSize, C:\PagingFiles.swp 8192 8192
	IfEqual, debug, 1, MsgBox, Total Physical Memory TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. NewSwapSize=%NewSwapSize%
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

ButtonPreset_16384:
	SetEnv, NewSwapSize, C:\PagingFiles.swp 16384 16384
	IfEqual, debug, 1, MsgBox, Total Physical Memory TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, %NewSwapSize%
	MsgBox, 4, %title%, Changes where made. Reboot to take effect?  Click OK will reboot. NewSwapSize=%NewSwapSize%
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

;;--- Total ---

ButtonTotal_4096:
	;; https://autohotkey.com/board/topic/33622-report-physical-ram-installed/#entry213392
	Gui, destroy
	VarSetCapacity( MEMORYSTATUSEX,64,0 ), NumPut( 64,MEMORYSTATUSEX ) 
	DllCall( "GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX )
	TotalPhys := NumGet( MEMORYSTATUSEX,8,"Int64"),   VarSetCapacity( PhysMem,16,0 )
	DllCall( "shlwapi.dll\StrFormatByteSize64A", Int64,TotalPhys, Str,PhysMem, UInt,16 )
	;; StrFormatByteSize64 : http://msdn.microsoft.com/en-us/library/bb759971(VS.85).aspx
	IfEqual, debug, 1, MsgBox, 64, Total Physical Memory, TotalPhys=%TotalPhys% Bytes`n PhysMem = %PhysMem%
	;; 8192000000 8gb
	;; 12288000000 12gb
	;; max swap 16777216
	;; SetEnv, MaxTotal, 8192000000 must add 199
	SetEnv, MaxTotal, 4096000000
	MaxTotal -= TotalPhys
	SetEnv, NewSwapSize, %MaxTotal%
	NewSwapSize2 := TotalPhys + NewSwapSize
	NewSwapSize /= 1000000
	MsgBox, 64, Total Physical Memory, TotalPhys = %TotalPhys% Bytes`n`nThe preset value set swap to 4 gb (ram + swap = 4 gb)`n`nNew swap value = %NewSwapSize% MB.
	IfEqual, debug, 1, goto, skipwrite3
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	skipwrite3:
	MsgBox, 4, %title%, Changes where made (Not in debug). Reboot to take effect?  Click OK will reboot. No not reboot.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

ButtonTotal_8192:
	;; https://autohotkey.com/board/topic/33622-report-physical-ram-installed/#entry213392
	Gui, destroy
	VarSetCapacity( MEMORYSTATUSEX,64,0 ), NumPut( 64,MEMORYSTATUSEX ) 
	DllCall( "GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX )
	TotalPhys := NumGet( MEMORYSTATUSEX,8,"Int64"),   VarSetCapacity( PhysMem,16,0 )
	DllCall( "shlwapi.dll\StrFormatByteSize64A", Int64,TotalPhys, Str,PhysMem, UInt,16 )
	;; StrFormatByteSize64 : http://msdn.microsoft.com/en-us/library/bb759971(VS.85).aspx
	IfEqual, debug, 1, MsgBox, 64, Total Physical Memory, TotalPhys=%TotalPhys% Bytes`n PhysMem = %PhysMem%
	;; 8192000000 8gb
	;; 12288000000 12gb
	;; max swap 16777216
	;; SetEnv, MaxTotal, 8192000000 must add 199
	SetEnv, MaxTotal, 8391000000
	MaxTotal -= TotalPhys
	SetEnv, NewSwapSize, %MaxTotal%
	NewSwapSize2 := TotalPhys + NewSwapSize
	NewSwapSize /= 1000000
	MsgBox, MaxTotal=%MaxTotal% TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%`n`nNewSwapSize2=%NewSwapSize2% (NewSwapSize2 := TotalPhys + NewSwapSize*1000000)`n`n`tIt will write = C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	MsgBox, 64, Total Physical Memory, TotalPhys = %TotalPhys% Bytes`n`nThe preset value set swap to 8 gb (ram + swap = 8 gb)`n`nNew swap value = %NewSwapSize% MB.
	IfEqual, debug, 1, goto, skipwrite2
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	skipwrite2:
	MsgBox, 4, %title%, Changes where made (Not in debug). Reboot to take effect?  Click OK will reboot. No not reboot. New swap value = %NewSwapSize% MB.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

ButtonTotal_12288:
	;; https://autohotkey.com/board/topic/33622-report-physical-ram-installed/#entry213392
	Gui, destroy
	VarSetCapacity( MEMORYSTATUSEX,64,0 ), NumPut( 64,MEMORYSTATUSEX ) 
	DllCall( "GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX )
	TotalPhys := NumGet( MEMORYSTATUSEX,8,"Int64"),   VarSetCapacity( PhysMem,16,0 )
	DllCall( "shlwapi.dll\StrFormatByteSize64A", Int64,TotalPhys, Str,PhysMem, UInt,16 )
	;; StrFormatByteSize64 : http://msdn.microsoft.com/en-us/library/bb759971(VS.85).aspx
	IfEqual, debug, 1, MsgBox, 64, Total Physical Memory, TotalPhys=%TotalPhys% Bytes`n PhysMem = %PhysMem%
	;; 8192000000 8gb
	;; 12288000000 12gb
	;; max swap 16777216
	SetEnv, MaxTotal, 12288000000
	MaxTotal -= TotalPhys
	SetEnv, NewSwapSize, %MaxTotal%
	NewSwapSize2 := TotalPhys + NewSwapSize
	NewSwapSize /= 1000000
	IfEqual, debug, 1, MsgBox, MaxTotal=%MaxTotal% TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%`n`nNewSwapSize2=%NewSwapSize2% (NewSwapSize2 := TotalPhys + NewSwapSize*1000000)`n`n`tIt will write = C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	sleep, 250
	MsgBox, 64, Total Physical Memory, TotalPhys = %TotalPhys% Bytes`n`nThe preset value set swap to 12 gb (ram + swap = 12 gb)`n`nNew swap value = %NewSwapSize% MB.
	IfEqual, debug, 1, goto, skipwrite1
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	skipwrite1:
	MsgBox, 4, %title%, Changes where made (Not in debug). Reboot to take effect?  Click OK will reboot. No not reboot.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

ButtonTotal_16384:
	;; https://autohotkey.com/board/topic/33622-report-physical-ram-installed/#entry213392
	Gui, destroy
	VarSetCapacity( MEMORYSTATUSEX,64,0 ), NumPut( 64,MEMORYSTATUSEX ) 
	DllCall( "GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX )
	TotalPhys := NumGet( MEMORYSTATUSEX,8,"Int64"),   VarSetCapacity( PhysMem,16,0 )
	DllCall( "shlwapi.dll\StrFormatByteSize64A", Int64,TotalPhys, Str,PhysMem, UInt,16 )
	;; StrFormatByteSize64 : http://msdn.microsoft.com/en-us/library/bb759971(VS.85).aspx
	IfEqual, debug, 1, MsgBox, 64, Total Physical Memory, TotalPhys=%TotalPhys% Bytes`n PhysMem = %PhysMem%
	;; 8192000000 8gb
	;; 12288000000 12gb
	;; max swap 16777216
	SetEnv, MaxTotal, 16384000000
	MaxTotal -= TotalPhys
	SetEnv, NewSwapSize, %MaxTotal%
	NewSwapSize2 := TotalPhys + NewSwapSize
	NewSwapSize /= 1000000
	IfEqual, debug, 1, MsgBox, MaxTotal=%MaxTotal% TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%`n`nNewSwapSize2=%NewSwapSize2% (NewSwapSize2 := TotalPhys + NewSwapSize*1000000)`n`n`tIt will write = C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	sleep, 250
	MsgBox, 64, Total Physical Memory, TotalPhys = %TotalPhys% Bytes`n`nThe preset value set swap to 16 gb (ram + swap = 16 gb)`n`nNew swap value = %NewSwapSize% MB.
	IfEqual, debug, 1, goto, skipwrite4
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	skipwrite4:
	MsgBox, 4, %title%, Changes where made (Not in debug). Reboot to take effect?  Click OK will reboot. No not reboot.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp

ButtonTotal_32768:
	;; https://autohotkey.com/board/topic/33622-report-physical-ram-installed/#entry213392
	Gui, destroy
	VarSetCapacity( MEMORYSTATUSEX,64,0 ), NumPut( 64,MEMORYSTATUSEX ) 
	DllCall( "GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX )
	TotalPhys := NumGet( MEMORYSTATUSEX,8,"Int64"),   VarSetCapacity( PhysMem,16,0 )
	DllCall( "shlwapi.dll\StrFormatByteSize64A", Int64,TotalPhys, Str,PhysMem, UInt,16 )
	;; StrFormatByteSize64 : http://msdn.microsoft.com/en-us/library/bb759971(VS.85).aspx
	IfEqual, debug, 1, MsgBox, 64, Total Physical Memory, TotalPhys=%TotalPhys% Bytes`n PhysMem = %PhysMem%
	;; 8192000000 8gb
	;; 12288000000 12gb
	;; max swap 16777216
	SetEnv, MaxTotal, 32768000000
	MaxTotal -= TotalPhys
	SetEnv, NewSwapSize, %MaxTotal%
	NewSwapSize2 := TotalPhys + NewSwapSize
	NewSwapSize /= 1000000
	IfEqual, debug, 1, MsgBox, MaxTotal=%MaxTotal% TotalPhys=%TotalPhys% NewSwapSize=%NewSwapSize%`n`nNewSwapSize2=%NewSwapSize2% (NewSwapSize2 := TotalPhys + NewSwapSize*1000000)`n`n`tIt will write = C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	sleep, 250
	MsgBox, 64, Total Physical Memory, TotalPhys = %TotalPhys% Bytes`n`nThe preset value set swap to 32 gb (ram + swap = 32 gb)`n`nNew swap value = %NewSwapSize% MB.
	IfEqual, debug, 1, goto, skipwrite5
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles, C:\pagefile.sys %NewSwapSize% %NewSwapSize%
	skipwrite5:
	MsgBox, 4, %title%, Changes where made (Not in debug). Reboot to take effect?  Click OK will reboot. No not reboot.
	IfMsgBox, Yes, Goto, reboot
	IfMsgBox, NO, Goto, ExitApp


ButtonRead:
	RegRead, NewTestKey1, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles
	IfEqual, NewTestKey1,, SetEnv, NewTestKey1, Disabled
	MsgBox, 0, %title%, Swap file and value is (NewTestKey) = %NewTestKey1%
	Goto, gui

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
GuiClose:
	Gui, destroy
	ExitApp

ButtonReboot:
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
	RegRead, NewTestKey1, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\Control\Session Manager\Memory Management, PagingFiles
	IfEqual, NewTestKey1,, SetEnv, NewTestKey1, Disabled
	MsgBox, 64, %title%, All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author%.`n`nNewTestKey=%NewTestKey1%
	Return

version:
	TrayTip, %title%, %version%, 2, 2
	Sleep, 500
	Return

ButtonAuthor:
author:
	MsgBox, 64, %title%, %title% %mode% %version% %author% This software is usefull to set the swap memory in windows. It can set a min/max of swap or a fixed capacity (ram + swap).`n`n`tGo to https://github.com/LostByteSoft
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