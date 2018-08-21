
; -----------------------------
; Settings Variable
; -----------------------------

Local $setting_common_group = "Default"

Global $setting_win_title = "녹스 안드로이드 앱플레이어"
Global $setting_thick_frame_size = "36:2"
Global $setting_game_icon_pos = ""
Global $setting_attack_troup_enabled[4] = [False, False, False, False]
Global $setting_gather_troup_enabled[4] = [False, False, False, False]
Global $setting_delay_rate = 1.0
Global $setting_capture_mode = False
Global $setting_checked_dungeon_hero = False
Global $setting_checked_dungeon_exp = False
Global $setting_checked_dungeon_treasure = False
Global $setting_checked_field_attack = False
Global $setting_checked_resource_gathering = False
Global $setting_checked_use_cash = False
Global $setting_checked_use_bread = False
Global $setting_checked_use_march_order = False
Global $setting_dungeon_treasure_level_number = 3
Global $setting_dungeon_sweep_troop = 2

Func loadConfig()

   $setting_win_title = IniRead($config, $setting_common_group, "win_title", $setting_win_title)
   $setting_thick_frame_size = IniRead($config, $setting_common_group, "thick_frame_size", $setting_thick_frame_size)
   $setting_game_icon_pos = IniRead($config, $setting_common_group, "game_icon_pos", $setting_game_icon_pos)
   $setting_capture_mode = IniRead($config, $setting_common_group, "enabled_capture_mode", "False") == "True" ? True : False
   $setting_attack_troup_enabled[0] = IniRead($config, $setting_common_group, "enabled_attack_troup_1", "False") == "True" ? True : False
   $setting_attack_troup_enabled[1] = IniRead($config, $setting_common_group, "enabled_attack_troup_2", "False") == "True" ? True : False
   $setting_attack_troup_enabled[2] = IniRead($config, $setting_common_group, "enabled_attack_troup_3", "False") == "True" ? True : False
   $setting_attack_troup_enabled[3] = IniRead($config, $setting_common_group, "enabled_attack_troup_4", "False") == "True" ? True : False

   $setting_gather_troup_enabled[0] = IniRead($config, $setting_common_group, "enabled_gather_troup_1", "False") == "True" ? True : False
   $setting_gather_troup_enabled[1] = IniRead($config, $setting_common_group, "enabled_gather_troup_2", "False") == "True" ? True : False
   $setting_gather_troup_enabled[2] = IniRead($config, $setting_common_group, "enabled_gather_troup_3", "False") == "True" ? True : False
   $setting_gather_troup_enabled[3] = IniRead($config, $setting_common_group, "enabled_gather_troup_4", "False") == "True" ? True : False

   $setting_dungeon_sweep_troop = Int(IniRead($config, $setting_common_group, "dungeon_sweep_troop", "3"))
   $setting_dungeon_treasure_level_number = Int(IniRead($config, $setting_common_group, "dungeon_treasure_level", "3"))
   $setting_checked_dungeon_hero = IniRead($config, $setting_common_group, "enabled_dungeon_hero", "False") == "True" ? True : False
   $setting_checked_dungeon_exp = IniRead($config, $setting_common_group, "enabled_dungeon_exp", "False") == "True" ? True : False
   $setting_checked_dungeon_treasure = IniRead($config, $setting_common_group, "enabled_dungeon_treasure", "False") == "True" ? True : False
   $setting_checked_field_attack = IniRead($config, $setting_common_group, "enabled_field_attack", "False") == "True" ? True : False
   $setting_checked_resource_gathering = IniRead($config, $setting_common_group, "enabled_resource_gathering", "False") == "True" ? True : False
   $setting_checked_use_cash = IniRead($config, $setting_common_group, "enabled_use_cash", "False") == "True" ? True : False
   $setting_checked_use_bread = IniRead($config, $setting_common_group, "enabled_use_bread", "False") == "True" ? True : False
   $setting_checked_use_march_order = IniRead($config, $setting_common_group, "enabled_use_march_order", "False") == "True" ? True : False
EndFunc	;==>loadConfig

