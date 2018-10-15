Global $Initiate = 0

Local $tabX = 10
Local $tabY = 10
Local $contentPaneX = $tabX + 10
Local $contentPaneY = $tabY + 30

Local $gap = 10
Local $generalRightHeight = 0
Local $generalBottomHeight = 70
Local $logViewWidth = 350
Local $logViewHeight = 560
Local $frameWidth = $contentPaneX + $logViewWidth + $gap + $generalRightHeight + $tabX
Local $frameHeight = $contentPaneY + $logViewHeight + $gap + $generalBottomHeight + $tabY

Local $tabHeight = $frameHeight - $tabY - $tabY
Local $contentPaneWidth = $frameWidth - $contentPaneX * 2
Local $contentPaneHeight = $tabHeight - 30
Local $x
Local $y
Local $h = 20
Local $w = 150

; Main GUI Settings
$mainView = GUICreate($sBotTitle, $frameWidth, $frameHeight, -1, -1)

$idTab = GUICtrlCreateTab($tabX, $tabY, $frameWidth - $tabX * 2, $tabHeight)


;-----------------------------------------------------------
; Tab : General
;-----------------------------------------------------------
Local $generalRightX = $frameWidth - $tabX - $generalRightHeight
Local $generalBottomY = $frameHeight - $tabY - $generalBottomHeight

GUICtrlCreateTabItem("General")

$x = $generalRightX
$y = $contentPaneY + 5


; The Bot Status Screen
$txtLog = _GUICtrlRichEdit_Create($mainView, "", $contentPaneX, $contentPaneY, $logViewWidth, $logViewHeight, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, 8912))

; Start/Stop Button
$x = $contentPaneX
Local $btnWidth = 90
$btnStart = GUICtrlCreateButton("Start Bot", $x, $generalBottomY, $btnWidth, 55)
$btnStop = GUICtrlCreateButton("Stop Bot", $x, $generalBottomY, $btnWidth, 55)
$x += $btnWidth + 10
$btnReboot = GUICtrlCreateButton("Reboot Game", $x, $generalBottomY, 100, 25)
$btnTodayJob = GUICtrlCreateButton("Today Job", $x, $generalBottomY + 30, 100, 25)

$x += 100 + 10
$btnPullout = GUICtrlCreateButton("Pullout", $x, $generalBottomY, 100, 25)
$btnGetClanMission = GUICtrlCreateButton("Clan Mission", $x, $generalBottomY + 30, 100, 25)

;-----------------------------------------------------------
; Tab : Option
;-----------------------------------------------------------

GUICtrlCreateTabItem("Option")

; Battle Buff Items
$x = $contentPaneX
$y = $contentPaneY

; Nox Title
$Label_1 = GUICtrlCreateLabel("Nox Title", $x, $y + 5, 60, 20)
$x += 80
$inputNoxTitle = GUICtrlCreateInput("", $x, $y, 200, 20)

; Nox ThickFrame
$x = $contentPaneX
$y += 30
$Label_2 = GUICtrlCreateLabel("Thick Frame", $x, $y + 5, 100, 20)
$x += 80
$inputThickFraemSize = GUICtrlCreateInput("", $x, $y, 200, 20)

; Game Icon Position
$x = $contentPaneX
$y += 30
$Label_2 = GUICtrlCreateLabel("Game Icon Position", $x, $y + 5, 120, 20)
$x += 120
$inputGameIconPos = GUICtrlCreateInput("", $x, $y, 100, 20)
$y += 25

$x = $contentPaneX
GUICtrlCreateLabel("Game Speed", $x, $y+5, 100, 20)
$x += 120
$sliderGameSpeed = GUICtrlCreateSlider($x, $y, 110, 20)
GUICtrlSetLimit(-1, 100, 0) ; change min/max value
GUICtrlSetData($sliderGameSpeed, 50)
$x += 120
$inputGameSpeed = GUICtrlCreateInput("", $x, $y, 30, 20)
$y += 25

