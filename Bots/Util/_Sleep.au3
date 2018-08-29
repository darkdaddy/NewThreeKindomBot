Func _Sleep($iDelay, $bAllowPause = True)
   Local $iBegin = TimerInit()
   $actualDelay = $iDelay - ($iDelay * ($setting_game_speed_rate - 1.0))
   _console("Sleep : " & $iDelay & "(" & $actualDelay & ")")
   While TimerDiff($iBegin) < $actualDelay
	  If $RunState = False Then Return True
	  While ($PauseBot And $bAllowPause)
		 Sleep(1000)
	  WEnd
	  tabChanged()
	  Sleep(($actualDelay > 50) ? 50 : 1)
   WEnd
   Return False
EndFunc   ;==>_Sleep