Func applyConfig()

   GUICtrlSetData($inputNoxTitle, $setting_win_title)
   GUICtrlSetData($inputThickFraemSize, $setting_thick_frame_size)
   GUICtrlSetData($inputGameIconPos, $setting_game_icon_pos)
   _GUICtrlComboBox_SetCurSel($comboDungeonTreasureLevel, Int($setting_dungeon_treasure_level_number) - 1)
   _GUICtrlComboBox_SetCurSel($comboDungeonSweepTroop, Int($setting_dungeon_sweep_troop) - 1)

   Local $arr = StringSplit($setting_thick_frame_size, ":")
   $NoxTitleBarHeight = Number($arr[1])
   $ThickFrameSize = Number($arr[2])

   GUICtrlSetState($checkBotCaptureModeEnabled, $setting_capture_mode ? $GUI_CHECKED : $GUI_UNCHECKED)

   GUICtrlSetState($checkAutoFieldAttackTroop1, $setting_attack_troup_enabled[0] ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoFieldAttackTroop2, $setting_attack_troup_enabled[1] ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoFieldAttackTroop3, $setting_attack_troup_enabled[2] ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoFieldAttackTroop4, $setting_attack_troup_enabled[3] ? $GUI_CHECKED : $GUI_UNCHECKED)

   GUICtrlSetState($checkAutoResourceGatheringTroop1, $setting_gather_troup_enabled[0] ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoResourceGatheringTroop2, $setting_gather_troup_enabled[1] ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoResourceGatheringTroop3, $setting_gather_troup_enabled[2] ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoResourceGatheringTroop4, $setting_gather_troup_enabled[3] ? $GUI_CHECKED : $GUI_UNCHECKED)

   GUICtrlSetState($checkAutoDungeonHeroSweepEnabled, $setting_checked_dungeon_hero ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoDungeonExpSweepEnabled, $setting_checked_dungeon_exp ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoDungeonTreasureEnabled, $setting_checked_dungeon_treasure ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoFieldAttackEnabled, $setting_checked_field_attack ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoResourceGatheringEnabled, $setting_checked_resource_gathering ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkUseCashEnabled, $setting_checked_use_cash ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkUseBreadEnabled, $setting_checked_use_bread ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkUseMarchOrderEnabled, $setting_checked_use_march_order ? $GUI_CHECKED : $GUI_UNCHECKED)

EndFunc	;==>applyConfig

Func saveConfig()

   IniWrite($config, $setting_common_group, "win_title", GUICtrlRead($inputNoxTitle))
   IniWrite($config, $setting_common_group, "thick_frame_size", GUICtrlRead($inputThickFraemSize))
   IniWrite($config, $setting_common_group, "game_icon_pos", GUICtrlRead($inputGameIconPos))
   IniWrite($config, $setting_common_group, "dungeon_treasure_level", _GUICtrlComboBox_GetCurSel($comboDungeonTreasureLevel) + 1)
   IniWrite($config, $setting_common_group, "dungeon_sweep_troop", _GUICtrlComboBox_GetCurSel($comboDungeonSweepTroop) + 1)

   IniWrite($config, $setting_common_group, "enabled_capture_mode", _IsChecked($checkBotCaptureModeEnabled))

   IniWrite($config, $setting_common_group, "enabled_attack_troup_1", _IsChecked($checkAutoFieldAttackTroop1))
   IniWrite($config, $setting_common_group, "enabled_attack_troup_2", _IsChecked($checkAutoFieldAttackTroop2))
   IniWrite($config, $setting_common_group, "enabled_attack_troup_3", _IsChecked($checkAutoFieldAttackTroop3))
   IniWrite($config, $setting_common_group, "enabled_attack_troup_4", _IsChecked($checkAutoFieldAttackTroop4))

   IniWrite($config, $setting_common_group, "enabled_gather_troup_1", _IsChecked($checkAutoResourceGatheringTroop1))
   IniWrite($config, $setting_common_group, "enabled_gather_troup_2", _IsChecked($checkAutoResourceGatheringTroop2))
   IniWrite($config, $setting_common_group, "enabled_gather_troup_3", _IsChecked($checkAutoResourceGatheringTroop3))
   IniWrite($config, $setting_common_group, "enabled_gather_troup_4", _IsChecked($checkAutoResourceGatheringTroop4))

   IniWrite($config, $setting_common_group, "enabled_dungeon_hero", _IsChecked($checkAutoDungeonHeroSweepEnabled))
   IniWrite($config, $setting_common_group, "enabled_dungeon_exp", _IsChecked($checkAutoDungeonExpSweepEnabled))
   IniWrite($config, $setting_common_group, "enabled_dungeon_treasure", _IsChecked($checkAutoDungeonTreasureEnabled))
   IniWrite($config, $setting_common_group, "enabled_field_attack", _IsChecked($checkAutoFieldAttackEnabled))
   IniWrite($config, $setting_common_group, "enabled_resource_gathering", _IsChecked($checkAutoResourceGatheringEnabled))
   IniWrite($config, $setting_common_group, "enabled_use_cash", _IsChecked($checkUseCashEnabled))
   IniWrite($config, $setting_common_group, "enabled_use_bread", _IsChecked($checkUseBreadEnabled))
   IniWrite($config, $setting_common_group, "enabled_use_march_order", _IsChecked($checkUseMarchOrderEnabled))

EndFunc	;==>saveConfig

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

