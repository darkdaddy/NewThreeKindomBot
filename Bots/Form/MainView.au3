Global $Initiate = 0

Local $tabX = 10
Local $tabY = 10
Local $contentPaneX = $tabX + 10
Local $contentPaneY = $tabY + 30

Local $gap = 10
Local $generalRightHeight = 0
Local $generalBottomHeight = 70
Local $logViewWidth = 350
Local $logViewHeight = 270
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

; Attack Troop Count Combobox
$x = $contentPaneX + $btnWidth + 10
$y = $generalBottomY + 5
GUICtrlCreateLabel("Troop Count", $x, $y)
$comboTroopCount = GUICtrlCreateCombo("", $x + 80, $y - 5, 100, $h)
GUICtrlSetData($comboTroopCount, "1")
GUICtrlSetData($comboTroopCount, "2")
GUICtrlSetData($comboTroopCount, "3")
_GUICtrlComboBox_SetCurSel($comboTroopCount, 2)

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

; Nox Title
$x = $contentPaneX
$y += 30
$Label_2 = GUICtrlCreateLabel("Thick Frame", $x, $y + 5, 100, 20)
$x += 80
$inputThickFraemSize = GUICtrlCreateInput("", $x, $y, 200, 20)

$y += 50

GUICtrlCreateGroup("Utility", 20, $y, 410, 80)
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

   findWindow()

   $orgPosX = Int(GUICtrlRead($inputCalcPosX))
   $orgPosY = Int(GUICtrlRead($inputCalcPosY))

   $posX = $orgPosX - $ThickFrameSize
   $posY = $orgPosY -  $NoxTitleBarHeight

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
	  $result = $result & " | " & "0x" & StringMid(Hex($color), 3)

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

   findWindow()

   $screenInfo = GUICtrlRead($inputPosInfo)

   Local $infoArr = StringSplit($screenInfo, "|")
   Local $posArr = StringSplit($infoArr[1], ",")
   Local $PixelTolerance = 15
   If UBound($infoArr) - 1 >= 3 Then
	  $PixelTolerance = Number($infoArr[3])
   EndIf

   Local Const $RegionSize = 1
   Local Const $WinX = $WinRect[0] - $ThickFrameSize
   Local Const $WinY = $WinRect[1] - $NoxTitleBarHeight

   Local $pos = ControlPos($posArr[1])
   $x = $WinX + $pos[0]
   $y = $WinY + $pos[1]
   Local $answerColor = PixelGetColor($x, $y)

   _log( $pos[0] & "(" & $x & ")" & "x" & $pos[1] & "(" & $y & ")" & " => " & Hex($answerColor))

   GUICtrlSetData($inputTestColor, "0x" & StringMid(Hex($answerColor), 3))
EndFunc

; System callback
Func mainViewClose()

   saveConfig()
   _GDIPlus_Shutdown()
   _GUICtrlRichEdit_Destroy($txtLog)
   Exit
EndFunc
