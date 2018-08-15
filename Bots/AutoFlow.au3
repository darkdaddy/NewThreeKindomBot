
Func AutoFlow()

   SetLog("Auto Kill FieldMonster Start", $COLOR_GREEN)
   Local $attackCount = 1

   ;DragControlPos("70:30", "40:70");
   ;DragControlPos("40:70", "70:30");
   ;DragControlPos("70:70", "70:30");
   ;Return False
   ;CollectResources()
   ;Return False

   ReadyToAttackState()

   While $RunState

	  ; Checking available
	  $troopNumber = CheckTroopAvailable()

	  If $troopNumber > 0 Then
		 ; Go!!
		 If _Sleep(800) Then Return False

		 DragControlPos("12.16:87.62", "30.51:50.79");

		 If DoKillFieldMonster($troopNumber) Then
			SetLog("Attack Count : " & $attackCount, $COLOR_RED)
			$attackCount = $attackCount + 1
		 EndIf

		 $needToCollectResources = False
		 If Mod($attackCount, 15) == 0 Then
			$needToCollectResources = True
		 EndIf

		 ReadyToAttackState($needToCollectResources)

	  EndIf

	  If _Sleep(5000) Then Return False

	  If Mod($attackCount, 5) == 0 Then
		 DoChargeBarrack()
	  EndIf

   WEnd

   SetLog("Auto Kill FieldMonster End", $COLOR_GREEN)
   Return True

EndFunc