; Dungeon Treasure Level
$x = $contentPaneX
$y += 10
GUICtrlCreateLabel("Auto Reconnect After", $x, $y)
$inputAutoReconnectAfter = GUICtrlCreateInput("0", $x + 130, $y - 5, 30, $h)
GUICtrlCreateLabel("Min", $x + 165, $y)
$y += $h

; Bot Capture Mode
$x = $contentPaneX
$checkBotCaptureModeEnabled = GUICtrlCreateCheckbox("Bot Capture Mode", $x, $y, 250, 25)
$y += 26

; Auto Today job
$checkAutoTodayJobEnabled = GUICtrlCreateCheckbox("Auto Today Job", $x, $y, 250, 25)
$y += 26

; Auto Dungeon Treasure
$checkAutoDungeonTreasureEnabled = GUICtrlCreateCheckbox("Auto Dungeon Treasure", $x, $y, 250, 25)
$y += 26

; Auto Dungeon Exp Sweep
$checkAutoDungeonHeroSweepEnabled = GUICtrlCreateCheckbox("Auto Dungeon Hero Sweep (1~15)", $x, $y, 250, 25)
$y += 26

; Auto Dungeon Hero Sweep
$x = $contentPaneX
$checkAutoDungeonExpSweepEnabled = GUICtrlCreateCheckbox("Auto Dungeon Exp. Sweep (13~15)", $x, $y, 250, 25)
$y += 32

; Auto Mission Attack
$checkAutoMissionAttackEnabled = GUICtrlCreateCheckbox("Auto Mission Attack", $x, $y, 170, 25)
$checkAutoMissionAttackTroop1 = GUICtrlCreateCheckbox("1", $x + 170, $y, 30, 25)
$checkAutoMissionAttackTroop2 = GUICtrlCreateCheckbox("2", $x + 200, $y, 30, 25)
$checkAutoMissionAttackTroop3 = GUICtrlCreateCheckbox("3", $x + 230, $y, 30, 25)
$checkAutoMissionAttackTroop4 = GUICtrlCreateCheckbox("4", $x + 260, $y, 30, 25)
$y += 26

; Auto Filed Attack
$checkAutoFieldAttackEnabled = GUICtrlCreateCheckbox("Auto Field Attack", $x, $y, $w, 25)
$checkAutoFieldAttackTroop1 = GUICtrlCreateCheckbox("1", $x + 170, $y, 30, 25)
$checkAutoFieldAttackTroop2 = GUICtrlCreateCheckbox("2", $x + 200, $y, 30, 25)
$checkAutoFieldAttackTroop3 = GUICtrlCreateCheckbox("3", $x + 230, $y, 30, 25)
$checkAutoFieldAttackTroop4 = GUICtrlCreateCheckbox("4", $x + 260, $y, 30, 25)
$y += 26

; Auto Resource Gathering
$checkAutoResourceGatheringEnabled = GUICtrlCreateCheckbox("Auto Resource Gathering", $x, $y, 170, 25)
$checkAutoResourceGatheringTroop1 = GUICtrlCreateCheckbox("1", $x + 170, $y, 30, 25)
$checkAutoResourceGatheringTroop2 = GUICtrlCreateCheckbox("2", $x + 200, $y, 30, 25)
$checkAutoResourceGatheringTroop3 = GUICtrlCreateCheckbox("3", $x + 230, $y, 30, 25)
$checkAutoResourceGatheringTroop4 = GUICtrlCreateCheckbox("4", $x + 260, $y, 30, 25)
$y += 26

; Auto Explore Castle
$checkAutoExploreCastleEnabled = GUICtrlCreateCheckbox("Auto Explore Castle", $x, $y, 170, 25)
$checkAutoExploreCastleTroop1 = GUICtrlCreateCheckbox("1", $x + 170, $y, 30, 25)
$checkAutoExploreCastleTroop2 = GUICtrlCreateCheckbox("2", $x + 200, $y, 30, 25)
$checkAutoExploreCastleTroop3 = GUICtrlCreateCheckbox("3", $x + 230, $y, 30, 25)
$checkAutoExploreCastleTroop4 = GUICtrlCreateCheckbox("4", $x + 260, $y, 30, 25)
$y += 32

