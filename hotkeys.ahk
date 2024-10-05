#Requires AutoHotkey v2.0
#SingleInstance Force

; https://github.com/regulad/hotkeys

; Store information about all monitors
MonitorGetWorkArea(1, &primary_left, &primary_top, &primary_right, &primary_bottom)
primary_width := primary_right - primary_left
primary_height := primary_bottom - primary_top

; Create an array to store the GUI windows
overlay_windows := []

; Hotkey to toggle overlay (Ctrl+Alt+B for "Blinders")
^!b::ToggleOverlay()

ToggleOverlay() {
    global overlay_windows
    
    if (overlay_windows.Length = 0) {
        ; Create overlays
        loop MonitorGetCount() - 1 {
            MonitorGetWorkArea(A_Index + 1, &left, &top, &right, &bottom)
            width := right - left
            height := bottom - top
            
            new_overlay := Gui()
            new_overlay.Opt("+AlwaysOnTop -Caption +ToolWindow")
            new_overlay.BackColor := "Black"
            new_overlay.Show(Format("x{} y{} w{} h{}", left, top, width, height))
            
            overlay_windows.Push(new_overlay)
        }
    } else {
        ; Remove overlays
        for window in overlay_windows {
            window.Destroy()
        }
        overlay_windows := []
    }
}

^!T:: Run, wt.exe  ; Launch Windows Terminal with Ctrl+Alt+T

^!s:: Send "{U+2245}" ; Send Congruent
^!a:: Send "{U+2220}" ; Send Angle
^!r:: Send "{U+221F}" ; Send Right Angle
^!d:: Send "{U+2221}" ; Send Measured Angle
^!<:: Send "{U+2264}" ; Send Less than or equal to
^!>:: Send "{U+2265}" ; Send greater than or equal to
^!0:: Send "{U+00B1}" ; send plus/minus
^!t:: Send "{U+25B3}" ; send triangle
^!Left:: Send "{U+2190}" ; send left arrow
^!Up:: Send "{U+2191}" ; send up arrow
^!Right:: Send "{U+2192}" ; send right arrow
^!Down:: Send "{U+2193}" ; send down arrow
!+e:: Send "{U+00C8}" ; upper grave e
!e:: Send "{U+00E8}" ; grave e
^!+e:: Send "{U+00C9}" ; upper acute e
^!e:: Send "{U+00E9}" ; acute e
RAlt & k:: AltTab ; move right in the alttab menu
RAlt & j:: ShiftAltTab ; move left
