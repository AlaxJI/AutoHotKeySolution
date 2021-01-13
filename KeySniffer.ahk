#NoEnv
Process Priority,,High 
SetBatchLines -1 

#InstallKeybdHook 
SetKeyDelay 0,0 
#KeyHistory 25
Width = 400 
Height = 550 
TopCut = 280 

PrintScreen:: 
    shown := !shown 
    If (!shown) { 
        SetTimer RThistory, OFF 
        WinHide ahk_id %KHID% 
        Return 
    } 
    KeyHistory 
    WinGet KHID, ID, %A_ScriptFullPath% - AutoHotkey v 
    WinSet AlwaysOnTop, ON, ahk_id %KHID% 
    WinSet ExStyle,-0x80, ahk_id %KHID% ; removes window from the alt-tab list 
    WinSet Region,% "W" Width " H" Height " 4-" TopCut, ahk_id %KHID% 
    WinMove ahk_id %KHID%,,% A_ScreenWidth-Width, -TopCut 
    SetTimer RThistory, 500 
Return 

RThistory: 
    WinGet ID, ID, A 
    ControlSend,,{F5}, ahk_id %KHID% 
    WinActivate ahk_id %ID% 
Return