; Use Cash
$checkUseCashEnabled = GUICtrlCreateCheckbox("Enable Use Cash", $x, $y, $w, 25)
$y += 26

; Use MarchOrder
$checkUseMarchOrderEnabled = GUICtrlCreateCheckbox("Enable Use MarchOrder", $x, $y, 170, 25)
$y += 26

; Use Bread
$checkUseBreadEnabled = GUICtrlCreateCheckbox("Enable Use Bread", $x, $y, $w, 25)
$y += 35

; Dungeon Sweep Troop Combobox
GUICtrlCreateLabel("Dungeon Sweep Troop", $x, $y)
$comboDungeonSweepTroop = GUICtrlCreateCombo("", $x + 140, $y - 5, 40, $h)
GUICtrlSetData($comboDungeonSweepTroop, "1")
GUICtrlSetData($comboDungeonSweepTroop, "2")
GUICtrlSetData($comboDungeonSweepTroop, "3")
GUICtrlSetData($comboDungeonSweepTroop, "4")
_GUICtrlComboBox_SetCurSel($comboDungeonSweepTroop, 2)
$y += ($h + 10)

; Dungeon Treasure Level
GUICtrlCreateLabel("Dungeon Treasure Level", $x, $y)
$comboDungeonTreasureLevel = GUICtrlCreateCombo("", $x + 150, $y - 5, 40, $h)
GUICtrlSetData($comboDungeonTreasureLevel, "1")
GUICtrlSetData($comboDungeonTreasureLevel, "2")
GUICtrlSetData($comboDungeonTreasureLevel, "3")
GUICtrlSetData($comboDungeonTreasureLevel, "4")
_GUICtrlComboBox_SetCurSel($comboDungeonTreasureLevel, 2)

; Dungeon Treasure Main Skill Tick Count
$x = $x + 200
$inputTreasureDungeonMainSkillTickCount = GUICtrlCreateInput("", $x, $y - 5, 30, 20)
GUICtrlCreateLabel("Main Skill Tick", $x + 35, $y)
$y += ($h + 10)

; Utilty Group Box
$y += 10
GUICtrlCreateGroup("Utility", 20, $y, 347, 80)
$x = $contentPaneX + 10
$y += 20

; Pos Calc
$Label_1 = GUICtrlCreateLabel("PosCalc", $x, $y + 5, 55, 20)
$x += 60
$inputCalcPosX = GUICtrlCreateInput("", $x, $y, 30, 20)
$x += 30
GUICtrlCreateLabel($PosXYSplitter, $x, $y + 5, 10, 20)
$x += 10
$inputCalcPosY = GUICtrlCreateInput("", $x, $y, 30, 20)
$x += 40
$btnCalcPos = GUICtrlCreateButton("Calc", $x, $y, 40, 20)
$x += 50
$inputCalcResult = GUICtrlCreateInput("", $x, $y, 140, 20)
$y += 30

$x = $contentPaneX + 10
$Label_2 = GUICtrlCreateLabel("ColorTest", $x, $y + 5, 55, 20)
$x += 60
$inputPosInfo = GUICtrlCreateInput("", $x, $y, 130, 20)
$x += 135
$btnTestColor = GUICtrlCreateButton("Test", $x, $y, 40, 20)
$x += 50
$inputTestColor = GUICtrlCreateInput("", $x, $y, 60, 20)


;-----------------------------------------------------------
; Tab : Stats
;-----------------------------------------------------------

GUICtrlCreateTabItem("Stats")

; Battle Buff Items
$x = $contentPaneX
$y = $contentPaneY + 20
Local $statLabelW = 140
Local $statLabelGap = 20

