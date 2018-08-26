
Func AutoFlow()
   ;DragControlPos("30:70", "80:20", 5);
   ;CollectResources()
   ;ClickMoveButton(4)
   ;DragControlPos("20:80", "80:10", 5);
   ;CloseAllMenu()
   ;FindTreasureDungeonLevelNumber(3)
   ;DoResourceGathering(1)
   ;If CheckForPixelList($CHECK_BUTTON_USE_ACTION_POINT_CLOSE) Then SetLog("OK", $COLOR_DARKGREY)
   ;DoDungeonSweep("hero", 13, $POS_BUTTON_DUNGEON_13)
   ;RebootNox()
   ;CloseMenu("Main", $CHECK_BUTTON_HELP_CLOSE)
   ;HireFreeHero()
   ;GetMySalary()
   ;AltarResource()
   ;MainDungeonSweep("hero")
   ;pullOutAllResourceTroops()
   ;DoExploreCastle(2)
   ;GetMySalaryInternal()
   ;Return False

   If $setting_checked_dungeon_treasure Then
	  MainDungeonTreasure()
	  If _Sleep(1200) Then Return False
   EndIf

   If $setting_checked_dungeon_hero Then
	  MainDungeonSweep("hero")
	  If _Sleep(1200) Then Return False
   EndIf

   If $setting_checked_dungeon_exp Then
	  MainDungeonSweep("exp")
	  If _Sleep(1200) Then Return False
   EndIf

   If $setting_checked_field_attack OR $setting_checked_resource_gathering Then
	  MainAutoFieldAction()
	  If _Sleep(1200) Then Return False
   EndIf

   Return True
EndFunc


