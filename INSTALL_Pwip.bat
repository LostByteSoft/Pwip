@taskkill /f /im "Pwip.exe"
@taskkill /f /im "ActiveWindowInfo.exe"
@taskkill /f /im "HddTemp.exe"
@taskkill /f /im "ActualSwap.exe"
if exist "C:\Program Files\Common Files\SharedIcons.dll" goto next
copy "SharedIcons.dll" "C:\Program Files\Common Files\"
:next
md "%appdata%\Microsoft\Windows\Start Menu\Programs\Pwip"
copy "*.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Pwip"
copy "*.exe" "C:\Program Files\"
copy "Pwip.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
copy "Taskill CMD.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Pwip"
"C:\Program Files\Pwip.exe"
@exit