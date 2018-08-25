
Func AutoFlow()
   ;DragControlPos("30:70", "80:20", 5);
   ;CollectResources()
   ;ClickMoveButton(4)
   ;DragControlPos("20:80", "80:10", 5);
   ;CloseMenu("Hero-Collection", $CHECK_BUTTON_HERO_COLLECTION_CLOSE)
   ;CloseAllMenu()
   ;FindTreasureDungeonLevelNumber(3)
   ;DoResourceGathering(1)
   ;If CheckForPixelList($CHECK_BUTTON_DUNGEON_ATTACK_START) Then SetLog("OK", $COLOR_DARKGREY)
   ;DoDungeonSweep("hero", 14, $POS_BUTTON_DUNGEON_14)
   ;RebootNox()
   ;CloseMenu("Main", $CHECK_BUTTON_HELP_CLOSE)
   ;HireFreeHero()
   ;GetMySalary()
   ;AltarResource()
   ;MainDungeonSweep("hero")
   ;pullOutAllResourceTroops()
   ;DoExploreCastle(2)
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


