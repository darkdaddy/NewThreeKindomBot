
; -----------------------------
; Settings Variable
; -----------------------------

Local $setting_common_group = "Default"

Global $setting_win_title = "녹스 안드로이드 앱플레이어"
Global $setting_thick_frame_size = "36:2"
Global $setting_attack_troup_count = 2
Global $setting_delay_rate = 1.0
Global $setting_capture_mode = False
Global $setting_checked_dungeon_hero = False
Global $setting_checked_dungeon_exp = False
Global $setting_checked_field_attack = False
Global $setting_checked_use_point = False
Global $setting_checked_use_bread = False
Global $setting_dungeon_troop_number = 2

Func loadConfig()

   $setting_win_title = IniRead($config, $setting_common_group, "win_title", $setting_win_title)
   $setting_thick_frame_size = IniRead($config, $setting_common_group, "thick_frame_size", $setting_thick_frame_size)
   $setting_attack_troup_count = Int(IniRead($config, $setting_common_group, "attack_troop_count", "3"))
   $setting_checked_dungeon_hero = IniRead($config, $setting_common_group, "enabled_dungeon_hero", "False") == "True" ? True : False
   $setting_checked_dungeon_exp = IniRead($config, $setting_common_group, "enabled_dungeon_exp", "False") == "True" ? True : False
   $setting_checked_field_attack = IniRead($config, $setting_common_group, "enabled_field_attack", "False") == "True" ? True : False
   $setting_checked_use_point = IniRead($config, $setting_common_group, "enabled_use_point", "False") == "True" ? True : False
   $setting_checked_use_bread = IniRead($config, $setting_common_group, "enabled_use_bread", "False") == "True" ? True : False

EndFunc	;==>loadConfig

Func applyConfig()

   GUICtrlSetData($inputNoxTitle, $setting_win_title)
   GUICtrlSetData($inputThickFraemSize, $setting_thick_frame_size)
   _GUICtrlComboBox_SetCurSel($comboTroopCount, Int($setting_attack_troup_count) - 1)

   Local $arr = StringSplit($setting_thick_frame_size, ":")
   $NoxTitleBarHeight = Number($arr[1])
   $ThickFrameSize = Number($arr[2])

   GUICtrlSetState($checkAutoDungeonHeroSweepEnabled, $setting_checked_dungeon_hero ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoDungeonExpSweepEnabled, $setting_checked_dungeon_exp ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkAutoFieldAttackEnabled, $setting_checked_field_attack ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkUsePointEnabled, $setting_checked_use_point ? $GUI_CHECKED : $GUI_UNCHECKED)
   GUICtrlSetState($checkUseBreadEnabled, $setting_checked_use_bread ? $GUI_CHECKED : $GUI_UNCHECKED)

EndFunc	;==>applyConfig

Func saveConfig()

   IniWrite($config, $setting_common_group, "win_title", GUICtrlRead($inputNoxTitle))
   IniWrite($config, $setting_common_group, "thick_frame_size", GUICtrlRead($inputThickFraemSize))
   IniWrite($config, $setting_common_group, "attack_troop_count", _GUICtrlComboBox_GetCurSel($comboTroopCount) + 1)

   IniWrite($config, $setting_common_group, "enabled_dungeon_hero", _IsChecked($checkAutoDungeonHeroSweepEnabled))
   IniWrite($config, $setting_common_group, "enabled_dungeon_exp", _IsChecked($checkAutoDungeonExpSweepEnabled))
   IniWrite($config, $setting_common_group, "enabled_field_attack", _IsChecked($checkAutoFieldAttackEnabled))
   IniWrite($config, $setting_common_group, "enabled_use_point", _IsChecked($checkUsePointEnabled))
   IniWrite($config, $setting_common_group, "enabled_use_bread", _IsChecked($checkUseBreadEnabled))

EndFunc	;==>saveConfig

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

