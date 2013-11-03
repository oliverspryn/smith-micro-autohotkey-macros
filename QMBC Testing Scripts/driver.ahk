#Include config.ahk

;;;
;  Install QMBS EXE with manual startup
;  --------------------------------------------
;;

^+M::
Run F:\QLMobilitySecurity.exe
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
Send {Space} ; Finish install destination page
Send {Space} ; Commence installation
Sleep 30000  ; Wait for installation to complete
Send {Tab}
Send {Space} ; Finish startup mode page
Sleep 20000  ; Wait for installation to complete
Send {Space} ; Finish installer
Send {Space} ; Restart
return

;;;
;  Install QMBS EXE with automatic startup
;  --------------------------------------------
;;

^+A::
Run F:\QLMobilitySecurity.exe
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
Send {Space} ; Finish install destination page
Send {Space} ; Commence installation
Sleep 30000  ; Wait for installation to complete
Send {Down}  ; Select start up mode
Send {Tab}
Send {Space} ; Finish startup mode page
Sleep 20000  ; Wait for installation to complete
Send {Space} ; Finish installer
Send {Space} ; Restart
return

;;;
;  Install QMBS EXE with SSO allow bypass startup
;  --------------------------------------------
;;

^+S::
Run F:\QLMobilitySecurity.exe
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
Send {Space} ; Finish install destination page
Send {Space} ; Commence installation
Sleep 30000  ; Wait for installation to complete
Send {Down}
Send {Down}  ; Select start up mode
Send {Tab}   ; Skip allow bypass checkbox
Send {Tab}
Send {Space} ; Finish startup mode page
Sleep 20000  ; Wait for installation to complete
Send {Space} ; Finish installer
Send {Space} ; Restart
return

;;;
;  Install QMBS EXE with SSO disallow bypass startup
;  --------------------------------------------
;;

^+N::
Run F:\QLMobilitySecurity.exe
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
Send {Space} ; Finish install destination page
Send {Space} ; Commence installation
Sleep 30000  ; Wait for installation to complete
Send {Down}
Send {Down}  ; Select start up mode
Send {Tab}
Send {Space} ; Uncheck allow bypass checkbox
Send {Tab}
Send {Space} ; Finish startup mode page
Sleep 20000  ; Wait for installation to complete
Send {Space} ; Finish installer
Send {Space} ; Restart
return

;;;
;  Lanuch QMBS EXE
;  --------------------------------------------
;;

^+L::
Run F:\QLMobilitySecurity.exe
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
return







;;;
;  Install QMBS MSI with manual startup
;  --------------------------------------------
;;

^#M::
Run F:\QLMobilitySecurity.msi
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
Send {Space} ; Finish install destination page
Send {Space} ; Commence installation
Sleep 30000  ; Wait for installation to complete
Send {Tab}
Send {Space} ; Finish startup mode page
Sleep 20000  ; Wait for installation to complete
Send {Space} ; Finish installer
Send {Space} ; Restart
return

;;;
;  Install QMBS MSI with automatic startup
;  --------------------------------------------
;;

^#A::
Run F:\QLMobilitySecurity.msi
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
Send {Space} ; Finish install destination page
Send {Space} ; Commence installation
Sleep 30000  ; Wait for installation to complete
Send {Down}  ; Select start up mode
Send {Tab}
Send {Space} ; Finish startup mode page
Sleep 20000  ; Wait for installation to complete
Send {Space} ; Finish installer
Send {Space} ; Restart
return

;;;
;  Install QMBS MSI with SSO allow bypass startup
;  --------------------------------------------
;;

^#S::
Run F:\QLMobilitySecurity.msi
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
Send {Space} ; Finish install destination page
Send {Space} ; Commence installation
Sleep 30000  ; Wait for installation to complete
Send {Down}
Send {Down}  ; Select start up mode
Send {Tab}   ; Skip allow bypass checkbox
Send {Tab}
Send {Space} ; Finish startup mode page
Sleep 20000  ; Wait for installation to complete
Send {Space} ; Finish installer
Send {Space} ; Restart
return

;;;
;  Install QMBS MSI with SSO disallow bypass startup
;  --------------------------------------------
;;

^#N::
Run F:\QLMobilitySecurity.msi
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
Send {Space} ; Finish install destination page
Send {Space} ; Commence installation
Sleep 30000  ; Wait for installation to complete
Send {Down}
Send {Down}  ; Select start up mode
Send {Tab}
Send {Space} ; Uncheck allow bypass checkbox
Send {Tab}
Send {Space} ; Finish startup mode page
Sleep 20000  ; Wait for installation to complete
Send {Space} ; Finish installer
Send {Space} ; Restart
return

;;;
;  Lanuch QMBS MSI
;  --------------------------------------------
;;

^#L::
Run F:\QLMobilitySecurity.msi
WinWaitActive, QuickLink Mobility Security Client Setup
Sleep 1000
Send {Space} ; Finish intro page
Send {Space}
Send {Tab}
Send {tab}
Send {Space} ; Finish EULA page
return







;;;
;  Start QMBS
;  --------------------------------------------
;;

^!S::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
return

