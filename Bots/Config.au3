
; -----------------------------
; Settings Variable
; -----------------------------

Local $setting_common_group = "Default"

Global $setting_win_title = "녹스 안드로이드 앱플레이어"
Global $setting_thick_frame_size = "36:2"
Global $setting_attack_troup_count = 2
Global $setting_delay_rate = 1.0

Func loadConfig()

   $setting_win_title = IniRead($config, $setting_common_group, "win_title", $setting_win_title)
   $setting_thick_frame_size = IniRead($config, $setting_common_group, "thick_frame_size", $setting_thick_frame_size)
   $setting_attack_troup_count = Int(IniRead($config, $setting_common_group, "attack_troop_count", "3"))

EndFunc	;==>loadConfig

Func applyConfig()

   GUICtrlSetData($inputNoxTitle, $setting_win_title)
   GUICtrlSetData($inputThickFraemSize, $setting_thick_frame_size)
   _GUICtrlComboBox_SetCurSel($comboTroopCount, Int($setting_attack_troup_count) - 1)

   Local $arr = StringSplit($setting_thick_frame_size, ":")
   $NoxTitleBarHeight = Number($arr[1])
   $ThickFrameSize = Number($arr[2])

EndFunc	;==>applyConfig

Func saveConfig()

   IniWrite($config, $setting_common_group, "win_title", GUICtrlRead($inputNoxTitle))
   IniWrite($config, $setting_common_group, "thick_frame_size", GUICtrlRead($inputThickFraemSize))
   IniWrite($config, $setting_common_group, "attack_troop_count", _GUICtrlComboBox_GetCurSel($comboTroopCount) + 1)

EndFunc	;==>saveConfig

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

