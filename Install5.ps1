[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url = "https://github.com/YawStar/Dance-Box/releases/download/version_v1.0.0.11/YawStar.Dance-Box_v1.0.0.11_x64_Setup.exe"
$dest = "$env:TEMP\DanceBox_Setup.exe"

Write-Host "`n--- YawStar Dance-Box Installer ---" -ForegroundColor Yellow
Write-Host "Starting download..." -ForegroundColor Gray

# Progress auto ပြပေးတယ်
Invoke-WebRequest -Uri $url -OutFile $dest

Write-Host "`nDownload Completed!" -ForegroundColor Green
Write-Host "Installing Dance-Box..." -ForegroundColor Green

Start-Process -FilePath $dest -ArgumentList "/S" -Wait

Write-Host "Done! Software is ready to use." -ForegroundColor Yellow

if (Test-Path $dest) { Remove-Item $dest -Force }