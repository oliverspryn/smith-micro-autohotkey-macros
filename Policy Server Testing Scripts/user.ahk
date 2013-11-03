; Activate Google Chrome window (or whatever)
; THANK YOU!!! -> http://stackoverflow.com/a/13508156

GetOldestPIDFromProcessName(strProcessName) {
    for oProc in ComObjGet("winmgmts:").ExecQuery("Select ProcessID,CreationDate from Win32_Process WHERE Name = '" strProcessName "'") {           
        nOldestPID := (nOldestPIDCreationDate > oProc.CreationDate) ? oProc.ProcessID : nOldestPID ? nOldestPID : oProc.ProcessID
        nOldestPIDCreationDate := oProc.CreationDate    
    }
	
    return nOldestPID
}

ScrollDown() {
	;MouseC(1440, 900)
	;Click Down
	;Sleep % duration ; default value = 2000
	;Click Up
	
	MouseClick, WheelDown, , , 20
}

Type(string) {
	OldClip := Clipboard
	Clipboard := string
	Sleep 100
	Send ^v
	Clipboard := OldClip
}

PageWait() {
	Sleep 1000
}

DiscoverNode(node, X, Y) {
	ScrollDown()
	MouseC(400, 860)     ; Click "Enter Node to Discover"
	PageWait()
	MouseC(180, 325)     ; Enter in the prompt
	Send % node
	MouseC(1300, 385)    ; Click "Discover"
	PageWait()
	MouseC(1300, 720)    ; Click "Submit"
	PageWait()
	MouseC(1300, 500)    ; Click "Execute"
	PageWait()
	ScrollDown()
	MouseC(860, 860)     ; Click "Display Known Device Tree"
	PageWait()
	MouseC(50, 320)      ; Collapse the tree
	PageWait()
	MouseC(1280, 625)    ; Refresh the data
	PageWait()
	MouseC(50, 320)      ; Open the tree
	PageWait()
	MouseC(X, Y)         ; Expand the correct node
}

return ; Don't execute the sub-routines below

; Go to the device's home page
^!H::
Home:
WinActivate, % "ahk_pid " GetOldestPIDFromProcessName("chrome.exe")
MouseC(225, 50)
Send ^A
Send {BackSpace}
Type("https://policy-demo.mnd.smithmicro.com/viper/displayDevice.do?deviceId=3889")
Send {Enter}
MouseMove, 300, 300
return

; Go to the device's log page
^!L::
Logs:
WinActivate, % "ahk_pid " GetOldestPIDFromProcessName("chrome.exe")
MouseC(225, 50)
Send ^A
Send {BackSpace}
Type("https://policy-demo.mnd.smithmicro.com/viper/displayDeviceLog.do?deviceId=41073d0de1348f23")
Send {Enter}
return

; Run a script in Policy Server
^!R::
Run:
Gosub, Home          ; Go home
PageWait()
ScrollDown()         
MouseC(570, 860)     ; Click on "Enter Command Script"
PageWait()
MouseC(225, 400)     ; Click in the text box
Send ^V
MouseC(1300, 700)    ; Click "Execute"
PageWait()
ScrollDown()
MouseC(1300, 860)    ; Click "Submit"
PageWait()
ScrollDown()

Loop, 14 {           ; Click "Confirm", location may vary on page, so try multiple times
	start := 580
	inc := 20
	Y := (A_Index * inc) + start
	
	MouseC(1300, Y)
}

PageWait()
ScrollDown()
MouseC(600, 750)     ; Click on the task in the "Applied Jobs" section
return

; Run "./SCOMO" and display the known device tree
^!S::
Discover:
Gosub, Home
PageWait()
DiscoverNode("./SCOMO", 65, 390)
return

; Run "./FINDME" and display the known device tree
^!F::
Find:
Gosub, Home
PageWait()
DiscoverNode("./FINDME", 65, 370)
return

; Run "./DiagMon" and display the known device tree
^!D::
Diag:
Gosub, Home
PageWait()
DiscoverNode("./DiagMon", 65, 345)
return

; Log into the Policy Server
^!C::
Login:
WinActivate, % "ahk_pid " GetOldestPIDFromProcessName("chrome.exe")
MouseC(700, 335)
Type("sspadmin")
Send {Tab}
Type("smsidm1234")
Send {Enter}
return