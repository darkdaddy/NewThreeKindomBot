Func _Sleep($iDelay, $bAllowPause = True, $bApplySpeedRate = True)
   Local $iBegin = TimerInit()
   Local $iActualDelay = $iDelay
   If $bApplySpeedRate Then
	  $iActualDelay = $iDelay - ($iDelay * ($setting_game_speed_rate - 1.0))
   EndIf
   ;_console("Sleep : " & $iDelay & "(" & $iActualDelay & ")")
   While TimerDiff($iBegin) < $iActualDelay
	  If $RunState = False Then Return True
	  While ($PauseBot And $bAllowPause)
		 Sleep(100)
		 tabChanged()
	  WEnd
	  tabChanged()
	  Sleep(($iActualDelay > 50) ? 50 : 1)
   WEnd
   Return False
EndFunc   ;==>_Sleep


Func _SleepAbs($iDelay)
   Return _Sleep($iDelay, True, False)
EndFunc
