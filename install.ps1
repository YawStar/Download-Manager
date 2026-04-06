$url = "https://github.com/YawStar/Dance-Box/releases/download/version_v1.0.0.11/YawStar.Dance-Box_v1.0.0.11_x64_Setup.exe"
$dest = "$env:TEMP\YawStar Dance-Box_v1.0.0.11_x64_Setup.exe"

Write-Host "Downloading YawStar Dance-Box..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $url -OutFile $dest

Write-Host "Installing..." -ForegroundColor Green
Start-Process -FilePath $dest -ArgumentList "/S" -Wait

Write-Host "Done!" -ForegroundColor Yellow