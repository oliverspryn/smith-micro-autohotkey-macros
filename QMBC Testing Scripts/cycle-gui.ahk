;;
; Configuration
; ------------------------------------
;;

GUI2Color = FFFFFF
GUI2Height = 290
GUI2Width = 310

;;
; Build the GUI
; ------------------------------------
;;

; GUI config
Gui, 2: Color, % GUI2Color
Gui, 2: Margin, 0, 0

; GUI components
Gui, 2: Font, S40
Gui, 2: Add, Text, X20 Y20 W270 Center Center BackgroundTrans, 0 ; ClassNN = Static1
Gui, 2: Font, S8
Gui, 2: Add, Text, X20 Y80 W270 Center Center BackgroundTrans, Successful runs
Gui, 2: Font, 
Gui, 2: Add, Text, X20 Y127 BackgroundTrans, Go into and out of: 
Gui, 2: Add, DropDownList, X120 Y123 W160 vPowerMode, sleep mode||hibernate
Gui, 2: Add, Text, X94 Y157 BackgroundTrans, by: 
Gui, 2: Add, DropDownList, X120 Y153 W160 vSleepMethod, going to the Start Menu||closing the lid
Gui, 2: Add, Text, X41 Y187 BackgroundTrans, with CDMA in: 
Gui, 2: Add, DropDownList, X120 Y183 W160 vConnectionMode, automatic connection mode||manual connection mode
Gui, 2: Add, Text, X55 Y217 BackgroundTrans, and repeat:
Gui, 2: Add, DropDownList, X120 Y213 W30 vIterations, 1|2|3|4||5|6|7|8|9|10
Gui, 2: Add, Text, X156 Y217 BackgroundTrans, times
Gui, 2: Add, Button, X20 Y247 W270 gSubmit, Run Test

return ; Don't execute the sub-routines below

ShowCycles:
; Show GUI
Gui, 2: Show, % "H" . GUI2Height . " W" . GUI2Width, SmithMicro Software Cyclical Testing Agent
return

;;
; Begin the test
; ------------------------------------
;;

success = 0

Submit:
success = 0
GuiControl, 2:, Static1, %success%

Gui, Submit, NoHide
Gosub, SetPowerMode
Gosub, SetWakeUpEvent

Loop, %Iterations% {
	Gosub, GoPowerStart
	Gosub, WakeUpWait
	Gosub, HardwareInit
	Gosub, ConnectClient
	Gosub, ConnectionWait
	Gosub, TestConnection
}

Gosub, StopWakeUpEvent
SoundBeep, 1000, 1000
return

; Change the power mode of the computer
SetPowerMode:
if (SleepMethod = "closing the lid") {
	if (PowerMode = "sleep mode") {
		Gosub, SleepM
	} else {
		Gosub, Hibernate
	}
}
return

; Create a Windows scheduled task for AHK to use to detect and respond to wake-ups from sleep or hibernate
SetWakeUpEvent:
Run, taskschd.msc     ; Run the task scheduler
Sleep 4000
MouseC(70, 40)        ; Click "Action"
Sleep 1000
Send, r               ; Select "Create Task"
Sleep 1000
MouseC(120, 80)       ; Click in the "Task name" field
Send, AHK             ; Enter the task name
Sleep 500
MouseC(100, 50)       ; "Triggers" tab
MouseC(50, 400)       ; "New" Button
Sleep 1000
MouseC(200, 50)       ; "Begin the task" dropdown open
Sleep 1000
MouseC(250, 200)      ; Select "On workstation unlock"
MouseC(450, 500)      ; Select "OK"
MouseC(50, 400)       ; "New" Button
Sleep 1000
MouseC(200, 50)       ; "Begin the task" dropdown open
Sleep 1000
MouseC(200, 80)       ; Select "At log on"
MouseC(450, 500)      ; Select "OK"
Sleep 1000
MouseC(150, 50)       ; "Action" tab
MouseC(50, 400)       ; "New" Button
Sleep 1000
MouseC(50, 160)       ; "Program/script" input
Send, C:\Windows\System32\calc.exe
MouseC(300, 475)      ; Selcct "OK"
Sleep 1000
MouseC(210, 50)       ; "Conditions" tab
MouseC(40, 225)       ; Uncheck the power options checkbox
MouseC(500, 450)      ; Select "OK"
Sleep 1000
WinClose, Task Scheduler
return

; Put the computer to sleep via the start menu or by prompting the user to close the lid
GoPowerStart:
if (SleepMethod = "going to the Start Menu") {
	MouseC(25, 750, 1)
	Sleep 500
	MouseC(350, 700, 1)
	Sleep 500

	if (PowerMode = "sleep mode") {
		MouseC(400, 675, 1)
	} else {
		MouseC(400, 700, 1)
	}
} else {
	SoundBeep, 600, 1000
}
return

; Wait for Windows to launch the "calc.exe" program, which will occur after the user has logged in
WakeUpWait:
WinWait, Calculator
WinClose, Calculator
return

; Wait for the CDMA or GSM device to become initialized
HardwareInit:
WindowActivate("QuickLink Mobility")
Sleep, 1000

Loop {
	CoordMode, Mouse, Relative
	MouseMove, 57, 130
	PixelGetColor, init, 57, 130

	if (init = 0xFFB251) { ; Look for the blue * beside the desired network connection
		break
	}
}

Sleep 2000
return

; Connect QMBC to the network
ConnectClient:
if (ConnectionMode = "manual connection mode") {
	Gosub, Connect
}
return

; Wait for a connection to be established
ConnectionWait:
Loop {
	CoordMode, Mouse, Relative
	MouseMove, 171, 442
	PixelGetColor, connected, 170, 442

	if (connected = 0x16AE00) { ; Look for the green connection arrow to the left of "Connect VPN"
		break
	}
}

Sleep 2000
return

; Start IE and a ping and ensure outbound connections are successful
TestConnection:
Run, C:\Program Files\Internet Explorer\iexplore.exe, , , PIDVal
Sleep, 12000

if (WinExist("Internet Explorer cannot display the webpage")) { ; Did an outgoing connection fail?
	; FAIL!!!
} else {
	success++
	GuiControl, 2:, Static1, %success%
}

Process, Close, %PIDVal%
return

; Stop the Windows scheduled task for AHK to use to detect and respond to wake-ups from sleep or hibernate
StopWakeUpEvent:
Send {LWin}          ; Run command prompt as the administrator
Sleep 500
Send cmd
Sleep 1000
MouseMove, 100, 60
MouseClick, Right
MouseC(110, 90)      ; End run command prompt as the administrator
Sleep 1000
Send, schtasks /delete /tn AHK /f
Send, {Enter}
Sleep 1000
WinClose, Administrator: C:\Windows\System32\cmd.exe
return