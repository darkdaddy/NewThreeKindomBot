
Global $PrevLogText = ""

Func SetLog($level, $String, $Color = 0x000000) ;Sets the text for the log
   If $level < $CurrentLogLevel Then
	  _console($String)
	  Return
   EndIf

   If $PrevLogText <> $String Then
	  _GUICtrlRichEdit_AppendTextColor($txtLog, Time(), 0x000000)
	  _GUICtrlRichEdit_AppendTextColor($txtLog, $String & @CRLF, _ColorConvert($Color))
   EndIf
   $PrevLogText = $String
   _log($level, $String)
EndFunc   ;==>SetLog

Func _GUICtrlRichEdit_AppendTextColor($hWnd, $sText, $iColor)
	Local $iLength = _GUICtrlRichEdit_GetTextLength($hWnd, True, True)
	Local $iCp = _GUICtrlRichEdit_GetCharPosOfNextWord($hWnd, $iLength)
	_GUICtrlRichEdit_AppendText($hWnd, $sText)
	_GUICtrlRichEdit_SetSel($hWnd, $iCp - 1, $iLength + StringLen($sText))
	_GUICtrlRichEdit_SetCharColor($hWnd, $iColor)
	_GUICtrlRichEdit_Deselect($hWnd)
EndFunc   ;==>_GUICtrlRichEdit_AppendTextColor


Func _log($level, $String)
   If $level < $CurrentLogLevel Then
	  Return
   EndIf
   Local $t = Time() & " " & $String
   _FileWriteLog($hLogFileHandle, $t)
   ConsoleWrite($t & @CRLF)
EndFunc

Func _console($String)
   Local $t = Time() & " " & $String
   ConsoleWrite($t & @CRLF)
EndFunc


Func _ColorConvert($nColor);RGB to BGR or BGR to RGB
	Return _
			BitOR(BitShift(BitAND($nColor, 0x000000FF), -16), _
			BitAND($nColor, 0x0000FF00), _
			BitShift(BitAND($nColor, 0x00FF0000), 16))
EndFunc   ;==>_ColorConvert
