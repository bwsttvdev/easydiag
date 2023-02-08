Write-Host "Setting up script..."
#Check and install required modules

$requiredModules = @("Microsoft.PowerShell.Management")

foreach ($module in $requiredModules) {
if (!(Get-Module -Name $module -ListAvailable)) {
Write-Host "Installing $module..."
Install-Module $module -Force -Verbose
}
}

Write-Host "Setup complete."
Write-Host "Collecting computer hardware information..."
#Get system information

$computerSystem = Get-CimInstance Win32_ComputerSystem
$processor = Get-CimInstance Win32_Processor
$baseBoard = Get-CimInstance Win32_BaseBoard
$physicalMemory = Get-CimInstance Win32_PhysicalMemory

Write-Host ""
Write-Host "------------- Computer Hardware Information -------------"
Write-Host ""
Write-Host "Computer name: $($computerSystem.Name)"
Write-Host "Manufacturer: $($computerSystem.Manufacturer)"
Write-Host "Model: $($computerSystem.Model)"
Write-Host "Processor: $($processor.Name)"
Write-Host "Base board: $($baseBoard.Product)"
Write-Host "Physical memory: $(($physicalMemory.Capacity | Measure-Object -Sum).Sum / 1GB) GB"
Write-Host ""
Write-Host "------------------------------------------------------------"
Write-Host ""

Write-Host "Select a diagnostic option:"
Write-Host "1. System Information"
Write-Host "2. Disk Usage"
Write-Host "3. Memory Test"
Write-Host "4. Exit"

$selectedOption = Read-Host

$diagScriptsPath = "$PSScriptRoot\diagscripts"

switch ($selectedOption) {
1 {
& "$diagScriptsPath\SystemInfo.ps1"
}
2 {
& "$diagScriptsPath\DiskUsage.ps1"
}
3 {
& "$diagScriptsPath\RunMemoryDiagnostic.ps1"
}
4 {
Write-Host "Exiting."
}
default {
Write-Host "Invalid option."
}
}