
Func AutoFlow()
   ;DragControlPos("70:30", "40:70");
   ;DragControlPos("30:70", "80:20", 5);
   ;DragControlPos("70:70", "70:30");
   ;DragControlPos("40:40", "70:70");
   ;DragControlPos("70:70", "40:40");
   ;CollectResources()
   ;ClickMoveButton(4)
   ;DragControlPos("20:80", "80:10", 5);
   ;CloseMenu("Hero-Collection", $CHECK_BUTTON_HERO_COLLECTION_CLOSE)
   ;CloseAllMenu()
   ;FindTreasureDungeonLevelNumber(3)
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

   If $setting_checked_field_attack Then
	  MainFieldAttack()
	  If _Sleep(1200) Then Return False
   EndIf
   Return True
EndFunc


