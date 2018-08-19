Global $Initiate = 0

Local $tabX = 10
Local $tabY = 10
Local $contentPaneX = $tabX + 10
Local $contentPaneY = $tabY + 30

Local $gap = 10
Local $generalRightHeight = 0
Local $generalBottomHeight = 70
Local $logViewWidth = 350
Local $logViewHeight = 350
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
$btnStart = GUICtrlCreateButton("Start Bot", $x, $generalBottomY, $btnWidth, 50)
$btnStop = GUICtrlCreateButton("Stop Bot", $x, $generalBottomY, $btnWidth, 50)

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
$y += 40

; Auto Dungeon Hero Sweep
$x = $contentPaneX
$checkAutoDungeonExpSweepEnabled = GUICtrlCreateCheckbox("Auto Dungeon Exp. Sweep (13~15)", $x, $y, 250, 25)
$y += 26

; Auto Dungeon Exp Sweep
$checkAutoDungeonHeroSweepEnabled = GUICtrlCreateCheckbox("Auto Dungeon Hero Sweep (13~15)", $x, $y, 250, 25)
$y += 26

; Auto Dungeon Treasure
$checkAutoDungeonTreasureEnabled = GUICtrlCreateCheckbox("Auto Dungeon Treasure", $x, $y, 250, 25)
$y += 26

; Auto Filed Attack
$checkAutoFieldAttackEnabled = GUICtrlCreateCheckbox("Auto Filed Attack", $x, $y, $w, 25)
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

; Use Point
$checkUseCashEnabled = GUICtrlCreateCheckbox("Enable Use Point", $x, $y, $w, 25)
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
$y += ($h + 10)

; Utilty Group Box
$y += 10
GUICtrlCreateGroup("Utility", 20, $y, 345, 80)
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
$inputCalcResult = GUICtrlCreateInput("", $x, $y, 130, 20)
$y += 30

$x = $contentPaneX + 10
$Label_2 = GUICtrlCreateLabel("ColorTest", $x, $y + 5, 55, 20)
$x += 60
$inputPosInfo = GUICtrlCreateInput("", $x, $y, 130, 20)
$x += 135
$btnTestColor = GUICtrlCreateButton("Test", $x, $y, 40, 20)
$x += 50
$inputTestColor = GUICtrlCreateInput("", $x, $y, 60, 20)

;==================================
; Control Initial setting
;==================================

GUICtrlSetOnEvent($btnStart, "btnStart")
GUICtrlSetOnEvent($btnStop, "btnStop")	; already handled in GUIControl
GUICtrlSetOnEvent($idTab, "tabChanged")
GUICtrlSetOnEvent($btnCalcPos, "btnCalcPos")
GUICtrlSetOnEvent($btnTestColor, "btnTestColor")

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

	   _log("NoxTitleBarHeight : " & $NoxTitleBarHeight )
	   _log("ThickFrameSize : " & $ThickFrameSize )
	  SetLog("Nox : " & $WinRect[0] & "," & $WinRect[1] & " " & $WinRect[2] & "x" & $WinRect[3] & "(" & $setting_thick_frame_size & ")", $COLOR_ORANGE)

	  If $WinRect[2] < $AppMinWinWidth Then
		  SetLog("Nox Minimum Width = " & $AppMinWinWidth, $COLOR_RED)
		  Return False
	  EndIf
   Else
	  SetLog("Nox Not Found", $COLOR_RED)
	  btnStop()
   EndIf

   UpdateWindowRect()

   Return True
EndFunc

Func btnStart()
   _log("START BUTTON CLICKED" )

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

   _log("STOP BUTTON CLICKED" )

   GUICtrlSetState($btnStart, $GUI_SHOW)
   GUICtrlSetState($btnStop, $GUI_HIDE)

   $Restart = False
   $RunState = False
   $PauseBot = True

   SetLog("Bot has stopped", $COLOR_ORANGE)
EndFunc

Func btnCalcPos()

   saveConfig()
   loadConfig()
   applyConfig()

   If findWindow() Then
	  WinActivate($HWnD)
   EndIf

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

	  ClipPut($result)

	  $color = GetPixelColor($orgPosX, $orgPosY);
	  $result = $result & " | " & "0x" & $color

	  _log( "WinSize [" & $org[2] & "," & $org[3] & "] => (" & $orgPosX & "," & $orgPosY & ") => " & $result & ", color = " & Hex($color))

	  GUICtrlSetData($inputCalcResult, $result)

	  CheckForPixel($result)
   Else
	  GUICtrlSetData($inputCalcResult, "Nox Not Found")
   EndIf
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

   _log( $pos[0] & "(" & $x & ")" & "x" & $pos[1] & "(" & $y & ")" & " => " & $answerColor)

   GUICtrlSetData($inputTestColor, "0x" & $answerColor);
EndFunc

; System callback
Func mainViewClose()

   saveConfig()
   _GDIPlus_Shutdown()
   _GUICtrlRichEdit_Destroy($txtLog)
   Exit
EndFunc
