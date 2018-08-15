#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GUIEdit.au3>
#include <GUIComboBox.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPIProc.au3>
#include <ScreenCapture.au3>
#include <Date.au3>
#include <Misc.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <GUIMenu.au3>
#include <ColorConstants.au3>
#include <GDIPlus.au3>
#include <GuiRichEdit.au3>
#include <GuiTab.au3>
#include <WinAPISys.au3>

Global Const $64Bit = StringInStr(@OSArch, "64") > 0

Global $NoxTitleBarHeight = 36
Global $ThickFrameSize = 2
Global Const $MinWinSize = 200
Global $WinRect = [0, 0, 0, 0]
Global $WindowClass = "[Qt5QWindowIcon]"
Global $Title

Global $PosXYSplitter = ":"

Global $HWnD = WinGetHandle($Title) ;Handle for Bluestacks window

Global $Compiled
If @Compiled Then
	$Compiled = "Executable"
Else
	$Compiled = "Au3 Script"
EndIf

Global $sLogPath ; `Will create a new log file every time the start button is pressed
Global $hLogFileHandle
Global $Restart = False
Global $RunState = False
Global $PauseBot = False

Global $hBitmap; Image for pixel functions
Global $hHBitmap; Handle Image for pixel functions

Global $dirLogs = @ScriptDir & "\logs\"
Global $dirCapture = @ScriptDir & "\capture\"
Global $ReqText
Global $config = @ScriptDir & "\config.ini"

Global $BSpos[2] ; Inside BlueStacks positions relative to the screen

Global Const $RetryWaitCount = 30
Global Const $SleepWaitMSec = 1500
Global Const $DefaultTolerance = 21
Global Const $MaxTryCount = 10

; ---------- COLORS ------------
Global Const $COLOR_ORANGE = 0xFFA500
Global Const $COLOR_PINK = 0xf1735f
Global Const $COLOR_DARKGREY = 0x555555


; ---------- Positions ------------
Global const $POS_BUTTON_NEARBY = "94.6:2.3"
Global const $POS_BUTTON_TOP_CLOSE = "96.7:4.2"
Global const $POS_BUTTON_EVENT_CLOSE = "94:12"
Global const $POS_BUTTON_NEARBY_CLOSE = "85.1:11.6"
Global const $POS_BUTTON_GOTO_MAP = "93.3:91"
Global const $POS_BUTTON_TROUP1 = "18.49:23.04 "
Global const $POS_BUTTON_TROUP2 = "18.49:37.03"
Global const $POS_BUTTON_TROUP3 = "18.49:50.68"
Global const $POS_BUTTON_TROUP4 = "18.75:64.04"
Global const $POS_BUTTON_GREEN_MOVE1 = "77.4:30.2"
Global const $POS_BUTTON_GREEN_MOVE2 = "77.4:50.2"
Global const $POS_BUTTON_GREEN_MOVE3 = "77.4:70.2"
Global const $POS_BUTTON_GREEN_MOVE4 = "77.4:87.92"
Global const $POS_BUTTON_FIELD_ATTACK = "58.8:49.8"
Global const $POS_BUTTON_START_ATTACK = "76.74:88.57"
Global const $POS_BUTTON_STATUS_TROOPS = "4.1:45.73"
Global const $POS_BUTTON_CHARGE_ATTACK_POINT = "49.61:68.56"
Global const $POS_BUTTON_BARRACK_MENU = "4.21:61.94"
Global const $POS_BUTTON_BARRACK_MENU1 = "25.66:30.02"
Global const $POS_BUTTON_BARRACK_MENU2 = "25.66:45.39"
Global const $POS_BUTTON_BARRACK_MAKE = "71.58:80.38"


; ---------- Screen Check ------------
Global const $CHECK_BUTTON_NEARBY[1] = ["94.6:2.3 | 0x0172128"]
Global const $CHECK_BUTTON_TOP_CLOSE[2] = ["96.15:5.26 | 0x965B39", "93.84:5.26 | 0x965B3A"]
Global const $CHECK_BUTTON_EVENT_CLOSE[2] = ["94:12 | 0x09D5B3A", "91.4:12.4 | 0x0925837"]
Global const $CHECK_BUTTON_NEARBY_CLOSE[2] = ["85.1:11.6 | 0x0915D3A", "82.7:12.4 | 0x0925637"]
Global const $CHECK_BUTTON_ALERT_CLOSE[2] = ["71.96:27.41 | 0x995A39", "69.69:27.41 | 0x965938"]
Global const $CHECK_BUTTON_FIELD_MENU_CLOSE[2] = ["88.85:12.8 | 0x955B3A", "86.65:12.8 | 0x955B3A"]
Global const $CHECK_MAIN_CASTLE_VIEW[2] = ["96.46:15.49 | 0x76765F", "88.1:14.26 | 0x7F7F68"]
Global const $CHECK_BUTTON_GREEN_MOVE1[2] = ["77.4:30.2 | 0x04C723A", "70.9:30.2 | 0x0486A39"]
Global const $CHECK_BUTTON_GREEN_MOVE2[2] = ["77.12:50.85 | 0x4D733B", "71.4:50.85 | 0x4D733B"]
Global const $CHECK_BUTTON_GREEN_MOVE3[2] = ["77.31:70.82 | 0x4D743B", "71.31:70.82 | 0x4D743B"]
Global const $CHECK_BUTTON_GREEN_MOVE4[1] = ["77.66:87.92 | 0xA8C4A3 | 30"]
Global const $CHECK_BUTTON_FIELD_ATTACK[1] = ["57.29:63.53 | 0xE8D7BD"]
Global const $CHECK_BUTTON_SELECT_TROOPS_CLOSE[2] = ["89.24:7.04 | 0x955B39", "86.9:7.04 | 0x955B3A"]
Global const $CHECK_BUTTON_CHARGE_ATTACK_POINT_CLOSE[2] = ["71.62:22.83 | 0x955B3A", "69.48:22.83 | 0x955B3A"]

Global const $CHECK_STATUS_ATTACK_TROOP1[2] = ["33.75:33.79 | 0x4B5152", "33.75:33.79 | 0x38A3BC"]
Global const $CHECK_STATUS_ATTACK_TROOP2[2] = ["33.75:50.68 | 0x4B5152", "33.75:50.68 | 0x38A3BC"]
Global const $CHECK_STATUS_ATTACK_TROOP3[2] = ["33.75:67.06 | 0x4B5152", "33.75:67.06 | 0x38A3BC"]
Global const $CHECK_STATUS_ATTACK_TROOP4[2] = ["33.75:83.62 | 0x4B5152", "33.75:83.62 | 0x38A3BC"]
