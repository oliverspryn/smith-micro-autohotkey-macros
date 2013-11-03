#SingleInstance force
#Include lib.ahk

;;
; Configuration
; ------------------------------------
;;

GUIColor = FFFFFF
GUIHeight = 480
GUIWidth = 640

;;
; Build the GUI
; ------------------------------------
;;

; GUI config
Gui, Color, % GUIColor
Gui, Margin, 0, 0

; GUI components
Gui, Add, Progress, % "X0 Y0 W" . GUIWidth . " H70 backgroundDefault disabled"
Gui, Add, Text, % "X20 Y27 BackgroundTrans", Select the command below you wish to execute
Gui, Add, Button, % "X" . GUIWidth - 100 . " Y23 GToggleTracker", &Start Inspector ; ClassNN = Button1
Gui, Add, StatusBar

; Show GUI
Gui, Show, % "H" . GUIHeight . " W" . GUIWidth, SmithMicro Software Testing Assistant

;;
; Add code here
; ------------------------------------
;;

AddGUIButton("Go to Device Home Page", "Home", "Ctrl+Alt+H - Go to the Android device's home page in Policy Server")
AddGUIButton("Go to Device Logs", "Logs", "Ctrl+Alt+L - Go to the Android device's log page in Policy Server")
AddGUIButton("Run a Script", "Run", "Ctrl+Alt+R - Run a script in Policy Server where the code for the script is already in the clipboard")
AddGUIButton("SCOMO Discover", "Discover", "Ctrl+Alt+S - Runs the './SCOMO' command, then displays the known device tree")
AddGUIButton("FINDME Discover", "Find", "Ctrl+Alt+F - Runs the './FINDME' command, then displays the known device tree")
AddGUIButton("DiagMon Discover", "Diag", "Ctrl+Alt+D - Runs the './DiagMon' command, then displays the known device tree")
AddGUIButton("Login", "Login", "Ctrl+Alt+C - Log into the Policy Server")

;;
; Sub-routines
; ------------------------------------
;;

SetTimer, WatchCursor, 10 ; Get ready to execute the cursor tracker
#Include user.ahk ; Include the script containing user defined sub-routines
return ; Don't execute the sub-routines below

; Turn cursor tracking on or off
tracking = 0

#S::
ToggleTracker:
	if (tracking = 1) {
		tracking = 0
		GuiControl Text, Button1, &Start Inspector
	} else {
		tracking = 1
		GuiControl Text, Button1, &Stop Inspector
	}
return

; Update the status bar on button hover...
; ...will also display a tooltip, following the cursor, with its coordinates
WatchCursor:
; Button hover status update
	MouseGetPos, , , id, info
	WinGetTitle, title, ahk_id %id%
	GUIButton := IsGUIButton(info)
	
	if (GUIButton > -1 && title = "SmithMicro Software Testing Assistant") {
		SB_SetText(ButtonMsg%GUIButton%)
	} else {
		SB_SetText("")
	}
	
; Tooltip with mouse coordinates
	if (tracking = 1) {
		CoordMode, Mouse, Relative
		MouseGetPos, WinX, WinY
		CoordMode, Mouse, Screen
		MouseGetPos, ScrX, ScrY
		ToolTip, Window   X: %WinX% Y: %WinY%`nScreen      X: %ScrX% Y: %ScrY%
	} else {
		ToolTip
	}
return

; Exit the application when the GUI is closed
GuiClose:
ExitApp 