;;;
;  Exit QMBS
;  --------------------------------------------
;;

^!E::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !F
Send E
Send {Space}
return

;;;
;  Restart QMBS
;  --------------------------------------------
;;

^!R::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !F
Send E
Send {Space}
Sleep 8000
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
return

;;;
;  Restart Windows
;  --------------------------------------------
;;

^!W::
Shutdown, 6
return

;;;
;  Enable Dr. Watson
;  --------------------------------------------
;;

^!D::
Run C:\WINDOWS\system32\cmd.exe
WinActivate, C:\WINDOWS\system32\cmd.exe
Sleep 1000
Send drwtsn32 -i{enter}
Sleep 500
Send {Space}
Send drwtsn32{enter}
Sleep 2000
WinActivate, Dr. Watson for Windows
Send {Tab}{Tab}{Tab}{Space}
Sleep 1000
Send F:\dumps\user.dmp{Enter}
Sleep 1000
WinActivate, Dr. Watson for Windows
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Space}
WinActivate, C:\WINDOWS\system32\cmd.exe
Sleep 500
Send exit{enter}
return

;;;
;  Ping Google
;  --------------------------------------------
;;

^!B::
Run C:\WINDOWS\system32\cmd.exe
WinActivate, C:\WINDOWS\system32\cmd.exe
Sleep 1000
Send ping 8.8.8.8{Enter}
return

;;;
;  Open settings window
;  --------------------------------------------
;;

^!G::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !T
Send E
return

;;;
;  Connect/disconnect QMBS
;  --------------------------------------------
;;

^!U::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
Sleep 1000
WinActivate, QuickLink Mobility
Sleep 1000
MouseMove, MouseX, MouseY
Click
Send E
return

;;;
;  Connect WWAN
;  --------------------------------------------
;;

^!F::
Run C:\Program Files\Hewlett-Packard\HP Connection Manager\HP Connection Manager.exe
Sleep 10000
WinActivate, Connection Manager
Send {Tab}{Tab}{Tab}{Space}
return

;;;
;  Disconnect WWAN
;  --------------------------------------------
;;

^!J::
Run C:\Program Files\Hewlett-Packard\HP Connection Manager\HP Connection Manager.exe
Sleep 2000
WinActivate, Connection Manager
Send {Space}
Send {Tab}{Tab}{Tab}{Space}
return

;;;
;  Disconnect WiFi
;  --------------------------------------------
;;

^!K::
MouseMove 10, 760
Click
Send T
Send T
Send {Right}{Enter}
Sleep 1000
WinActivate, Wireless Network Connection 3 Status
Send {Right}{Right}{Space}
Sleep 1000
WinActivate, Wireless Network Connection 3
Send {Down}{Enter}
Sleep 1000
Send {Enter}
return






;;;
;  Add a profile
;  --------------------------------------------
;;

^!A::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !T
Send P
Sleep 500
Send {Tab}{Space}
Send {Tab}
Sleep 500
Send %name%{Tab}
Send %description%{Tab}
Send %group%{Tab}
Send %IP%{Tab}
Send %username%{Tab}
Send %name%{Tab}
Send {Tab}{Space}
Sleep 500
Send {Tab}%password%{Enter}
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Space}
return

;;;
;  Import an XML profile
;  --------------------------------------------
;;

^!I::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !T
Send P
Send {Tab}{Tab}{Tab}{Tab}{Space}
Send F:\TestProfileXML.xml{Enter}
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Space}
return

;;;
;  Import a QSP profile
;  --------------------------------------------
;;

^!O::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !T
Send P
Send {Tab}{Tab}{Tab}{Tab}{Space}
Send F:\TestProfileQSP.qsp{Enter}
Send %QSP%{Enter}	
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Space}
return

;;;
;  Export an XML profile
;  --------------------------------------------
;;


^!X::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !T
Send P
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Space}
Send {Tab}{Space}{Tab}{Space}{Tab}{Enter}
Send F:\TestProfileXML-temp.xml{Enter}	
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Space}
Run C:\WINDOWS\system32\cmd.exe
WinActivate, C:\WINDOWS\system32\cmd.exe
Sleep 500
Send dir F:\{Enter}
return

;;;
;  Export a QSP profile
;  --------------------------------------------
;;

^!Q::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !T
Send P
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Space}
Send {Tab}{Space}{Tab}{Tab}%QSP%{Tab}{Enter}
Send F:\TestProfileQSP-temp.qsp{Enter}	
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Space}
Run C:\WINDOWS\system32\cmd.exe
WinActivate, C:\WINDOWS\system32\cmd.exe
Sleep 500
Send dir F:\{Enter}
return

;;;
;  Clean all profiles
;  --------------------------------------------
;;

^!C::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !T
Send P
Loop, 5 {
  Send {Tab}{Tab}{Tab}{Space}
  Sleep 500
  Send {Space}
}
return

;;;
;  Open the profiles window
;  --------------------------------------------
;;

^!P::
Run C:\Program Files\Smith Micro\QuickLink Mobility Security Client\Vclient\IPRoam.exe
WinActivate, QuickLink Mobility
Sleep 1000
Send !T
Send P
return