; ===================================================================================
; AHK Version ...: AHK_L 1.1.11.01 x64 Unicode
; Win Version ...: Windows 7 Professional x64 SP1
; Author ........: jNizM
; Script ........: HDD_Temp_Monitor.ahk
; Description ...: HDD Temp Monitor
; License .......: WTFPL
; Page web.......: https://gist.github.com/jNizM/5934292
; ===================================================================================

; GLOBAL SETTINGS ===================================================================

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#NoEnv
	#NoTrayIcon
	Menu, Tray, Tip, Hdd Temp Exe

; SCRIPT ============================================================================

;;Gui, +ToolWindow
Gui, Margin, 10, 10
Gui, Font, s10, Tahoma
Gui, Add, GroupBox, xm ym w300 h60, HDD Temp Monitor:
Gui, Font, s12, Tahoma
Gui, Add, Text, xm+10 yp+25 w80 vHDD,
Gui, Add, Progress, xm+100 yp-1 r0-10 -Smooth BackgroundC9C9C9 c5BB75E vHDDG
Gui, Show, AutoSize, HDD Temp Monitor
SetTimer, HDDTemp, 1000
return

HDDTemp:
    GuiControl,, HDD, % WMI_HDD() . "    °C"
    GuiControl,, HDDG, % WMI_HDD()
    if WMI_HDD() between 0 and 49
    {
        GuiControl, +c00C000, HDD
        GuiControl, +c00C000, HDDG
    }
    else if WMI_HDD() between 50 and 69
    {
        GuiControl, +cFF8000, HDD
        GuiControl, +cFF8000, HDDG
    }
    else if WMI_HDD() between 70 and 100
    {
        GuiControl, +cFF0000, HDD
        GuiControl, +cFF0000, HDDG
    }
return

WMI_HDD()
{
    strComputer := "."
    objWMIService := ComObjGet("winmgmts:\\" . strComputer . "\root\WMI")
    colItems := objWMIService.ExecQuery("SELECT * FROM MSStorageDriver_ATAPISmartData")._NewEnum
    while colItems[objItem]
    {
        loop, 361
        {
            i := A_Index - 1
            if (objItem.VendorSpecific[i] = "194")
            {
                j := i + 5
                return, objItem.VendorSpecific[j]
            }
        }
    }
}

; EXIT ==============================================================================

GuiClose:
GuiEscape:
ExitApp

; LICENSE ===========================================================================
/*
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004
 
 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
 
 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.
 
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
  0. You just DO WHAT THE FUCK YOU WANT TO.
*/