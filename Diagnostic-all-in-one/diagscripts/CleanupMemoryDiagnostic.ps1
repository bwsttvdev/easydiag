# CleanupMemoryDiagnostic.ps1

Write-Host "Opening Event Viewer and searching for the memory test log..."

Start-Sleep -Seconds 2

Write-Host "Searching for event ID 1101..."
Get-WinEvent -FilterHashtable @{LogName='System'; Id=1101} | Select-Object -First 1 | Format-List

Write-Host "Searching for event ID 1201..."
Get-WinEvent -FilterHashtable @{LogName='System'; Id=1201} | Select-Object -First 1 | Format-List

Write-Host "Removing the shortcut from the Startup folder..."
Start-Sleep -Seconds 2
$shortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\CleanupMemoryDiagnostic.lnk"
Remove-Item $shortcutPath

Write-Host "Press any key to close..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")