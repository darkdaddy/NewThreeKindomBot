#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         gunoodaddy

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------


Func CloseAllMenu()
   If CheckForPixelList($CHECK_MAIN_CASTLE_VIEW) Then
	  Return
   EndIf
   CloseMenu("Main", $CHECK_BUTTON_TOP_CLOSE)
   CloseMenu("Event", $CHECK_BUTTON_EVENT_CLOSE)
   CloseMenu("NearBy", $CHECK_BUTTON_NEARBY_CLOSE)
   CloseMenu("Select-Troops", $CHECK_BUTTON_SELECT_TROOPS_CLOSE)
   CloseMenu("Capital-Treasure", $CHECK_BUTTON_CAPITAL_TREASURE_CLOSE)
   CloseMenu("Center-Battle", $CHECK_BUTTON_CENTER_BATTLE_EVENT_CLOSE)
   CloseMenu("Clan-Mission", $CHECK_BUTTON_CLAN_MISSION_CLOSE)
   CloseMenu("Hero-Collection", $CHECK_BUTTON_HERO_COLLECTION_CLOSE)
   CloseMenu("Field-Menu", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
   CloseMenu("Use-Point", $CHECK_BUTTON_USE_ACTION_POINT_CLOSE)
   CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)
   CloseMenu("Dungeon-Sweep-Count", $CHECK_BUTTON_DUNGEON_SWEEP_COUNT_CLOSE)
   CloseMenu("Favorite", $CHECK_BUTTON_FAVORITE_CLOSE)
   CloseMenu("Help", $CHECK_BUTTON_HELP_CLOSE)
   CloseMenu("Castle-Menu", $CHECK_BUTTON_CASTLE_MENU_CLOSE)
   CloseMenu("Altar", $CHECK_BUTTON_ALTAR_CLOSE)
EndFunc


Func RebootNox()
   If Not $HWnDTool Or StringLen($setting_game_icon_pos) <= 0 Then
	  ; Nothing to do
	  Return True
   EndIf

   SetLog("Reboot Starting...", $COLOR_GREEN)

   ; Kill Current Game
   ClickHandle($HWnDTool, $WinRectTool[2]/2, $WinRectTool[3] - 35 )
   If _Sleep(1000) Then Return False
   DragControlPos("90:50", "90:10", 5);
   If _Sleep(300) Then Return False
   DragControlPos("90:50", "90:10", 5);
   If _Sleep(1000) Then Return False

   ; Restart
   ClickControlPos($setting_game_icon_pos, 3)

   ; Check Castle view
   Local $tryCount = 1
   While $RunState And $tryCount < 60
	  If CheckForPixelList($CHECK_MAIN_CASTLE_VIEW) Then
		 SetLog("Reboot OK", $COLOR_RED)
		 Return True
	  EndIf
  	  ClickControlPos($POS_BUTTON_NOTICE_CLOSE, 1)
	  ClickControlPos($POS_BUTTON_GAME_START, 1)

	  CloseMenu("Help", $CHECK_BUTTON_HELP_CLOSE)

	  If _Sleep(1500) Then Return False
	  $tryCount += 1
   WEnd

   SetLog("Reboot Failure", $COLOR_RED)
   Return False
EndFunc


Func PullOutAllResourceTroops()

   If Not $setting_checked_resource_gathering Then
	  ; Nothing to do
	  Return True
   EndIf

   If Not OpenMenu("Status-Troops", $POS_BUTTON_STATUS_TROOPS, $CHECK_BUTTON_FIELD_MENU_CLOSE) Then
	  CloseAllMenu()
	  Return 0
   EndIf

   Local $checkInfoList[4]
   $checkInfoList[0] = $CHECK_STATUS_ATTACK_TROOP1
   $checkInfoList[1] = $CHECK_STATUS_ATTACK_TROOP2
   $checkInfoList[2] = $CHECK_STATUS_ATTACK_TROOP3
   $checkInfoList[3] = $CHECK_STATUS_ATTACK_TROOP4

   For $i = 0 To 3
	  If $setting_gather_troup_enabled[$i] Then
		 If CheckForPixelList($checkInfoList[$i], $DefaultTolerance, True) Then
			SetLog("Pull Out Troop : " & ($i+1), $COLOR_BLUE)

			SelectTroopInStatusMenu($i+1)
			If _Sleep(300) Then Return False

			ClickControlPos($POS_BUTTON_STATUS_TROOPS_PULLOUT, 2)
			If _Sleep(600) Then Return False

			If CheckForPixelList($CHECK_BUTTON_ALERT_CLOSE) Then
			   ClickControlPos($POS_BUTTON_ALERT_OK, 2)
			EndIf
		 EndIf
	  EndIf
   Next

   CloseMenu("Status-Troops", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   Return True
EndFunc


Func HireFreeHeroInternal()
   SetLog("Hire Free Hero", $COLOR_BLUE)
   ClickControlPos("74.48:48.54", 1)
   If _Sleep(1000) Then Return False

   If Not CheckForPixelList($CHECK_BUTTON_HIRE_FREE_HERO) Then
	  CloseMenu("Pub", $CHECK_BUTTON_TOP_CLOSE)
	  Return False
   EndIf

   ; First hire!
   ClickControlScreen($CHECK_BUTTON_HIRE_FREE_HERO[0], 1)
   $hireCount = 1
   SetLog("Hired here : " & $hireCount, $COLOR_PINK)

   Local Const $MaxHireCount = 10
   While $RunState
	  ; Click Skip Button
	  ClickControlPos("89.52:91.9", 3)

	  If CheckForPixelList($CHECK_BUTTON_HIRE_FREE_HERO_ONE_MORE) Then
		 If $hireCount >= $MaxHireCount Then
			ClickControlPos("37.35:92.33", 2)
			ExitLoop
		 EndIf

		 ClickControlScreen($CHECK_BUTTON_HIRE_FREE_HERO_ONE_MORE[0], 1)
		 $hireCount += 1
		 SetLog("Hired here : " & $hireCount, $COLOR_PINK)
	  EndIf
	  If _Sleep(500) Then Return False
   WEnd
   If _Sleep(1200) Then Return False
   CloseMenu("Pub", $CHECK_BUTTON_TOP_CLOSE)
   Return True
EndFunc

Func GetMySalaryInternal()
   SetLog("Get My Salary", $COLOR_BLUE)

   ; Get my salary
   ClickControlPos($POS_BUTTON_MY_PROFILE_ICON, 2)
   If _Sleep(800) Then Return False
   ClickControlPos("23.82:83.33", 2)
   If _Sleep(1000) Then Return False
   CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
   If _Sleep(800) Then Return False
   CloseMenu("MyProfile", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   If _Sleep(800) Then Return False

   ; Get my monthly point
   ClickControlPos($POS_BUTTON_MONTHLY_POINT, 1)
   If _Sleep(800) Then Return False
   ClickControlPos("43.68:81.75", 2)	; button 1
   If _Sleep(300) Then Return False
   ClickControlPos("68.82:81.75", 2)	; button 2
   If _Sleep(800) Then Return False
   ClickControlPos("85.88:26.98", 2)	; close

   ; Get guild salary
   ClickControlPos($POS_BUTTON_GUILD, 1)
   If _Sleep(800) Then Return False
   ClickControlPos("79.15:40.89", 2)	; salary button
   If _Sleep(800) Then Return False
   ClickControlPos("49.52:81.2", 2)		; salary button
   If _Sleep(1000) Then Return False
   CloseMenu("Guild-Salary", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   If _Sleep(300) Then Return False
   ClickControlPos("15.5:78.08", 2)		; donate button
   If _Sleep(800) Then Return False
   ClickControlPos("68.59:48.03", 2)	; gold donate

   CloseMenu("Field-Menu", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   If _Sleep(800) Then Return False
   CloseMenu("Main", $CHECK_BUTTON_TOP_CLOSE)
EndFunc


Func AltarResourceInternal()
   SetLog("Altar All Resources", $COLOR_BLUE)

   Local Const $AlterDelay = 1600
   Local Const $startButton = "49.85:83.86"

   ; Tab 1
   If _Sleep(800) Then Return False
   ClickControlPos("19.56:30.95", 2)
   If _Sleep(500) Then Return False
   ClickControlPos($startButton, 2)
   If _Sleep($AlterDelay) Then Return False
   CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)

    ; Tab 2
   If _Sleep(800) Then Return False
   ClickControlPos("19.56:46.95", 2)
   If _Sleep(500) Then Return False
   ClickControlPos($startButton, 2)
   If _Sleep($AlterDelay) Then Return False
   CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)

    ; Tab 3
   If _Sleep(800) Then Return False
   ClickControlPos("19.56:60.95", 2)
   If _Sleep(500) Then Return False
   ClickControlPos($startButton, 2)
   If _Sleep($AlterDelay) Then Return False
   CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)

    ; Tab 4
   If _Sleep(800) Then Return False
   ClickControlPos("19.56:74.95", 2)
   If _Sleep(500) Then Return False
   ClickControlPos($startButton, 2)
   If _Sleep($AlterDelay) Then Return False
   CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)

   If _Sleep(1000) Then Return False
   CloseMenu("Altar", $CHECK_BUTTON_ALTAR_CLOSE)
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


