
Func AutoFlow()

   SetLog("Auto Kill FieldMonster Start", $COLOR_GREEN)
   Local $attackCount = 1
   Local $loopCount = 1

   ;DragControlPos("70:30", "40:70");
   ;DragControlPos("40:70", "70:30");
   ;DragControlPos("70:70", "70:30");
   ;DragControlPos("40:40", "70:70");
   ;DragControlPos("70:70", "40:40");
   ;CollectResources()
   ;DragControlPos("12.16:87.62", "30.51:50.79");
   ;Return False

   ReadyToAttackState()

   While $RunState

	  SetLog("Loop Count : " & $attackCount, $COLOR_ORANGE)

	  ; Checking available
	  $troopNumber = CheckTroopAvailable()

	  If $troopNumber > 0 Then
		 ; Go!!
		 If _Sleep(800) Then Return False

		 DragControlPos("12.16:87.62", "30.51:50.79");

		 If DoKillFieldMonster($troopNumber) Then
			SetLog("Attack Count : " & $attackCount, $COLOR_BLUE)
			$attackCount = $attackCount + 1
		 EndIf

		 $needToCollectResources = False
		 If Mod($loopCount, 100) == 0 Then
			CollectResources()
			; already go out to field
		 Else
			ReadyToAttackState()
		 EndIf

	  EndIf

	  If _Sleep(5000) Then Return False

	  If Mod($loopCount, 50) == 0 Then
		 DoChargeBarrack()
	  EndIf

	  $loopCount = $loopCount + 1
   WEnd

   SetLog("Auto Kill FieldMonster End", $COLOR_GREEN)
   Return True

EndFunc