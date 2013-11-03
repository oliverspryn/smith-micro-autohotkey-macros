#SingleInstance force
#NoTrayIcon
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

AddGUIButton("Close Lid and Hibernate", "Hibernate", "Ctrl+Alt+H - Set Windows to go into hibernation mode when the lid is closed")
AddGUIButton("Close Lid and Sleep", "SleepM", "Ctrl+Alt+S - Set Windows to go into sleep mode when the lid is closed")
AddGUIButton("Ping", "Ping", "Ctrl+Alt+P - Ping the Google DNS servers at 8.8.8.8")
AddGUIButton("Browse Internet", "Browse", "Ctrl+Alt+B - Open Internet Explorer and browse the internet")
AddGUIButton("Restart Computer", "Restart", "Ctrl+Alt+R - Restart the computer")
AddGUIButton("Bring QMBC to Front", "Front", "Ctrl+Alt+F - Activates the QMBC window and brings it to the front")
AddGUIButton("Connect to Network", "Connect", "Ctrl+Alt+C - Connect to or disconnect from the first network listed in QMBC")
AddGUIButton("Cyclical Testing", "Cyclical", "Ctrl+Alt+T - Run a series of cyclical procedures designed to test QMBC's ability to go into and out of sleep/hibernate mode repeatedly")

;;
; Sub-routines
; ------------------------------------
;;

SetTimer, WatchCursor, 10 ; Get ready to execute the cursor tracker
#Include user.ahk ; Include the script containing user defined sub-routines
return ; Don't execute the sub-routines below

; Turn cursor tracking on or off
tracking = 0

; Whether or not the application is paused
paused = 0
suspended = 0

#S::
ToggleTracker:
	if (suspended = 1) {
		return
	}
	
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

; Pause AutohotKey
#P::
Pause, Off

	if (!paused) {
		paused = 0
	}

	if (paused = 0) {
		Gui, Color, 0xF70D1A
		paused = 1
		suspended = 1
		Pause, On
	} else {
		Gui, Color, % GUIColor
		paused = 0
		suspended = 0
	}
return

; Reload the current script
#R::
	if (suspended = 1) {
		return
	}
	
	Reload
return

; Exit the application when the GUI is closed or escaped
GuiClose:
GuiEscape:
ExitApp 