Func ClickFavoriteResourceMoveButton($number)
   If $number == 1 Then
	  If CheckForPixelList($CHECK_STATUS_FAVORITE_ERASE_BUTTON1) Then
		 SetLog("Move Button 1 Found", $COLOR_DARKGREY)
		 ClickControlPos($POS_BUTTON_FAVORITE_MOVE1, 1)
		 Return True
	  EndIf
   ElseIf $number == 2 Then
	  If CheckForPixelList($CHECK_STATUS_FAVORITE_ERASE_BUTTON2) Then
		 SetLog("Move Button 2 Found", $COLOR_DARKGREY)
		 ClickControlPos($POS_BUTTON_FAVORITE_MOVE2, 1)
		 Return True
	  EndIf
   ElseIf $number == 3 Then
	  If CheckForPixelList($CHECK_STATUS_FAVORITE_ERASE_BUTTON3) Then
		 SetLog("Move Button 3 Found", $COLOR_DARKGREY)
		 ClickControlPos($POS_BUTTON_FAVORITE_MOVE3, 1)
		 Return True
	  EndIf
   ElseIf $number == 4 Then
	  DragControlPos("70:80", "70:20", 10);
	  If _Sleep(1000) Then Return False
	  If CheckForPixelList($CHECK_STATUS_FAVORITE_ERASE_BUTTON4) And Not CheckForPixelList($CHECK_STATUS_FAVORITE_ERASE_BUTTON3) Then
		 SetLog("Move Button 4 Found", $COLOR_DARKGREY)
		 ClickControlPos($POS_BUTTON_FAVORITE_MOVE4, 1)
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


Func SelectTroopInStatusMenu($number)
   SetLog("Troop " & $number & " Selected", $COLOR_PINK)

   If $number == 1 Then
	  ClickControlPos($POS_BUTTON_STATUS_TROUP1, 2)
   ElseIf $number == 2 Then
	  ClickControlPos($POS_BUTTON_STATUS_TROUP2, 2)
   ElseIf $number == 3 Then
	  ClickControlPos($POS_BUTTON_STATUS_TROUP3, 2)
   ElseIf $number == 4 Then
	  ClickControlPos($POS_BUTTON_STATUS_TROUP4, 2)
   EndIf
EndFunc


Func CollectResources()

   SetLog("Collect all resources start", $COLOR_GREEN)

   ; Go to castle view
   Local $tryCount = 1
   While $RunState And $tryCount < $MaxTryCount
	  If CheckForPixelList($CHECK_MAIN_CASTLE_VIEW) Then
		 ExitLoop
	  Else
		 CloseAllMenu()
		 If _Sleep(500) Then Return False
		 ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
		 If _Sleep($ViewChangeWaitMSec) Then Return False
	  EndIf
   WEnd
   If $tryCount == $MaxTryCount Then Return False

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
   If _Sleep($ViewChangeWaitMSec) Then Return False
   SetLog("Collect all resources end", $COLOR_GREEN)
   Return True
EndFunc

Func GoToFieldNearByMyCastle()
   SetLog("Checking center field view...", $COLOR_PINK)
   ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
   If _Sleep($ViewChangeWaitMSec) Then Return False

   GoToField()
EndFunc

