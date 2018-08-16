#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         gunoodaddy

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

Func CloseAllMenu()

   CloseMenu("Main", $CHECK_BUTTON_TOP_CLOSE)
   CloseMenu("Event", $CHECK_BUTTON_EVENT_CLOSE)
   CloseMenu("NearBy", $CHECK_BUTTON_NEARBY_CLOSE)
   CloseMenu("Select-Troops", $CHECK_BUTTON_SELECT_TROOPS_CLOSE)
   CloseMenu("Field-Menu", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
   CloseMenu("Charge-AttackPoint", $CHECK_BUTTON_CHARGE_ATTACK_POINT_CLOSE)
EndFunc


Func ClickMoveButton($number)
   If $number == 1 Then
	  If CheckForPixelList($CHECK_BUTTON_GREEN_MOVE1) Then
		 SetLog("Move Button 1 Found", $COLOR_DARKGREY)
		 ClickControlPos($POS_BUTTON_GREEN_MOVE1, 1)
		 Return True
	  EndIf
   ElseIf $number == 2 Then
	  If CheckForPixelList($CHECK_BUTTON_GREEN_MOVE2) Then
		 SetLog("Move Button 2 Found", $COLOR_DARKGREY)
		 ClickControlPos($POS_BUTTON_GREEN_MOVE2, 1)
		 Return True
	  EndIf
   ElseIf $number == 3 Then
	  If CheckForPixelList($CHECK_BUTTON_GREEN_MOVE3) Then
		 SetLog("Move Button 3 Found", $COLOR_DARKGREY)
		 ClickControlPos($POS_BUTTON_GREEN_MOVE3, 1)
		 Return True
	  EndIf
   ElseIf $number == 4 Then
	  If CheckForPixelList($CHECK_BUTTON_GREEN_MOVE4) Then
		 SetLog("Move Button 4 Found", $COLOR_DARKGREY)
		 ClickControlPos($POS_BUTTON_GREEN_MOVE4, 1)
		 Return True
	  EndIf
   EndIf
   Return False
EndFunc

Func SelectTroop($number)
   SetLog("Troop " & $number & " Selected", $COLOR_PINK)

   If $number == 1 Then
	  ClickControlPos($POS_BUTTON_TROUP1, 2)
   ElseIf $number == 2 Then
	  ClickControlPos($POS_BUTTON_TROUP2, 2)
   ElseIf $number == 3 Then
	  ClickControlPos($POS_BUTTON_TROUP3, 2)
   ElseIf $number == 4 Then
	  ClickControlPos($POS_BUTTON_TROUP4, 2)
   EndIf
EndFunc

Func CollectResources()

   SetLog("Collect all resources...", $COLOR_PINK)
   CloseAllMenu()

   If _Sleep(500) Then Return False

   ; Go to castle view
   Local $tryCount = 1
   While $RunState And $tryCount < $MaxTryCount
	  If CheckForPixelList($CHECK_MAIN_CASTLE_VIEW) Then
		 ExitLoop
	  Else
		 ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
		 If _Sleep(2500) Then Return False
	  EndIf
   WEnd

   Local Const $Delay = 500
   ClickControlPos("25.34:44.24", 2)	; click Barrack
   If _Sleep($Delay) Then Return False
   ClickControlPos("15.35:32.98", 2)	; click Coin
   If _Sleep($Delay) Then Return False
   ClickControlPos("85.39:66.76", 2)	; click Castle Wall
   If _Sleep($Delay) Then Return False

   ClickControlPos("26.19:57.34", 2)	; click Stone (left)
   If _Sleep($Delay/2) Then Return False
   ClickControlPos("83.82:60.94", 2)	; click Wood (right)
   If _Sleep($Delay/2) Then Return False

   ClickControlPos("27.12:74.79", 2)	; click Stone Place (right)
   If _Sleep($Delay * 2) Then Return False

   ClickControlPos("27.58:39.89", 2)	; click Steel (left)
   If _Sleep($Delay/2) Then Return False

   ClickControlPos("21.11:78.67", 2)	; click Wood House (left)
   If _Sleep($Delay * 2) Then Return False

   ClickControlPos("70.11:61.22", 2)	; click Rice (left)
   If _Sleep($Delay/2) Then Return False

   If _Sleep(800) Then Return False

   ; go out
   ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
    If _Sleep(2000) Then Return False
   Return True
EndFunc

Func ReadyToAttackState()
   SetLog("Go to my castle position...", $COLOR_PINK)

   ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
   If _Sleep(2000) Then Return False

   Local $tryCount = 1
   While $RunState And $tryCount < $MaxTryCount
	  CloseAllMenu()

	  If CheckForPixelList($CHECK_MAIN_CASTLE_VIEW) Then
		 SetLog("Main castle view detected", $COLOR_DARKGREY)

		 ClickControlPos($POS_BUTTON_GOTO_MAP, 3)
		 If _Sleep(1000) Then Return False
	  EndIf

	  If CheckForPixel($CHECK_BUTTON_NEARBY[0]) Then
		 SetLog("NearBy Button Found", $COLOR_DARKGREY)
		 ExitLoop
	  EndIf

	  $tryCount = $tryCount + 1
   WEnd
   If $tryCount == $MaxTryCount Then
	  Return False
   EndIf
   Return True
EndFunc

Func DoChargeBarrack()
   SetLog("Recharge troop barrack...", $COLOR_PINK)
   If Not OpenMenu("Barrack", $POS_BUTTON_BARRACK_MENU, $CHECK_BUTTON_FIELD_MENU_CLOSE) Then
	  Return False
   EndIf
   ClickControlPos($POS_BUTTON_BARRACK_MENU1, 2)
   If _Sleep(500) Then Return False
   ClickControlPos($POS_BUTTON_BARRACK_MAKE, 2)
   If _Sleep(500) Then Return False
   ClickControlPos($POS_BUTTON_BARRACK_MENU2, 2)
   If _Sleep(500) Then Return False
   ClickControlPos($POS_BUTTON_BARRACK_MAKE, 2)
   CloseMenu("Barrack", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   Return True
EndFunc

Func CheckTroopAvailable()
   If Not OpenMenu("Status-Troops", $POS_BUTTON_STATUS_TROOPS, $CHECK_BUTTON_FIELD_MENU_CLOSE) Then
	  CloseAllMenu()
	  Return 0
   EndIf
   If _Sleep(800) Then Return 0

   $result = 0
   If Not CheckForPixelList($CHECK_STATUS_ATTACK_TROOP1, $DefaultTolerance, True) Then
	  $result = 1
   ElseIf Not CheckForPixelList($CHECK_STATUS_ATTACK_TROOP2, $DefaultTolerance, True) Then
	  $result = 2
   ElseIf NOT CheckForPixelList($CHECK_STATUS_ATTACK_TROOP3, $DefaultTolerance, True) Then
	  $result = 3
   ElseIf NOT CheckForPixelList($CHECK_STATUS_ATTACK_TROOP4, $DefaultTolerance, True) Then
	  $result = 4
   EndIf

   If $result > $setting_attack_troup_count Then
	  $result = 0
   EndIf

   If $result > 0 Then
	  SetLog("Troop " & $result & " Available", $COLOR_PINK)
   Else
	  SetLog("All Troops Busy", $COLOR_PINK)
   EndIf

   CloseMenu("Status-Troops", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   Return $result
EndFunc

Func GoToNearByEmemy($troopNumber)

   Local Const $MaxMoveCount = 5
   $tryCount = 0
   While $RunState And $tryCount < $MaxMoveCount

	  ; Open NearBy Screen
	  If Not OpenMenu("NearBy", $POS_BUTTON_NEARBY, $CHECK_BUTTON_NEARBY_CLOSE) Then
		 Return False
	  EndIf

	  ; Click Move Button
	  If ClickMoveButton($troopNumber) Then
		 Return True;
	  Else
		 ; Not found "move" button
		 SetLog("Move button " & $troopNumber & " not found", $COLOR_RED)

		 ; this means that there is no more enemy in this near field.
		 ; go to anywhere to dragging
		 CloseMenu("NearBy", $CHECK_BUTTON_NEARBY_CLOSE)
		 If _Sleep(800) Then Return False

		 SetLog("Go some near place...", $COLOR_PINK)
		 If Mod($tryCount, 2) == 0 Then
			DragControlPos("80:80", "10:10", 5);
		 Else
			DragControlPos("20:80", "80:10", 5);
		 EndIf
	  EndIf
	  If _Sleep(800) Then Return False
	  $tryCount = $tryCount + 1
   WEnd
   SetLog("Enemy not found...", $COLOR_RED)
   Return False
EndFunc

Func DoKillFieldMonster($troopNumber)

   Local $tryCount = 1

   GoToNearByEmemy($troopNumber)

   ; Click Attack Button & Open Select-Troup Menu
   $tryCount = 1
   While $RunState And $tryCount < $MaxTryCount
	  If _Sleep(500) Then Return False

	  If CheckForPixelList($CHECK_BUTTON_FIELD_ATTACK) Then
		 ClickControlPos($POS_BUTTON_FIELD_ATTACK, 1)
	  EndIf

	  If _Sleep(800) Then Return False

	  If CheckForPixelList($CHECK_BUTTON_SELECT_TROOPS_CLOSE) Then
		 SetLog("Open Select Troop Menu", $COLOR_PINK)
		 ExitLoop
	  EndIf

	  If CheckForPixelList($CHECK_BUTTON_CHARGE_ATTACK_POINT_CLOSE) Then
		 SetLog("Charge Attack Point", $COLOR_RED)
		 ClickControlPos($POS_BUTTON_CHARGE_ATTACK_POINT, 1)
		 If _Sleep(1200) Then Return False
	  EndIf

	  $tryCount = $tryCount + 1
   WEnd
   If $tryCount == $MaxTryCount Then
	  Return False
   EndIf

   ; Select troop number
   SelectTroop($troopNumber)
   If _Sleep(400) Then Return False

   ; Start Attack!!
   ClickControlPos($POS_BUTTON_START_ATTACK, 2)
   If _Sleep(1000) Then Return False

   If CheckForPixelList($CHECK_BUTTON_ALERT_CLOSE) Then
	  SetLog("Alert! Can not attack...", $COLOR_RED)

	  CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
	  If _Sleep(400) Then Return False
	  CloseMenu("Select-Troops", $CHECK_BUTTON_SELECT_TROOPS_CLOSE)
	  Return False
   EndIf
   SetLog("Go Attack!", $COLOR_PINK)
   Return True
EndFunc