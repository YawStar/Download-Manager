$url = "https://github.com/YawStar/Dance-Box/releases/download/version_v1.0.0.11/YawStar.Dance-Box_v1.0.0.11_x64_Setup.exe"
$dest = "$env:TEMP\YawStar_Dance-Box_Setup.exe"

$client = New-Object System.Net.WebClient
$client.Headers.Add("User-Agent", "Mozilla/5.0") # GitHub ကနေ ဆွဲဖို့ လိုအပ်ပါတယ်

# Progress ပြောင်းလဲမှုကို စောင့်ကြည့်တဲ့ event
$onProgress = {
    param($sender, $e)
    $percent = $e.ProgressPercentage
    $totalMB = [Math]::Round($e.TotalBytesToReceive / 1MB, 2)
    $receivedMB = [Math]::Round($e.BytesReceived / 1MB, 2)
    
    # Terminal မှာ ပေါ်မယ့် စာသား
    $status = "`r[Downloading] $percent% | $receivedMB MB / $totalMB MB "
    Write-Host -NoNewline $status -ForegroundColor Cyan
}

$client.add_DownloadProgressChanged($onProgress)

Write-Host "--- YawStar Dance-Box Installer ---" -ForegroundColor Yellow
Write-Host "Starting download..." -ForegroundColor Gray

# Async နဲ့ Download ဆွဲမှ Progress ကို ဖတ်လို့ရမှာပါ
$task = $client.DownloadFileTaskAsync($url, $dest)
while (-not $task.IsCompleted) { Start-Sleep -Milliseconds 100 }

Write-Host "`nDownload Completed!" -ForegroundColor Green

# Installation စတင်ခြင်း
Write-Host "Installing Dance-Box silently..." -ForegroundColor Green
Start-Process -FilePath $dest -ArgumentList "/S" -Wait

# ဖိုင်ဟောင်းကို ပြန်ဖျက်ခြင်း (Optional)
Remove-Item $dest -Force
Write-Host "Done! Have a great day!" -ForegroundColor Yellow