Func GoToField()
   SetLog("Go to field view..", $COLOR_DARKGREY)
   Local $tryCount = 1
   While $RunState And $tryCount < $MaxTryCount
	  If _Sleep(300) Then Return False

	  If CheckForPixelList($CHECK_MAIN_CASTLE_VIEW) Then
		 SetLog("Castle view detected...", $COLOR_BLUE)

		 ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
		 If _Sleep($ViewChangeWaitMSec) Then Return False
	  EndIf

	  If CheckForPixelList($CHECK_MAIN_FIELD_VIEW) Then
		 SetLog("Field view detected...", $COLOR_BLUE)
		 ExitLoop
	  EndIf

	  If _Sleep(1000) Then Return False

	  CloseAllMenu()

	  $tryCount = $tryCount + 1
   WEnd
   If $tryCount == $MaxTryCount Then Return False
   Return True

EndFunc

Func DoRecruitBarrack()
   SetLog("Recruit troop barrack...", $COLOR_PINK)
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

Func CheckTroopAvailableList()

   Local $result = [False, False, False, False]

   If Not OpenMenu("Status-Troops", $POS_BUTTON_STATUS_TROOPS, $CHECK_BUTTON_FIELD_MENU_CLOSE) Then
	  CloseAllMenu()
	  Return 0
   EndIf
   If _Sleep(800) Then Return 0

   If Not CheckForPixelList($CHECK_STATUS_ATTACK_TROOP1, $DefaultTolerance, True) Then
	  $result[0] = True
   EndIf
   If Not CheckForPixelList($CHECK_STATUS_ATTACK_TROOP2, $DefaultTolerance, True) Then
	  $result[1] = True
   EndIf
   If NOT CheckForPixelList($CHECK_STATUS_ATTACK_TROOP3, $DefaultTolerance, True) Then
	  $result[2] = True
   EndIf
   If NOT CheckForPixelList($CHECK_STATUS_ATTACK_TROOP4, $DefaultTolerance, True) Then
	  $result[3] = True
   EndIf

   $troopStr = ""
   For $i = 0 To 3
	  If $result[$i] Then
		 $troopStr = $troopStr & ($i + 1) & " "
	  EndIf
   Next
   If StringLen($troopStr) > 0 Then
	  SetLog("Troop Available : " & $troopStr, $COLOR_PINK)
   Else
	  SetLog("All Troops Busy", $COLOR_PINK)
   EndIf

   CloseMenu("Status-Troops", $CHECK_BUTTON_FIELD_MENU_CLOSE)
   Return $result
EndFunc

Func GoToNearByEmemy($troopNumber)

   Local Const $DragSpeed = 7
   Local Const $MaxMoveCount = 5
   $tryCount = 0

   Local $actualTroopMoveNumber = $troopNumber
   Local $totalTroopCount = 0
   For $i = 0 To 3
	  If $setting_attack_troup_enabled[$i] Then
		 $totalTroopCount += 1
	  EndIf

	  If ($i+1) == $troopNumber Then
		 $actualTroopMoveNumber = $totalTroopCount
	  EndIf
   Next

   SetLog("Finding Move Button " & $actualTroopMoveNumber & " for Troop " & $troopNumber, $COLOR_PINK)

   ; $direction = 1 : Up
   ; $direction = 2 : Down
   For $direction = 1 To 4

	  While $RunState

		 ; Open NearBy Screen
		 If Not OpenMenu("NearBy", $POS_BUTTON_NEARBY, $CHECK_BUTTON_NEARBY_CLOSE) Then
			Return False
		 EndIf

		 ; Click Enemy Tab (Try only one time)
		 If $tryCount == 0 Then
			ClickControlPos($POS_BUTTON_NEARBY_ENEMY_TAB, 2)
			If _Sleep(800) Then Return False
		 EndIf

		 ; Click Move Button
		 If ClickMoveButton($actualTroopMoveNumber) Then
			Return True;
		 Else
			$tryCount = $tryCount + 1

			; Not found "move" button
			SetLog("Move button " & $actualTroopMoveNumber & " not found", $COLOR_RED)

			; this means that there is no more enemy in this near field.
			; go to anywhere to dragging
			CloseMenu("NearBy", $CHECK_BUTTON_NEARBY_CLOSE)
			If _Sleep(800) Then Return False

			If $tryCount > $MaxMoveCount Then
			   ExitLoop
			EndIf

			SetLog("Go some near place...", $COLOR_PINK)

			If $direction == 1 Then	; Up
			   If Mod($tryCount, 2) == 0 Then
				  DragControlPos("20:20", "90:90", $DragSpeed);
			   Else
				  DragControlPos("80:20", "10:80", $DragSpeed);
			   EndIf
			ElseIf $direction == 2 Then	; Down
			   If Mod($tryCount, 2) == 0 Then
				  DragControlPos("80:80", "10:10", $DragSpeed);
			   Else
				  DragControlPos("20:80", "80:10", $DragSpeed);
			   EndIf
			ElseIf $direction == 3 Then	; Right
			   If Mod($tryCount, 2) == 0 Then
				  DragControlPos("80:30", "10:50", $DragSpeed);
			   Else
				  DragControlPos("80:50", "10:30", $DragSpeed);
			   EndIf
			ElseIf $direction == 4 Then	; Left
			   If Mod($tryCount, 2) == 0 Then
				  DragControlPos("20:20", "80:30", $DragSpeed);
			   Else
				  DragControlPos("20:50", "80:30", $DragSpeed);
			   EndIf
			EndIf
		 EndIf

		 If _Sleep(400) Then Return False
	  WEnd

	  SetLog("Enemy not found : direction = " & $direction, $COLOR_RED)

	  ; Go to origin position again..
	  ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
	  $tryCount = 0
   Next

   Return False
EndFunc


Func GoToResource($troopNumber)

   While $RunState
	  ; Open Favorite Screen
	  If Not OpenMenu("Favorite", $POS_BUTTON_FAVORITE, $CHECK_BUTTON_FAVORITE_CLOSE) Then
		 Return False
	  EndIf

	  ; Click Resource Tab
	  ClickControlPos($POS_BUTTON_FAVORITE_RESOURCE_TAB, 2)
	  If _Sleep(500) Then Return False

	  ; Click Favorite Resource
	  If ClickFavoriteResourceMoveButton($troopNumber) Then
		 If _Sleep(1000) Then Return False
		 ClickControlPos("50:50", 2)
		 If _Sleep(500) Then Return False
		 Return True
	  EndIf

	  ; Not found favorite button
	  ; We don't have anthing to do no more...
	  Return False
   WEnd
   Return False
EndFunc


