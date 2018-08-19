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
Global Const $NoxMinWinSize = 220
Global Const $AppMinWinWidth = 560
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
Global Const $ViewChangeWaitMSec = 4000
Global Const $FieldActionIdleMSec = 5000
Global Const $DefaultTolerance = 21
Global Const $MaxTryCount = 5

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
Global const $POS_BUTTON_FAVORITE = "67.5:4.21"
Global const $POS_BUTTON_FAVORITE_RESOURCE_TAB = "21.08:42.11"
Global const $POS_BUTTON_TROUP1 = "18.49:23.04 "
Global const $POS_BUTTON_TROUP2 = "18.49:37.03"
Global const $POS_BUTTON_TROUP3 = "18.49:50.68"
Global const $POS_BUTTON_TROUP4 = "18.75:64.04"
Global const $POS_BUTTON_GREEN_MOVE1 = "77.4:30.2"
Global const $POS_BUTTON_GREEN_MOVE2 = "77.4:50.2"
Global const $POS_BUTTON_GREEN_MOVE3 = "77.4:70.2"
Global const $POS_BUTTON_GREEN_MOVE4 = "77.4:87.92"
Global const $POS_BUTTON_FIELD_ACTION = "58.8:49.8"
Global const $POS_BUTTON_START_ACTION = "76.74:88.57"
Global const $POS_BUTTON_STATUS_TROOPS = "4.1:45.73"
Global const $POS_BUTTON_USE_ACTION_POINT = "49.61:68.56"
Global const $POS_BUTTON_BARRACK_MENU = "4.21:61.94"
Global const $POS_BUTTON_BARRACK_MENU1 = "25.66:30.02"
Global const $POS_BUTTON_BARRACK_MENU2 = "25.66:45.39"
Global const $POS_BUTTON_BARRACK_MAKE = "71.58:80.38"
Global const $POS_BUTTON_DUNGEON = "94.15:56.32"
Global const $POS_BUTTON_DUNGEON_EXP_TAB = "4.53:8.14"
Global const $POS_BUTTON_DUNGEON_HERO_TAB = "4.53:25.48"
Global const $POS_BUTTON_DUNGEON_TREASURE_TAB = "4.53:41.33"
Global const $POS_BUTTON_DUNGEON_SWEEP_PLUS = "58.31:57.89"
Global const $POS_BUTTON_DUNGEON_MOVE_LEFT = "13.2:50.22"
Global const $POS_BUTTON_DUNGEON_13[5] = ["64.43:25.44", "36.19:28.07", "69.32:60.09", "38.26:51.54", "56.85:77.63"]
Global const $POS_BUTTON_DUNGEON_14[5] = ["43.77:25.66", "78.97:47.37", "29.71:40.35", "62.96:55.92", "35.45:74.34"]
Global const $POS_BUTTON_DUNGEON_15[5] = ["72.86:26.97", "41.81:38.38", "81.54:44.96", "26.53:48.03", "42.79:83.11"]
Global const $POS_BUTTON_FAVORITE_MOVE1 = "48.14:38.07"
Global const $POS_BUTTON_FAVORITE_MOVE2 = "48.14:62.47"
Global const $POS_BUTTON_FAVORITE_MOVE3 = "48.14:87.40"
Global const $POS_BUTTON_FAVORITE_MOVE4 = "48.14:82.31"
Global const $POS_BUTTON_NEARBY_ENEMY_TAB = "87.18:26.27"

