;Returns color of pixel in the coordinations

Func _GetPixelColor($iX, $iY)
	Local $aPixelColor = _GDIPlus_BitmapGetPixel($hBitmap, $iX, $iY)
    _log($TRACE, "_GetPixelColor : " & $iX & "," & $iY & " => " & Hex($aPixelColor, 6) )
	Return Hex($aPixelColor, 6)
EndFunc   ;==>_GetPixelColor
