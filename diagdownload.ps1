# Check if Git is installed
$gitInstalled = (Get-Command git) -ne $null

if (!$gitInstalled) {
    Write-Host "Git not found. Installing Git..."

    # Download and install Git
    Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.29.2.windows.2/Git-2.29.2-64-bit.exe -OutFile GitSetup.exe
    Start-Process GitSetup.exe -ArgumentList '/VERYSILENT /DIR=C:\Program Files\Git' -Wait

    Write-Host "Git installation complete."
}

Write-Host "Cloning scripts repository..."

# Clone scripts repository
git clone https://github.com/bwsttvdev/easydiag.git

Write-Host "Scripts repository cloned."

Write-Host "Copying scripts to the current directory..."
#Copy scripts to the current directory

Get-ChildItem -Path ".\easydiag\Diagnostic-all-in-one\*" | Copy-Item -Destination $PSScriptRoot -Force

Write-Host "Scripts copied successfully."

Write-Host "Deleting cloned repository..."
#Delete cloned repository

Remove-Item -Path "easydiag" -Force -Recurse

Write-Host "Cloned repository deleted."
