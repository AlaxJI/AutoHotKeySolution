#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;==========================================
;Смена раскладки клавиатуры через CapsLock. CapsLock - долгое нажатие на CapsLock
;==========================================
$CapsLock::
    startTime := A_TickCount ;record the time the key was pressed
    KeyWait, CapsLock, U ;wait for the key to be released
    keypressDuration := A_TickCount-startTime ;calculate the duration the key was pressed down
    if (keypressDuration > 200) ;if the key was pressed down for more than 200ms send >
    {
        if GetKeyState("CapsLock" ,"T") = "0" {
            SetCapsLockState, On
        } Else {
            SetCapsLockState, Off
        }
    }
    else ;if the key was pressed down for less than 200ms send x
    {
        Send {LWin Down}{Space Down}{Space Up}{LWin Up}
    }
    GetKeyState("CapsLock" ,"T") 
return

;==========================================
;Точка при нажитии двух пробелов
;==========================================
~Space::	
    if (A_PriorHotkey <> "~Space" or A_PriorKey <> "Space" or A_TimeSincePriorHotkey > 300)
    {
        KeyWait, Space
        return
    }
    Send, {BackSpace}{BackSpace}{.}{Space} 
return

;======================================================
;Выполнение команд независимо от языка через cmd+{Key}: 
;  Undo, Cut, Copy, Paste, Save, Find
;======================================================

#sc02C::SendInput ^{sc02C} ; Undo  cmd+z
#+sc02C::SendInput ^+{sc02C} ; UnUndo  shift+cmd+z
#sc02D::SendInput ^{sc02D} ; Cut cmd+x
#sc02E::SendInput ^{sc02E} ; Copy  cmd+c
#sc02F::SendInput ^{sc02F} ; Paste  cmd+v
#sc031::SendInput ^{sc031} ; New  cmd+n
#sc01E::SendInput ^{sc01E} ; Select All cmd+a
#sc01F::SendInput ^{sc01F} ; Save  cmd+s
#sc021::SendInput ^{sc021} ; Find  cmd+f
#sc018::SendInput ^{sc018} ; Open  cmd+o
#sc011::SendInput ^{F4} ; Close  cmd+w
#sc014::SendInput ^{sc014} ; New Tab cmd+t
#sc013::SendInput ^{sc013} ; Reload cmd+r

;==============================================================
;Выполнение команд независимо от языка в MS Office через cmd+{Key}: 
;   Bold, Italic 
;==============================================================

#sc030::SendInput ^{sc030} ; Bold  cmd+b 
#sc017::SendInput ^{sc017} ; Italic  cmd+i

/?/?.6,;8
;==============================================================
;Корректное отображение символов в соответсвии с RU/ENG Apple Keyboard
;==============================================================

$+5::CheckRus(":","%") ; Двоеточие через Shift+5
$+6::CheckRus(",","^") ; Запятая через Shift+6
$+7::CheckRus(".","&") ; Точка через Shift+7
$+8::CheckRus(";","*") ; Точка с запятой через Shift+8
;$+/::CheckRus("?","?")  ; Вопрос через Shift+/
sc035::Send / ; Reload cmd+r
$+sc035::Send ? ; Reload cmd+r
CheckRus(rus,eng)
{
    SetFormat, Integer, H
    WinGet, WinID,, A
    ThreadID:=DllCall("GetWindowThreadProcessId", "Int", WinID, "Int", 0)
    InputLocaleID:=DllCall("GetKeyboardLayout", "Int", ThreadID)
    if(InputLocaleID == "0x4190419")
    {
        Send %rus%
    }
    if(InputLocaleId == "0x4090409")
    {
        SendRaw %eng%
    }
Return
}