Func GoToExploreCastle()

   While $RunState
	  ; Open Favorite Screen
	  If Not OpenMenu("Favorite", $POS_BUTTON_FAVORITE, $CHECK_BUTTON_FAVORITE_CLOSE) Then
		 Return False
	  EndIf

	  ; Click Friend Tab
	  ClickControlPos($POS_BUTTON_FAVORITE_FRIEND_TAB, 2)
	  If _Sleep(500) Then Return False

	  ; Click Favorite Resource
	  If ClickFavoriteResourceMoveButton(1) Then	; always selecting 1 item
		 If _Sleep(1000) Then Return False
		 ClickControlPos("50:50", 2)
		 If _Sleep(500) Then Return False
		 Return True
	  EndIf

	  ; Not found favorite button
	  ; We don't have anthing to do no more...
	  Return False
   WEnd
   Return False
EndFunc


Func FindTreasureDungeonLevelNumber($number)
   Local Const $Delay = 500
   $region = RegionToRect("21:10.92-90.08:87.67")
   $buttonSizeRect = RegionToRect("22.08:10.49-31.62:35.76")

   Local $firstItemGreen[1] = ["24.58:56.53 | 0x41705e, 0x569785"]
   Local $firstItemBlue[1] = ["24.58:56.53 | 0x485770, 0x323e56"]
   Local $firstItemPurple[1] = ["24.58:56.53 | 0x7a6197, 0x54436d, 0x694d80"]
   Local $firstItemGold[1] = ["24.58:56.53 | 0x895c3c, 0x583d2c"]
   Local $secondItemGreen[1] = ["36.69:55.64 | 0x41705e, 0x569785 | 21 | 3"]
   Local $secondItemBlue[1] = ["36.69:55.64 | 0x485770, 0x323e56| 21 | 3"]
   Local $secondItemPurple[1] = ["36.69:55.64 | 0x7a6197, 0x54436d| 21 | 3"]
   Local $secondItemGold[1] = ["36.69:55.64 | 0x895c3c, 0x583d2c| 21 | 3"]
   Local $fifthItem[1] = ["72.7:56.58 | 0x414F67 | 16 | 3"]

   $clickCount = 0
   For $sx = $region[0] To $region[0] + $region[2] - $buttonSizeRect[2] / 2 Step $buttonSizeRect[2]
	  For $sy = $region[1] To $region[1] + $region[3] - $buttonSizeRect[3] / 2 Step $buttonSizeRect[3]

		 Local $centerPos = [($sx + $buttonSizeRect[2] / 2), ($sy + $buttonSizeRect[3] / 2)]
 		 $clickCount += 1

		 Click($centerPos[0], $centerPos[1], 1)
		 Click($centerPos[0] - 10, $centerPos[1], 1)
		 Click($centerPos[0] + 10, $centerPos[1], 1)

		 If _Sleep($Delay) Then Return False
		 If CheckForPixelList($CHECK_BUTTON_DUNGEON_TREASURE_START) Then
			_log("FindTreasureDungeonLevelNumber found : " & $centerPos[0] & "x" & $centerPos[1])

			$currLevel = 0
			If CheckForPixelList($firstItemGreen) And Not CheckForPixelList($fifthItem) Then
			   $currLevel = 1
			ElseIf CheckForPixelList($firstItemGreen) And CheckForPixelList($secondItemBlue) Then
			   $currLevel = 2
			ElseIf CheckForPixelList($firstItemBlue) And CheckForPixelList($secondItemGreen) Then
			   $currLevel = 3
			ElseIf CheckForPixelList($firstItemPurple) And CheckForPixelList($secondItemBlue) Then
			   $currLevel = 4
			ElseIf CheckForPixelList($firstItemGold) And CheckForPixelList($secondItemPurple) Then
			   $currLevel = 5
			EndIf

			If $currLevel >= 1 Then
			   SetLog("Level " & $currLevel & " detected...", $COLOR_PINK)
			Else
			   SetLog("Level detect failed...", $COLOR_RED)
			EndIf

			If $number == $currLevel Then
			   ; find it! do not close this menu
			   Return $centerPos
			EndIf

			CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)
			If _Sleep($Delay) Then Return False
		 EndIf
	  Next
   Next

   _log("FindTreasureDungeonLevelNumber total click count : " & $clickCount)
   Return False
EndFunc

Func DoKillFieldMonster($troopNumber)
   SetLog("Go Field Monster Attack : Troop " & $troopNumber, $COLOR_PURPLE)
   Local $tryCount = 1

   GoToFieldNearByMyCastle()

   If Not GoToNearByEmemy($troopNumber) Then
	  SetLog("Can not find any enemies...", $COLOR_RED)
	  Return False
   EndIf

   If _Sleep(1100) Then Return False

   ; Click Attack Button & Open Select-Troup Menu
   $tryCount = 1
   $foundAttackButton = False
   While $RunState And $tryCount < $MaxTryCount
	  If CheckForPixelList($CHECK_BUTTON_FIELD_ACTION) Then
		 ClickControlPos($POS_BUTTON_FIELD_ACTION, 1)
		 $foundAttackButton = True
	  EndIf

	  If _Sleep(800) Then Return False

	  If CheckForPixelList($CHECK_BUTTON_SELECT_TROOPS_CLOSE) Then
		 SetLog("Open Select Troop Menu", $COLOR_DARKGREY)
		 ExitLoop
	  EndIf

	  If CheckForPixelList($CHECK_BUTTON_USE_ACTION_POINT_CLOSE) Then
		 If $setting_checked_use_march_order Then
			SetLog("Use March Order", $COLOR_RED)
			ClickControlPos($POS_BUTTON_USE_ACTION_POINT, 1)
			If _Sleep(1200) Then Return False
			$tryCount = 0
		 Else
			CloseMenu("Use-MarchOrder", $CHECK_BUTTON_USE_ACTION_POINT_CLOSE)
			If _Sleep(300) Then Return False
			SetLog("Need March Order (Option Off)", $COLOR_RED)
			Return False
		 EndIf
	  EndIf

	  If $foundAttackButton == False Then
		 ClickControlPos("50:50", 1)
	  EndIf

	  $tryCount = $tryCount + 1
	  If _Sleep(600) Then Return False
   WEnd
   If $tryCount == $MaxTryCount Then
	  SetLog("Error..", $COLOR_RED)
	  Return False
   EndIf

   ; Select troop number
   SelectTroop($troopNumber)
   If _Sleep(400) Then Return False

   ; Start Attack!!
   ClickControlPos($POS_BUTTON_START_ACTION, 2)
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


