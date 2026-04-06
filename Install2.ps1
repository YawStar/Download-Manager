# Security Protocol ကို TLS 1.2 ပြောင်းပေးခြင်း (GitHub အတွက် မဖြစ်မနေလိုအပ်ပါတယ်)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url = "https://github.com/YawStar/Dance-Box/releases/download/version_v1.0.0.11/YawStar.Dance-Box_v1.0.0.11_x64_Setup.exe"
$dest = "$env:TEMP\DanceBox_Setup.exe"

Write-Host "--- YawStar Dance-Box Installer ---" -ForegroundColor Yellow
Write-Host "Starting download..." -ForegroundColor Gray

try {
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("User-Agent", "Mozilla/5.0")
    
    $onProgress = {
        param($sender, $e)
        $percent = $e.ProgressPercentage
        $status = "`r[Downloading] $percent% "
        Write-Host -NoNewline $status -ForegroundColor Cyan
    }
    
    $client.add_DownloadProgressChanged($onProgress)
    
    # Download ဆွဲခြင်း
    $client.DownloadFile($url, $dest)
    
    Write-Host "`nDownload Completed!" -ForegroundColor Green
    Write-Host "Installing..." -ForegroundColor Green
    Start-Process -FilePath $dest -ArgumentList "/S" -Wait
    Write-Host "Done!" -ForegroundColor Yellow
}
catch {
    Write-Host "`nError: $($_.Exception.Message)" -ForegroundColor Red
}