; ---------- Screen Check ------------
Global const $CHECK_BUTTON_NEARBY[1] = ["94.6:2.3 | 0x0172128"]
Global const $CHECK_BUTTON_TOP_CLOSE[2] = ["96.15:5.26 | 0x965B39", "93.84:5.26 | 0x965B3A"]
Global const $CHECK_BUTTON_EVENT_CLOSE[2] = ["94:12 | 0x09D5B3A", "91.4:12.4 | 0x0925837"]
Global const $CHECK_BUTTON_NEARBY_CLOSE[2] = ["85.1:11.6 | 0x0915D3A", "82.7:12.4 | 0x0925637"]
Global const $CHECK_BUTTON_ALERT_CLOSE[2] = ["71.96:27.41 | 0x995A39", "69.69:27.41 | 0x965938"]
Global const $CHECK_BUTTON_FIELD_MENU_CLOSE[2] = ["88.85:12.8 | 0x955B3A", "86.65:12.8 | 0x955B3A"]
Global const $CHECK_BUTTON_CENTER_BATTLE_EVENT_CLOSE[2] = ["88.19:14.78 | 0x995A38", "85.68:14.78 | 0x9A5B39"]
Global const $CHECK_BUTTON_CAPITAL_TREASURE_CLOSE[2] = ["86.4:14.35 | 0x9C5C3A", "84.13:14.35 | 0x9B5B39"]
Global const $CHECK_BUTTON_CLAN_MISSION_CLOSE[2] = ["80.55:11.56 | 0x965938", "78.16:11.56 | 0x975939"]
Global const $CHECK_BUTTON_HERO_COLLECTION_CLOSE[2] = ["86.34:13.55 | 0x9C5B3A", "83.78:13.55 | 0x925636"]
Global const $CHECK_BUTTON_SELECT_TROOPS_CLOSE[2] = ["89.24:7.04 | 0x955B39", "86.9:7.04 | 0x955B3A"]
Global const $CHECK_BUTTON_USE_ACTION_POINT_CLOSE[2] = ["71.62:22.83 | 0x955B3A", "69.48:22.83 | 0x955B3A"]
Global const $CHECK_BUTTON_FAVORITE_CLOSE[2] = ["86.97:12.37 | 0x9E5D3A", "84.63:12.37 | 0x9D5C39"]
Global const $CHECK_BUTTON_DUNGEON_SWEEP_COUNT_CLOSE[2] = ["71.76:23.46 | 0x955938", "69.32:23.46 | 0x945737"]
Global const $CHECK_BUTTON_DUNGEON_ATTACK_CLOSE[2] = ["82.89:13.16 | 0x9A5A3A", "80.56:13.16 | 0x975939"]
Global const $CHECK_BUTTON_DUNGEON_ATTACK_SWEEP[2] = ["62.35:76.97 | 0x4D733B", "54.4:76.97 | 0x4D733B"]
Global const $CHECK_BUTTON_DUNGEON_ATTACK_INIT[2] = ["77.38:76.97 | 0x8C573F", "68.7:76.97 | 0x8C573F"]
Global const $CHECK_BUTTON_DUNGEON_ATTACK_START[2] = ["53.06:71.93 | 0x4D743B", "45.48:71.93 | 0x4D743B"]
Global const $CHECK_BUTTON_DUNGEON_TREASURE_START[2] = ["77.92:79.23 | 0x8A553D", "69.45:79.23 | 0x8A553D"]
Global const $CHECK_BUTTON_DUNGEON_USE_CASH[2] = ["53.06:68.64 | 0x4D743B", "44.99:68.64 | 0x4D743B"]
Global const $CHECK_BUTTON_DUNGEON_USE_CASH_DENY[2] = ["44.38:65.35 | 0x4D733B", "35.82:65.35 | 0x4D733B"]
Global const $CHECK_MAIN_CASTLE_VIEW[3] = ["96.46:15.49 | 0x76765F", "88.1:14.26 | 0x7F7F68", "29.78:4.37 | 0x73927C"]
Global const $CHECK_MAIN_FIELD_VIEW[4] = ["43.51:3.98 | 0x1E282B", "52.51:3.98 | 0x1E282B", "72.57:3.98 | 0xE0CEAD", "94.6:2.3 | 0x0172128"]
Global const $CHECK_BUTTON_GREEN_MOVE1[2] = ["77.4:30.2 | 0x04C723A", "70.9:30.2 | 0x0486A39"]
Global const $CHECK_BUTTON_GREEN_MOVE2[2] = ["77.12:50.85 | 0x4D733B", "71.4:50.85 | 0x4D733B"]
Global const $CHECK_BUTTON_GREEN_MOVE3[2] = ["77.31:70.82 | 0x4D743B", "71.31:70.82 | 0x4D743B"]
Global const $CHECK_BUTTON_GREEN_MOVE4[1] = ["77.66:87.92 | 0xA8C4A3,0x51655E | 30"]
Global const $CHECK_BUTTON_FIELD_ACTION[1] = ["57.29:63.53 | 0xE8D7BD"]
Global const $CHECK_BUTTON_DUNGEON_WIN_LEAVE[3] = ["75.33:67.62 | 0x4D733B", "84.48:67.62 | 0x4D733B", "75.73:69.29 | 0x476937"]
Global const $CHECK_BUTTON_DUNGEON_LOSE_LEAVE[3] = ["84.88:88.81 | 0x4C713A", "75.07:88.81 | 0x4C713A", "39.12:88.81 | 0x4C723B"]

Global const $CHECK_STATUS_ATTACK_TROOP1[2] = ["33.75:33.79 | 0x4B5152", "33.75:33.79 | 0x38A3BC"]
Global const $CHECK_STATUS_ATTACK_TROOP2[2] = ["33.75:50.68 | 0x4B5152", "33.75:50.68 | 0x38A3BC"]
Global const $CHECK_STATUS_ATTACK_TROOP3[2] = ["33.75:67.06 | 0x4B5152", "33.75:67.06 | 0x38A3BC"]
Global const $CHECK_STATUS_ATTACK_TROOP4[2] = ["33.75:83.62 | 0x4B5152", "33.75:83.62 | 0x38A3BC"]

Global const $CHECK_STATUS_FAVORITE_ERASE_BUTTON1[1] = ["78.77:36.05 | 0x74745B, 0x646452"]
Global const $CHECK_STATUS_FAVORITE_ERASE_BUTTON2[1] = ["78.77:60.53 | 0x74745B, 0x646452"]
Global const $CHECK_STATUS_FAVORITE_ERASE_BUTTON3[1] = ["78.77:85.26 | 0x74745B, 0x646452"]
Global const $CHECK_STATUS_FAVORITE_ERASE_BUTTON4[1] = ["78.77:80 | 0x74745B, 0x646452"]