Func DoResourceGathering($troopNumber)
   SetLog("Go Resource Gathering : Troop " & $troopNumber, $COLOR_OLIVE)
   Local $tryCount = 1

   GoToField()

   If Not GoToResource($troopNumber) Then
	  SetLog("Can not find any favorites...", $COLOR_RED)
	  Return False
   EndIf

   If _Sleep(1100) Then Return False

   ; Click Gathering Button & Open Select-Troup Menu
   $tryCount = 1
   $foundGatherButton = False
   While $RunState And $tryCount < $MaxTryCount
	  If CheckForPixelList($CHECK_BUTTON_FIELD_ACTION) Then
		 ClickControlPos($POS_BUTTON_FIELD_ACTION, 1)
		 $foundGatherButton = True
	  EndIf

	  If _Sleep(800) Then Return False

	  If CheckForPixelList($CHECK_BUTTON_SELECT_TROOPS_CLOSE) Then
		 SetLog("Open Select Troop Menu", $COLOR_PINK)
		 ExitLoop
	  EndIf

	  If CheckForPixelList($CHECK_BUTTON_USE_ACTION_POINT_CLOSE) Then
		 If $setting_checked_use_march_order Then
			SetLog("Use March Order", $COLOR_RED)
			ClickControlPos($POS_BUTTON_USE_ACTION_POINT, 1)
			If _Sleep(1200) Then Return False
			$tryCount = 0
		 Else
			CloseMenu("Use-MarchOrder", $CHECK_BUTTON_USE_ACTION_POINT_CLOSE)
			If _Sleep(300) Then Return False
			SetLog("Need March Order (Option Off)", $COLOR_RED)
			Return False
		 EndIf
	  EndIf

	  If $foundGatherButton == False Then
		 ClickControlPos("50:50", 1)
	  EndIf

	  $tryCount = $tryCount + 1
  	  If _Sleep(600) Then Return False
   WEnd
   If $tryCount == $MaxTryCount Then
	  SetLog("Error..", $COLOR_RED)
	  Return False
   EndIf

   ; Select troop number
   SelectTroop($troopNumber)
   If _Sleep(400) Then Return False

   ; Start Gathering!!
   ClickControlPos($POS_BUTTON_START_ACTION, 2)
   If _Sleep(1000) Then Return False

   If CheckForPixelList($CHECK_BUTTON_ALERT_CLOSE) Then
	  SetLog("Alert! Can not gather...", $COLOR_RED)

	  CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
	  If _Sleep(400) Then Return False
	  CloseMenu("Select-Troops", $CHECK_BUTTON_SELECT_TROOPS_CLOSE)
	  Return False
   EndIf
   SetLog("Go Gathering!", $COLOR_PINK)
   Return True
EndFunc


Func DoExploreCastle($troopNumber)
   SetLog("Go Explore Castle : Troop " & $troopNumber, $COLOR_OLIVE)
   Local $tryCount = 1

   GoToField()

   If Not GoToExploreCastle() Then
	  SetLog("Can not find any castles", $COLOR_RED)
	  Return False
   EndIf
   If _Sleep(1100) Then Return False

   ; Click Enter Button & Open Castle Menu
   $tryCount = 1
   $foundEnterButton = False
   While $RunState And $tryCount < $MaxTryCount
	  If CheckForPixelList($CHECK_BUTTON_FIELD_ACTION) Then
		 ClickControlPos($POS_BUTTON_FIELD_ENTER_CASTLE, 1)
		 $foundEnterButton = True
	  EndIf

	  If _Sleep(800) Then Return False

	  If CheckForPixelList($CHECK_BUTTON_CASTLE_MENU_CLOSE) Then
		 SetLog("Open Castle Menu", $COLOR_PINK)
		 ExitLoop
	  EndIf

	  If $foundEnterButton == False Then
		 ClickControlPos("50:50", 1)
	  EndIf

	  $tryCount = $tryCount + 1
	  If _Sleep(600) Then Return False
   WEnd
   If $tryCount == $MaxTryCount Then
	  SetLog("Error..", $COLOR_RED)
	  Return False
   EndIf

   ; wait for possible marchorder point error..
   If _Sleep(1500) Then Return False

   ; Click Explore Button & Open Select-Troup Menu
   Local Const $TryMaxCheckCount = 4
   $tryCount = 0
   While $RunState And $tryCount < $TryMaxCheckCount
	  If CheckForPixelList($CHECK_BUTTON_SELECT_TROOPS_CLOSE) Then
		 SetLog("Open Select Troop Menu", $COLOR_PINK)
		 ExitLoop
	  EndIf

	  If CheckForPixelList($CHECK_BUTTON_USE_ACTION_POINT_CLOSE) Then
		 SetLog("Open Select Troop Menuss OKOKOKOK", $COLOR_PINK)
		 If $setting_checked_use_march_order Then
			SetLog("Use March Order", $COLOR_RED)
			ClickControlPos($POS_BUTTON_USE_ACTION_POINT, 1)
			If _Sleep(1200) Then Return False
			$tryCount = 0
		 Else
			CloseMenu("Use-MarchOrder", $CHECK_BUTTON_USE_ACTION_POINT_CLOSE)
			If _Sleep(300) Then Return False
			SetLog("Need March Order (Option Off)", $COLOR_RED)
			Return False
		 EndIf
	  EndIf

	  ClickControlPos($POS_BUTTON_CASTLE_EXPLORE, 1)
	  $tryCount = $tryCount + 1
	  If _Sleep(1000) Then Return False
   WEnd
   If $tryCount == $TryMaxCheckCount Then
	  SetLog("Can not explore castle no more...", $COLOR_RED)
	  Return False
   EndIf

   ; Select troop number
   SelectTroop($troopNumber)
   If _Sleep(400) Then Return False

   ; Start Explore!!
   ClickControlPos($POS_BUTTON_START_ACTION, 2)
   If _Sleep(1000) Then Return False

   If CheckForPixelList($CHECK_BUTTON_ALERT_CLOSE) Then
	  SetLog("Alert! Can not explore...", $COLOR_RED)

	  CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
	  If _Sleep(400) Then Return False
	  CloseMenu("Select-Troops", $CHECK_BUTTON_SELECT_TROOPS_CLOSE)
	  Return False
   EndIf
   SetLog("Go Explore!", $COLOR_PINK)
   Return True
