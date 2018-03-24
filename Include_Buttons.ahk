
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