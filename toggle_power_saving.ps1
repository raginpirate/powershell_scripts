$battery = Get-WmiObject -Class Win32_Battery
$displayConfig = Get-DisplayConfig
$display1 = $displayConfig.displays | Where-Object { $_.DisplayId -eq 1 }

if ($battery.BatteryStatus -eq 1) {
    Write-Host "The system is currently running on battery power, throttling power settings..."
	powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x00000000
	powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x00000000
	powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x00000019
	powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x00000019

    if ($display1 -and $display1.Enabled) {
    	Write-Host "The mobile display is currently in use, lowering refresh rate and resolution..."
	    Set-DisplayRefreshRate 1 60
		Set-DisplayResolution 1 1680 1050
    } else {
    	Write-Host "The mobile display is currently disabled."
    }
} else {
    Write-Host "The system is currently plugged in, maxing out power settings..."
	powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x00000064
	powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 0x00000064
	powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x00000064
	powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 0x00000064

    if ($display1 -and $display1.Enabled) {
    	Write-Host "The mobile display is currently in use, maxing out refresh rate and resolution..."
	    Set-DisplayRefreshRate 1 180
		Set-DisplayResolution 1 2560 1600
    } else {
    	Write-Host "The mobile display is currently disabled."
    }
}