EndFunc


Func DoDungeonSweep($tab, $level, $buttonPosList)
   $result = True
   $tryCount = 1
   SetLog("Dungeon Attack Begin : " & $level, $COLOR_DARKGREY)

   For $i = 0 To 4

	  reloadConfig()

	  SetLog("Dungeon Attack Stage : " & $i + 1, $COLOR_ORANGE)
	  $foundSweepButton = False
	  $foundInitButton = False

	  CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
	  CloseMenu("Dungeon-Sweep-Count", $CHECK_BUTTON_DUNGEON_SWEEP_COUNT_CLOSE, $CHECK_BUTTON_DUNGEON_ATTACK_START)
	  CloseMenu("Use-Cash", $CHECK_BUTTON_USE_ACTION_POINT_CLOSE)
	  CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)

	  Local $enable = True
	  Local $posInfo = $buttonPosList[$i]
	  Local $infoArr = StringSplit($buttonPosList[$i], "|")
	  If $infoArr[0] == 2 Then
		 $posInfo = $infoArr[1]
		 $enable = $infoArr[2] == "0" ? False : True
	  EndIf

	  If $enable == False Then
		 SetLog("Dungeon Attack Skipped : " & $i + 1, $COLOR_PINK)
		 ContinueLoop
	  EndIf

	  ClickControlPos($posInfo, 1)
	  If _Sleep(800) Then Return False

	  $tryCount = 1
	  While $RunState And $tryCount < $MaxTryCount

		 If CheckForPixelList($CHECK_BUTTON_DUNGEON_ATTACK_SWEEP) Then
			$foundSweepButton = True
			SetLog("Sweep Button Found", $COLOR_DARKGREY)
			ExitLoop
		 ElseIf CheckForPixelList($CHECK_BUTTON_DUNGEON_ATTACK_INIT) Then
			$foundInitButton = True
			SetLog("Init Button Found", $COLOR_DARKGREY)
			ExitLoop
		 Else
			ClickControlPos($posInfo, 1)
		 EndIf
		 If _Sleep(500) Then Return False
		 $tryCount = $tryCount + 1
	  WEnd
	  If $tryCount == $MaxTryCount Then
		 SetLog("Can not find sweep button...", $COLOR_RED)
		 Return False
	  EndIf

	  If $foundSweepButton Then
		 OpenMenu("Troop-Select", ScreenToPosInfo($CHECK_BUTTON_DUNGEON_ATTACK_SWEEP[0]), $CHECK_BUTTON_SELECT_TROOPS_CLOSE)
	  ElseIf $foundInitButton Then

		 If $setting_checked_use_cash Then
			ClickControlScreen($CHECK_BUTTON_DUNGEON_ATTACK_INIT[0], 2)
			If CheckForPixelList($CHECK_BUTTON_DUNGEON_USE_CASH_DENY) Then
			   SetLog("Can not use cash no more", $COLOR_RED)
			   ClickControlScreen($CHECK_BUTTON_DUNGEON_USE_CASH_DENY[0])

			   If _Sleep(800) Then Return False
			   CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)
			   ContinueLoop
			Else
			   OpenMenu("Use-Cash", ScreenToPosInfo($CHECK_BUTTON_DUNGEON_ATTACK_INIT[0]), $CHECK_BUTTON_DUNGEON_USE_CASH)
			   If _Sleep(500) Then Return False
			   ClickControlScreen($CHECK_BUTTON_DUNGEON_USE_CASH[0], 2)
			   If _Sleep(1200) Then Return False

			   If CheckForPixelList($CHECK_BUTTON_ALERT_CLOSE) Then
				  SetLog("Out of Cash!", $COLOR_RED)
				  CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
				  If _Sleep(500) Then Return False
				  ContinueLoop
			   Else
				  SetLog("Use Cach!", $COLOR_BLUE)
			   EndIf

			   OpenMenu("Troop-Select", ScreenToPosInfo($CHECK_BUTTON_DUNGEON_ATTACK_SWEEP[0]), $CHECK_BUTTON_SELECT_TROOPS_CLOSE)
			EndIf
		 Else
			; Close Attack Menu
			SetLog("Need Cash (Option Off)", $COLOR_RED)
			CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)
			If _Sleep(800) Then Return False
			ContinueLoop
		 EndIf
	  EndIf

	  ; Select troop
	  SelectTroop($setting_dungeon_sweep_troop)
	  If _Sleep(400) Then Return False

	  ; Start Attack!!
	  ClickControlPos($POS_BUTTON_START_ACTION, 2)

	  ; Open Sweep Start Popup (including Sweep count selection => $CHECK_BUTTON_DUNGEON_SWEEP_COUNT_CLOSE)
	  OpenMenu("Sweep-Start", $POS_BUTTON_START_ACTION, $CHECK_BUTTON_DUNGEON_ATTACK_START)

	  ; Click end position in slider
	  ClickControlPos("55.44:57.86", 2)
	  ClickControlPos($POS_BUTTON_DUNGEON_SWEEP_PLUS, 3, 100)	; and click more to fill fully
	  If _Sleep(200) Then Return False

	  SetLog("Dungeon Sweep Attack!", $COLOR_PINK)
	  ClickControlScreen($CHECK_BUTTON_DUNGEON_ATTACK_START[0], 2)
	  If _Sleep(1500) Then Return False

	  ; alert OR still sweep start window with full slider state..
	  If CheckForPixelList($CHECK_BUTTON_ALERT_CLOSE) OR CheckForPixelList("48.73:58.17 | 0x359EBA") Then
		 SetLog("No Bread!", $COLOR_RED)

		 CloseMenu("Alert", $CHECK_BUTTON_ALERT_CLOSE)
		 If _Sleep(500) Then Return False
		 CloseMenu("Dungeon-Sweep-Count", $CHECK_BUTTON_DUNGEON_SWEEP_COUNT_CLOSE, $CHECK_BUTTON_DUNGEON_ATTACK_START)
		 If _Sleep(500) Then Return False
		 CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)
		 If _Sleep(500) Then Return False
		 Return False
	  EndIf

	  If CheckForPixelList($CHECK_BUTTON_USE_ACTION_POINT_CLOSE) Then
		 If $setting_checked_use_bread Then
			; attack-button and use-bread button's position are almost same..
			ClickControlScreen($CHECK_BUTTON_DUNGEON_ATTACK_START[0], 2)
			If _Sleep(1000) Then Return False

			;ClickControlPos($POS_BUTTON_DUNGEON_SWEEP_PLUS, 13, 100)	; 10 clicked
			;If _Sleep(800) Then Return False
			SetLog("Use Bread!", $COLOR_BLUE)
			ClickControlScreen($CHECK_BUTTON_DUNGEON_ATTACK_START[0], 2)
		 Else
			SetLog("Need Bread (Option Off)", $COLOR_RED)
			CloseMenu("Use-Bread", $CHECK_BUTTON_USE_ACTION_POINT_CLOSE)
			$result = False
		 EndIf
		 If _Sleep(1200) Then Return False
	  EndIf

	  ; Close Attack Menu
	  CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)

	  If _Sleep(800) Then Return False
	  If Not $result Then ExitLoop
   Next

   ; Close Attack Menu one more
   CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)

   SetLog("Dungeon Attack End : " & $level, $COLOR_PINK)
   Return $result
