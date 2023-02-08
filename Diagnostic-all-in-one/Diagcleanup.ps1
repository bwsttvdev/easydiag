$currentDirectory = Get-Location
$parentDirectory = Split-Path $currentDirectory -Parent

Write-Host "Removing directory $currentDirectory and all its contents..."

Remove-Item $currentDirectory -Recurse -Force

Write-Host "Directory and its contents removed."

Write-Host "Changing directory to $parentDirectory..."

Set-Location $parentDirectory

Write-Host "Directory changed."