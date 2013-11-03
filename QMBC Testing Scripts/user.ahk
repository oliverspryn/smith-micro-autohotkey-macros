#Include cycle-gui.ahk

return ; Don't execute the sub-routines below

; Go into Hibernation mode
^!H::
Hibernate:
Sleep 500
Send {LWin}
Sleep 500
Send lid{Enter}
Sleep 1000
WindowActivate("System Settings")
MouseC(470, 325)
MouseC(470, 375)
MouseC(630, 325)
MouseC(630, 375)
MouseC(560, 540)
MouseC(770, 10)
return

; Go into sleep mode
^!S::
SleepM:
Sleep 500
Send {LWin}
Sleep 500
Send lid{Enter}
Sleep 1000
WindowActivate("System Settings")
MouseC(470, 325)
MouseC(470, 355)
MouseC(630, 325)
MouseC(630, 355)
MouseC(560, 540)
MouseC(770, 10)
return

; Ping the Google DNS servers
^!P::
Ping:
OpenProgram("C:\WINDOWS\system32\cmd.exe", "C:\WINDOWS\system32\cmd.exe")
Sleep 1000
Send C:{Enter}
Sleep 250
Send ping 8.8.8.8{Enter}
return

; Open Internet Explorer
^!B::
Browse:
Run C:\Program Files\Internet Explorer\iexplore.exe
return

; Restart Windows
^!R::
Restart:
Shutdown, 6
return

; Activate the QMBC window and bring it to the front
^!F::
Front:
WindowActivate("QuickLink Mobility")
return

; Connect to or disconnect from the first network listed in QMBC
^!C::
Connect:
WindowActivate("QuickLink Mobility")
MouseC(100, 140)
Sleep 500
MouseC(415, 445)
return

; Open the cyclical testing GUI

^!T::
Cyclical:
Goto ShowCycles
return