EndFunc


Func MainAutoFieldAction()
   SetLog("Auto Field Action Start", $COLOR_GREEN)
   Local $attackCount = 0
   Local $gatheringCount = 0
   Local $exploreCount = 0
   Local $loopCount = 0

   While $RunState
	  SetLog("Loop Count : " & $loopCount + 1, $COLOR_ORANGE)

	  If $loopCount > 0 Then
		 If Mod($loopCount, $LoopCount_Reboot) == 0 Then

			If Not RebootNox() Then
			   Return False
			EndIf
		 EndIf

		 If Mod($loopCount, $LoopCount_CollectResource) == 0 Then
			CollectResources()
		 EndIf

		 If Mod($loopCount, $LoopCount_RecruitTroop) == 0 Then
			DoRecruitBarrack()
		 EndIf

		 If Mod($loopCount, $LoopCount_ForcePullOut) == 0 Then
			PullOutAllResourceTroops()
		 EndIf
	  EndIf

	  CloseAllMenu()

	  ; do jobs only one first time
	  If $loopCount == 0 Then
		 DoRecruitBarrack()
	  EndIf

	  ; Checking Barrack's Red Mark -> We need to call DoRecruitBarrack()
	  If CheckForPixelList($CHECK_BUTTON_BARRACK_RED_MARK) Then
		 SetLog("Barrack Red Mark Detected...", $COLOR_RED)
		 ClickControlScreen($CHECK_BUTTON_BARRACK_RED_MARK[0])
		 If _Sleep(800) Then Return False
		 DoRecruitBarrack()
	  EndIf

	  ; Checking available
	  $troopList = CheckTroopAvailableList()

	  If IsArray($troopList) Then
		 For $troopIndex = 0 To 3
			If $troopList[$troopIndex] Then
			   ; Go!!
			   If _Sleep(800) Then Return False

			   reloadConfig()

			   If $setting_checked_field_attack And $setting_attack_troup_enabled[$troopIndex] Then

				  If DoKillFieldMonster($troopIndex+1) Then
					 $attackCount = $attackCount + 1
					 SetLog("Attack Count : " & $attackCount, $COLOR_BLUE)
				  EndIf

			   ElseIf $setting_checked_resource_gathering And $setting_gather_troup_enabled[$troopIndex] Then

				  If DoResourceGathering($troopIndex+1) Then
					 $gatheringCount = $gatheringCount + 1
					 SetLog("Gathering Count : " & $gatheringCount, $COLOR_BLUE)
				  EndIf

			   ElseIf $setting_checked_explore_castle And $setting_explore_troup_enabled[$troopIndex] Then

				  If DoExploreCastle($troopIndex+1) Then
					 $exploreCount = $exploreCount + 1
					 SetLog("Explore Count : " & $exploreCount, $COLOR_BLUE)
				  EndIf

			   Else
				  ;SetLog("Nothing to do. check your setting", $COLOR_RED)
			   EndIf
			EndIf
		 Next
	  EndIf

	  ; Idle 5 sec..
	  SetLog("Idle " & $FieldActionIdleMSec & " Msec", $COLOR_BLACK)
	  If _SleepAbs($FieldActionIdleMSec) Then Return False

	  reloadConfig()

	  $loopCount = $loopCount + 1
	  If _Sleep(1000) Then Return False
   WEnd

   SetLog("Auto Field Action End", $COLOR_GREEN)
   Return True

EndFunc


Func MainDungeonSweep($tab)
   SetLog("Auto Dungeon Sweep Start : " & $tab, $COLOR_GREEN)

   CloseAllMenu()

   ClickControlPos($POS_BUTTON_DUNGEON, 2)
   If _Sleep(800) Then Return False

   Local $toStageNumber = 13
   If $tab == "exp" Then
	  ClickControlPos($POS_BUTTON_DUNGEON_EXP_TAB, 2)
   ElseIf $tab == "hero" Then
	  ClickControlPos($POS_BUTTON_DUNGEON_HERO_TAB, 2)
	  $toStageNumber = 7
   EndIf
   If _Sleep(800) Then Return False

   Local $dungeonButtonArray[9];
   $dungeonButtonArray[0] = $POS_BUTTON_DUNGEON_15
   $dungeonButtonArray[1] = $POS_BUTTON_DUNGEON_14
   $dungeonButtonArray[2] = $POS_BUTTON_DUNGEON_13
   $dungeonButtonArray[3] = $POS_BUTTON_DUNGEON_12
   $dungeonButtonArray[4] = $POS_BUTTON_DUNGEON_11
   $dungeonButtonArray[5] = $POS_BUTTON_DUNGEON_10
   $dungeonButtonArray[6] = $POS_BUTTON_DUNGEON_09
   $dungeonButtonArray[7] = $POS_BUTTON_DUNGEON_08
   $dungeonButtonArray[8] = $POS_BUTTON_DUNGEON_07

   For $index = 0 To UBound($dungeonButtonArray) - 1

	  $stageNumber = 15 - $index
	  If DoDungeonSweep($tab, $stageNumber, $dungeonButtonArray[$index]) Then
		 If _Sleep(1500) Then Return False
		 ClickControlPos($POS_BUTTON_DUNGEON_MOVE_LEFT, 2)
		 If _Sleep(1200) Then Return False
	  Else
		 ExitLoop
	  EndIf

	  If $stageNumber == $toStageNumber Then
		 ExitLoop
	  EndIf
   Next

   CloseMenu("Dungeon-Menu", $CHECK_BUTTON_TOP_CLOSE)

   SetLog("Auto Dungeon Sweep End : " & $tab, $COLOR_GREEN)
