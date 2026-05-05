$battery = Get-WmiObject -Class Win32_Battery
$nativeDisplay = Get-DisplayInfo | Where-Object { $_.DisplayName -match "TL134ADXP03" }
if ($battery.BatteryStatus -eq 1) {
    powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x00000000
    powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x00000000
    powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x00000019
    powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x00000019
    powercfg /setactive SCHEME_BALANCED

    if ($nativeDisplay -and $nativeDisplay.Active) {
        Set-DisplayRefreshRate $nativeDisplay.DisplayId 60
        Set-DisplayResolution $nativeDisplay.DisplayId 1680 1050
    }
} else {
    powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x00000064
    powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x00000064
    powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x00000064
    powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x00000064
    powercfg /setactive SCHEME_BALANCED

    if ($nativeDisplay -and $nativeDisplay.Active) {
        Set-DisplayRefreshRate $nativeDisplay.DisplayId 180
        Set-DisplayResolution $nativeDisplay.DisplayId 2560 1600
    }
}