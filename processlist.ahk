
;; 2017-10-29-0955

Gui, Add, ListView, x2 y0, Process Name|Command Line
Gui, Add, ListView, x2 y0 w700 h800, Process Name|Command Line
	for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
	LV_Add("", process.Name, process.CommandLine)
Gui, Show,, Process List
return

GuiClose:
	Gui, destroy
	Exitapp