EndFunc


Func MainDungeonTreasure()
   SetLog("Auto Dungeon Treasure Start", $COLOR_GREEN)

   CloseAllMenu()

   ClickControlPos($POS_BUTTON_DUNGEON, 2)
   If _Sleep(800) Then Return False

   ClickControlPos($POS_BUTTON_DUNGEON_TREASURE_TAB, 2)
   If _Sleep(800) Then Return False

   Local $levelButtonPos = FindTreasureDungeonLevelNumber($setting_dungeon_treasure_level_number)
   If IsArray($levelButtonPos) = False Then
	  Return False
   EndIf

   $tryCount = 0
   $loseCount = 0
   Local Const $MaxAttackClickTryCount = 3
   Local $HeroButtonPosList[6] = ["54:94.2", "61:94", "69:94", "77:94", "85:94", "93:94"]
   Local $SkillButtonPosList[2] = ["5:72", "5:92"]

   While $RunState And $tryCount < $MaxTryCount
	  reloadConfig()

	  If CheckForPixelList($CHECK_BUTTON_DUNGEON_TREASURE_START) Then

		 $attackClickCount = 0
		 While $attackClickCount < $MaxAttackClickTryCount
			ClickControlScreen($CHECK_BUTTON_DUNGEON_TREASURE_START[0], 2)

			If Not CheckForPixelList($CHECK_BUTTON_DUNGEON_TREASURE_START) Then
			   ; OK
			   ExitLoop
			EndIf
			If _Sleep(800) Then Return False
			$attackClickCount += 1
		 WEnd

		 If $attackClickCount >= $MaxAttackClickTryCount Then
			SetLog("Can not try treasure attack...", $COLOR_RED)
			CloseMenu("Dungeon-Attack", $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE)
			If _Sleep(800) Then Return False
			ExitLoop
		 EndIf
	  Else
		 $tryCount += 1
		 SetLog("Click Treasure Level Button : " & $setting_dungeon_treasure_level_number, $COLOR_DARKGREY)
		 Click($levelButtonPos[0], $levelButtonPos[1], 1)
		 Click($levelButtonPos[0] - 10, $levelButtonPos[1], 1)
		 Click($levelButtonPos[0] + 10, $levelButtonPos[1], 1)
		 If _Sleep(1000) Then Return False
		 ContinueLoop
	  EndIf

	  ; Select troop
	  SelectTroop(1)
	  If _Sleep(400) Then Return False

	  SetLog("Treasure Attack!", $COLOR_PINK)
	  ClickControlPos($POS_BUTTON_START_ACTION, 2)
	  If _SleepAbs(1000) Then Return False
	  ClickControlPos($POS_BUTTON_START_ACTION, 2)
	  If _SleepAbs(6000) Then Return False

	  $tickCount = 0
	  $win = True
	  While $RunState
		 reloadConfig()

		 If CheckForPixelList($CHECK_BUTTON_DUNGEON_WIN_LEAVE) Then
			SetLog("Treasure Attack Win!", $COLOR_BLUE)
			ClickControlScreen($CHECK_BUTTON_DUNGEON_WIN_LEAVE[0], 2)
			If _Sleep(3000) Then Return False
			$loseCount = 0
			ExitLoop
		 EndIf

		 If CheckForPixelList($CHECK_BUTTON_DUNGEON_LOSE_LEAVE) Then
			$win = False
			SetLog("Treasure Attack Lose!", $COLOR_RED)
			ClickControlScreen($CHECK_BUTTON_DUNGEON_LOSE_LEAVE[0], 2)
			If _Sleep(3000) Then Return False
			$loseCount += 1
			ExitLoop
		 EndIf

		 ; Cast Hero's Skills Forward
		 For $i = 0 To 5
			ClickControlPos($HeroButtonPosList[$i], 3, 0, 50)
		 Next

		 ; Cast My Two Skills
		 If $tickCount >= $setting_dungeon_treasure_main_skill_tick_count Then
			For $i = 0 To 1
			   ClickControlPos($SkillButtonPosList[$i], 2, 0, 100)
			Next
		 EndIf

		  ; Cast Hero's Skills Backward
		 For $i = 5 To 0 Step -1
			ClickControlPos($HeroButtonPosList[$i], 3, 0, 50)
		 Next

		 ; Click Skip Button
		 ClickControlPos("89.52:91.9", 1, 0, 100)

		 $tickCount += 1
		 SetLog("Attack Tick Count : " & $tickCount & "(" & $setting_dungeon_treasure_main_skill_tick_count & ")", $COLOR_DARKGREY)
	  WEnd

	  If Not $win And $loseCount >= 3 Then
		 ExitLoop
	  EndIf
   WEnd

   CloseMenu("Dungeon-Menu", $CHECK_BUTTON_TOP_CLOSE)
   SetLog("Auto Dungeon Treasure End", $COLOR_GREEN)
EndFunc


Func MainTodayJob()
   SetLog("Auto Today Job Start", $COLOR_GREEN)

   ; Go to castle initial view
   ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
   If _Sleep($ViewChangeWaitMSec) Then Return False

   Local $tryCount = 1
   While $RunState And $tryCount < $MaxTryCount
	  If CheckForPixelList($CHECK_MAIN_CASTLE_VIEW) Then
		 ExitLoop
	  Else
		 CloseAllMenu()
		 If _Sleep(500) Then Return False
		 ClickControlPos($POS_BUTTON_GOTO_MAP, 2)
		 If _Sleep($ViewChangeWaitMSec) Then Return False
	  EndIf
   WEnd
   If $tryCount == $MaxTryCount Then Return False

   ClickControlPos($POS_BUTTON_PUB, 2)
   If _Sleep(2000) Then Return False
   HireFreeHeroInternal()
   If _Sleep(800) Then Return False

   GetMySalaryInternal()
   If _Sleep(800) Then Return False

   ClickControlPos("34.26:64.55", 2)	; altar button from pub view
   AltarResourceInternal()
   If _Sleep(800) Then Return False

   SetLog("Auto Today Job End", $COLOR_GREEN)
EndFunc

