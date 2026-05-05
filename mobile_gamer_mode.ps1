$nativeDisplay = Get-DisplayInfo | Where-Object { $_.DisplayName -match "TL134ADXP03" }

Set-DisplayRefreshRate $nativeDisplay.DisplayId 180
Set-DisplayResolution $nativeDisplay.DisplayId 2560 1600
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x0000004B
powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x0000004B
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x0000004B
powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x0000004B 