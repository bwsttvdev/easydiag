# RunMemoryDiagnostic.ps1

Write-Host "Running memory diagnostic test..."
Start-Sleep -Seconds 5
Start-Process "mdsched.exe"

Write-Host "Waiting for 5 seconds before checking for the cleanup script..."
Start-Sleep -Seconds 5

# Check if CleanupMemoryDiagnostic.ps1 exists
$cleanupScriptPath = "$PSScriptRoot\CleanupMemoryDiagnostic.ps1"
if (Test-Path $cleanupScriptPath) {
    Write-Host "Cleanup script found, adding it to the Startup folder..."
    $shortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\CleanupMemoryDiagnostic.lnk"
    if (!(Test-Path $shortcutPath)) {
        $WshShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($shortcutPath)
        $Shortcut.TargetPath = "powershell.exe"
        $Shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$cleanupScriptPath`""
        $Shortcut.Save()
    }
} else {
    Write-Host "Cleanup script not found, please make sure it is in the same directory as this script."
}