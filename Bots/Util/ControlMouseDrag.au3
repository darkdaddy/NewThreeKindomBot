

Func _MakeLong($LoWord,$HiWord)
   Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc

Func ControlMouseDrag($hWnd, $X1, $Y1, $X2, $Y2, $Button = "left", $Step = 3, $Delay = 50)
   If Not IsHWnd($hWnd) And $hWnd <> "" Then
	  $hWnd = WinGetHandle($hWnd)
   EndIf

   If Not IsHWnd($hWnd) Then
	  Return SetError(1, "", False)
   EndIf

   If Not IsInt($X1) Or Not IsInt($Y1) Then
	  Return SetError(2, "", False)
   EndIf

   If Not IsInt($X2) Or Not IsInt($Y2) Then
	  Return SetError(3, "", False)
   EndIf

   If StringLower($Button) == "left" Then
	  $Button = $WM_LBUTTONDOWN
	  $Pressed = 1
   ElseIf StringLower($Button) == "right" Then
	  $Button = $WM_RBUTTONDOWN
	  $Pressed = 2
   ElseIf StringLower($Button) == "middle" Then
	  $Button = $WM_MBUTTONDOWN
	  $Pressed = 10
	  If $Delay == 10 Then $Delay = 100
   EndIf

   $User32 = DllOpen("User32.dll")
   If @error Then Return SetError(4, "", False)

   DllCall($User32, "bool", "PostMessage", "hwnd", $hWnd, "int", $Button, "int", "0", "long", _MakeLong($X1, $Y1))
   If @error Then Return SetError(5, "", False)

   Sleep($Delay / 2)

   $xmode = False
   $i = 0
   If Not (($X2 - $X1) == 0) Then
	  $gradient = Abs(($Y2 - $Y1) * 1.0 / ($X2 - $X1))
	  $to = Abs($X2 - $X1)
	  $xmode = True
	  If $X2 > $X1 Then $up = True
   Else
	  $to = Abs($Y2 - $Y1)
	  If $Y2 > $Y1 Then
		 $gradient = 1
	  Else
		 $gradient = -1
	  EndIf
   EndIf

   _log($TRACE, "ControlMouseDrag called : " & $X1 & "," & $Y1 & "->" & $X2 & "," & $Y2 & ", gradient = " & $gradient & ", to = " & $to );

   $i = 0
   While $i < $to
	  If $xmode Then
		 $y = $gradient * $i
		 $x = $i

		 If $X2 < $X1 Then
			$x = $x * -1
		 EndIf
		 If $Y2 < $Y1 Then
			$y = $y * -1
		 EndIf
	  Else
		 $x = 0
		 $y = $gradient * $i
	  EndIf
	  _log($TRACE, "ControlMouseDrag pos = " & $X1 + $x & " x " & $Y1 + $y );
	  DllCall($User32, "bool", "PostMessage", "hwnd", $hWnd, "int", $WM_MOUSEMOVE, "int", $Pressed, "long", _MakeLong(Round($X1 + $x), Round($Y1 + $y)))
	  If @error Then Return SetError(6, "", False)
	  Sleep(1)
	  $i = $i + $Step
   WEnd

   DllCall($User32, "bool", "PostMessage", "hwnd", $hWnd, "int", $Button + 1, "int", "0", "long", _MakeLong($X2, $Y2))
   If @error Then Return SetError(7, "", False)

   DllClose($User32)
   Return SetError(0, 0, True)
EndFunc