GUICtrlCreateLabel("Loop Count", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_LoopCount = GUICtrlCreateLabel("0", $x, $y, 60, 20)
GUICtrlSetColor($labelStats_LoopCount, $COLOR_BLUE)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Enemy Attact Recall", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_EnemyAttackRecall = GUICtrlCreateLabel("0", $x, $y, 60, 20)
GUICtrlSetColor($labelStats_EnemyAttackRecall, $COLOR_RED)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Field Resource Collect", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_ResourceGathering = GUICtrlCreateLabel("0", $x, $y, 60, 20)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Attack Field Monster", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_AttackFieldMonster = GUICtrlCreateLabel("0", $x, $y, 60, 20)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Clan Mission Complete", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_ClanMissionComplete = GUICtrlCreateLabel("0", $x, $y, 60, 20)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Clan Support", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_ClanSupport = GUICtrlCreateLabel("0", $x, $y, 60, 20)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Reboot Count", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_RebootCount = GUICtrlCreateLabel("0", $x, $y, 60, 20)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Use Buff Count", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_UseBuffCount = GUICtrlCreateLabel("0", $x, $y, 60, 20)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Use Cash Count", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_UseCashCount = GUICtrlCreateLabel("0", $x, $y, 60, 20)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Use MarchOrder Count", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_UseMarchOrderCount = GUICtrlCreateLabel("0", $x, $y, 60, 20)

$y += 30
$x = $contentPaneX
GUICtrlCreateLabel("Use Bread Count", $x, $y, $statLabelW, 20)
$x += $statLabelW + $statLabelGap
$labelStats_UseBreadCount = GUICtrlCreateLabel("0", $x, $y, 60, 20)


;==================================
; Control Initial setting
;==================================

GUISetOnEvent($GUI_EVENT_CLOSE, "mainViewClose", $mainView)
GUICtrlSetOnEvent($btnStart, "btnStart")
GUICtrlSetOnEvent($btnStop, "btnStop")	; already handled in GUIControl
GUICtrlSetOnEvent($idTab, "tabChanged")
GUICtrlSetOnEvent($btnCalcPos, "btnCalcPos")
GUICtrlSetOnEvent($btnReboot, "btnReboot")
GUICtrlSetOnEvent($btnPullout, "btnPullout")
GUICtrlSetOnEvent($btnGetClanMission, "btnGetClanMission")
GUICtrlSetOnEvent($btnTodayJob, "btnTodayJob")
GUICtrlSetOnEvent($btnTestColor, "btnTestColor")
GUICtrlSetOnEvent($sliderGameSpeed, "sliderGameSpeedEvent")
GUICtrlSetOnEvent($inputGameSpeed, "inputGameSpeed")

GUICtrlSetState($btnStart, $GUI_SHOW)
GUICtrlSetState($btnStop, $GUI_HIDE)

GUISetState(@SW_SHOW, $mainView)


;==================================
; Control Callback
;==================================

Func tabChanged()
   If _GUICtrlTab_GetCurSel($idTab) = 0 Then
	  ControlShow($mainView, "", $txtLog)
   Else
	  ControlHide($mainView, "", $txtLog)
   EndIf
EndFunc


Func InitBot()
   $RunState = True
   $PauseBot = False

   GUICtrlSetState($btnStart, $GUI_HIDE)
   GUICtrlSetState($btnStop, $GUI_SHOW)

   saveConfig()
   loadConfig()
   applyConfig()

   If findWindow() Then
	  WinActivate($HWnD)
	  IsNoxActivated()

	   _log($INFO, "NoxTitleBarHeight : " & $NoxTitleBarHeight )
	   _log($INFO, "ThickFrameSize : " & $ThickFrameSize )
	  SetLog($INFO, "Nox : " & $WinRect[0] & "," & $WinRect[1] & " " & $WinRect[2] & "x" & $WinRect[3] & "(" & $setting_thick_frame_size & ")", $COLOR_ORANGE)
	  If $HWndTool Then
		 SetLog($INFO, "NoxTool : " & $WinRectTool[0] & "," & $WinRectTool[1] & " " & $WinRectTool[2] & "x" & $WinRectTool[3], $COLOR_ORANGE)
	  EndIf

	  If $WinRect[2] < $AppMinWinWidth Then
		  SetLog($ERROR, "Nox Minimum Width = " & $AppMinWinWidth, $COLOR_RED)
		  Return False
	  EndIf
   Else
	  SetLog($ERROR, "Nox Not Found", $COLOR_RED)
	  btnStop()
   EndIf

   UpdateWindowRect()
   GUICtrlSetState($btnReboot, $GUI_DISABLE)
   GUICtrlSetState($btnTodayJob, $GUI_DISABLE)
   GUICtrlSetState($btnPullout, $GUI_DISABLE)
   GUICtrlSetState($btnGetClanMission, $GUI_DISABLE)

   Return True
EndFunc


Func calcPos()
   $orgPosX = Int(GUICtrlRead($inputCalcPosX))
   $orgPosY = Int(GUICtrlRead($inputCalcPosY))

   $posX = $orgPosX - $ThickFrameSize
   $posY = $orgPosY - $NoxTitleBarHeight

   $org = WinGetPos($HWnD)
   $r = $org
   If Not @error Then

	  $r[0] = $r[0] + $ThickFrameSize
	  $r[1] = $r[1] + $NoxTitleBarHeight
	  $r[2] = $r[2] + ($ThickFrameSize * 2)
	  $r[3] = $r[3] - $NoxTitleBarHeight - $ThickFrameSize

	  $x = Round($posX * 100.0 / $r[2], 2)
	  $y = Round($posY * 100.0 / $r[3], 2)

	  $result = $x & $PosXYSplitter & $y
	  GUICtrlSetData($inputPosInfo, $result)

	  $color = GetPixelColor($orgPosX, $orgPosY);
	  $colorStr = "0x" & $color
	  $result = $result & " | " & $colorStr

	  ClipPut($result)

	  Local $bgColor = Number($colorStr)

	  GUICtrlSetData($inputCalcResult, $result)
	  GUICtrlSetBkColor($btnCalcPos, $bgColor)
   Else
	  GUICtrlSetData($inputCalcResult, "Nox Not Found")
   EndIf
EndFunc


Func btnStart()
   _log($DEBUG, "START BUTTON CLICKED" )

   clearStats()

   _GUICtrlEdit_SetText($txtLog, "")
   _WinAPI_EmptyWorkingSet(WinGetProcess($HWnD)) ; Reduce Nox Memory Usage

   If InitBot() = False Then
	  Return
   EndIf

   runBot()

EndFunc

Func btnStop()
   If $RunState = False Then
	  Return
   EndIf

   _log($DEBUG, "STOP BUTTON CLICKED" )

   GUICtrlSetState($btnStart, $GUI_SHOW)
   GUICtrlSetState($btnStop, $GUI_HIDE)

   $Restart = False
   $RunState = False
   $PauseBot = True

   GUICtrlSetState($btnReboot, $GUI_ENABLE)
   GUICtrlSetState($btnTodayJob, $GUI_ENABLE)
   GUICtrlSetState($btnPullout, $GUI_ENABLE)
   GUICtrlSetState($btnGetClanMission, $GUI_ENABLE)

   SetLog($INFO, "Bot has stopped", $COLOR_RED)
EndFunc

Func btnCalcPos()

   saveConfig()
   loadConfig()
   applyConfig()

   If findWindow() Then
	  WinActivate($HWnD)
   EndIf

   calcPos()
EndFunc

Func btnTestColor()
   saveConfig()
   loadConfig()
   applyConfig()

   If findWindow() Then
	  WinActivate($HWnD)
   EndIf

   $screenInfo = GUICtrlRead($inputPosInfo)

   Local $infoArr = StringSplit($screenInfo, "|")
   Local $posArr = StringSplit($infoArr[1], ",")
   Local $PixelTolerance = 15
   If UBound($infoArr) - 1 >= 3 Then
	  $PixelTolerance = Number($infoArr[3])
   EndIf

   Local $pos = ControlPos($posArr[1])
   $x = $pos[0]
   $y = $pos[1]
   Local $answerColor = GetPixelColor($x, $y)

   _log($DEBUG, $pos[0] & "(" & $x & ")" & "x" & $pos[1] & "(" & $y & ")" & " => " & $answerColor)

   GUICtrlSetData($inputTestColor, "0x" & $answerColor)
   GUICtrlSetBkColor($btnTestColor, Number("0x" & $answerColor))
EndFunc

Func btnReboot()
   If InitBot() = False Then
	  Return
   EndIf

   RebootNox()

   btnStop()
EndFunc

Func btnTodayJob()
   If InitBot() = False Then
	  Return
   EndIf

   MainTodayJob()

   btnStop()
EndFunc

Func btnPullout()
   If InitBot() = False Then
	  Return
   EndIf

   PullOutAllResourceTroops()

   btnStop()
EndFunc

Func btnGetClanMission()
   If InitBot() = False Then
	  Return
   EndIf

   DoGetClanMission()

   btnStop()
EndFunc

; System callback
Func mainViewClose()

   saveConfig()
   _GDIPlus_Shutdown()
   _GUICtrlRichEdit_Destroy($txtLog)
   $hKey_Proc = 0

   Exit
EndFunc

Func sliderGameSpeedEvent()
   $v = (GUICtrlRead($sliderGameSpeed) - 50) / 50;
   $rate = 1.0 + $v
   GUICtrlSetData($inputGameSpeed, $rate)
   changeGameSpeed($rate)
EndFunc

Func inputGameSpeed()
   $rate = Number(GUICtrlRead($inputGameSpeed), $NUMBER_DOUBLE)
   $v = ($rate - 1.0) * 50 + 50
   GUICtrlSetData($sliderGameSpeed, $v)
   changeGameSpeed($rate)
EndFunc

Func changeGameSpeed($newSpeed)
   If $newSpeed <> $setting_game_speed_rate Then
	  SetLog($INFO, "Game speed : " & $setting_game_speed_rate & " => " & $newSpeed, $COLOR_BLUE)
	  $setting_game_speed_rate = $newSpeed
   EndIf
EndFunc


Func clearStats()

   $Stats_EnemyAttackRecall = 0
   $Stats_ResourceGathering = 0
   $Stats_AttackFieldMonster = 0
   $Stats_LoopCount = 0
   $Stats_RebootCount = 0
   $Stats_UseBuffCount = 0
   $Stats_UseCashCount = 0
   $Stats_UseBreadCount = 0
   $Stats_UseMarchOrderCount = 0
   $Stats_ClanMissionComplete = 0
   $Stats_ClanSupport = 0

   updateStats()
EndFunc

Func updateStats()
   GUICtrlSetData($labelStats_LoopCount, $Stats_LoopCount)
   GUICtrlSetData($labelStats_EnemyAttackRecall, $Stats_EnemyAttackRecall)
   GUICtrlSetData($labelStats_ResourceGathering, $Stats_ResourceGathering)
   GUICtrlSetData($labelStats_AttackFieldMonster, $Stats_AttackFieldMonster)
   GUICtrlSetData($labelStats_RebootCount, $Stats_RebootCount)
   GUICtrlSetData($labelStats_UseBuffCount, $Stats_UseBuffCount)
   GUICtrlSetData($labelStats_UseCashCount, $Stats_UseCashCount)
   GUICtrlSetData($labelStats_UseBreadCount, $Stats_UseBreadCount)
   GUICtrlSetData($labelStats_UseMarchOrderCount, $Stats_UseMarchOrderCount)
   GUICtrlSetData($labelStats_ClanMissionComplete, $Stats_ClanMissionComplete)
   GUICtrlSetData($labelStats_ClanSupport, $Stats_ClanSupport)

EndFunc
