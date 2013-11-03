;;
; Display a Windows error dialog box with a red "X" to 
; the left
;
; @param  string title   The title of the dialog window
; @param  string content The content of the dialog window
; @return void
;;

DisplayError(title, content) {
	MsgBox, 16, %title%, %content%
}

;;
; Activate a window <b>which is already open</b> by its title
;
; @param  string title    The title of the window
; @param  int    attempts The number of times to try to activate the window, if it fails the first time
; @return bool            Whether or not the window could be activated
;;

WindowActivate(title, attempts = 5) {
	if (WinExist(title)) {
		Loop %attempts% {
			if (WinActive(title)) {
				return true
			} else {
				WinActivate, %title%
			}
		}
		
		DisplayError("Cannot activate window", title . " cannot be activated")
	} else {
		DisplayError("Window not open", title . " is not open and therefore cannot be activated")
	}
	
	return false
}

;;
; Open a program and activate the window by its title
;
; @param  string program  The program to run, using "\", not "/", for folder delimiters
; @param  string title    The title of the window
; @param  int    delay    The amount of time in seconds to wait for the program to start
; @return bool            Whether or not the window could be activated
;;

OpenProgram(program, title, delay = 5) {
	if (FileExist(program)) {
		Run, %program%
		StringSplit, parts, program, \ ; Splits up the program path...
		Process, Exist, % parts%parts0% ; ... and gets the file name of the program
		
		if (ErrorLevel) { ; i.e. ErrorLevel != 0, then all is well
			Sleep, %delay%
			
			if (!WinActive(title)) {
				WinActivate, %title%
			}
			
			return true
		} else {
			DisplayError("Cannot activate window", program . " cannot be executed")
		}
		
		DisplayError("Cannot activate window", title . " cannot be activated")
	} else {
		DisplayError("Program not found", program . " does not exist")
	}
	
	return false
}

;;
; Move the mouse and click on a certain X and Y position.
; Setting coord = 0 will move the mouse relative to the 
; active window, and setting coord = 1 will move it 
; relative to the screen.
;
; @param  int  x     The x position to move the mouse
; @param  int  y     The y position to move the mouse
; @param  int  coord The coordinate mode, 0 = relative to the active window, and 1 = relative to the screen
; @return void
;;

MouseC(x, y, coord = 0) {
	if (coord = 0) {
		CoordMode, Mouse, Relative
		MouseMove, x, y
		Click
	} else {
		CoordMode, Mouse, Screen
		MouseMove, x, y
		Click
	}
}

;;
; Given the classNN of a display item, determine whether 
; the control is a button, and return its NN value, if so.
; Return -1 if the control is not a button
;
; @param  string classNN The classNN of the input control
; @return int            "-1" if the control is not a button and the "NN" value if it is
;;

IsGUIButton(classNN) {
	Haystack := classNN
	Needle = Button
	StringGetPos, pos, HayStack, %Needle%
	
	if (pos >= 0) {
		StringTrimLeft, trim, Haystack, 6 ; Trims off the word "Button"
		return trim
	} else {
		return -1
	}
}

AtCol = 1
AtRow = 1
BtnHeight = 40
BtnVarID = 2 ; Starts at 2 since the classNN of the GUI buttons starts at Button2. Button1 is the tooltip toggle button
BtnWidth = 150
ColMax = 3
GUIHeight = 480
GUIWidth = 640
RowMax = 9

; Create the variables which will hold the text for the status bar
Loop, 27 { ; GUI can hold up to 27 possible buttons, %index% ranges from 2 to 28
	index := A_Index + 1
	ButtonMsg%index% = ""
}

;;
; Add a button to the hotkey GUI
;
; @param  string label   The label of the button window
; @param  string routine The name of the sub-routine contained in user.ahk to be executed on button click
; @param  string tip     The tip to display in the status bar on button hover
; @return void
;;

AddGUIButton(label, routine, tip = "") {
	global AtCol, AtRow, BtnHeight, BtnVarID, BtnWidth, ColMax, RowMax
	
; Don't let more buttons be added than can fit on screen
	if (AtCol = ColMax + 1) {
		MsgBox, No more buttons can be added to the hotkey window
		return
	}
	
; Add the button to the GUI
	Gui, Add, Button, % "X" . (46 * AtCol + (AtCol - 1) * BtnWidth) . " Y" . (100 + (AtRow - 1) * BtnHeight) . " W" . BtnWidth . " G" . routine, &%label%
	
; Increment the row/column counter
	AtRow++
	
	if (AtRow > RowMax) {
		AtRow = 1
		AtCol++
	}
	
; Create an EVIL global variable which will be used to update the text in the status bar
	ButtonMsg%BtnVarID% := tip
	BtnVarID++
}

;;
; Type a string very quickly by using the clipboard
;
; @param  string string  The string to be written
; @return void
;;

Type(string) {
	OldClip := Clipboard
	Clipboard := string
	Sleep 100
	Send ^v
	Clipboard := OldClip
}