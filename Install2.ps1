[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url = "https://github.com/YawStar/Dance-Box/releases/download/version_v1.0.0.11/YawStar.Dance-Box_v1.0.0.11_x64_Setup.exe"
$dest = "$env:TEMP\DanceBox_Setup.exe"

Write-Host "`n--- YawStar Dance-Box Installer ---" -ForegroundColor Yellow
Write-Host "Starting download..." -ForegroundColor Gray

$client = New-Object System.Net.WebClient
$client.Headers.Add("User-Agent", "Mozilla/5.0")

# Progress ပြောင်းလဲမှုကို တွက်ချက်ပြသပေးမည့်အပိုင်း
$onProgress = {
    param($sender, $e)
    $percent = $e.ProgressPercentage
    $received = [Math]::Round($e.BytesReceived / 1MB, 2)
    $total = [Math]::Round($e.TotalBytesToReceive / 1MB, 2)
    
    # စာသားကို တစ်ကြောင်းတည်းမှာပဲ Update ဖြစ်အောင် `r သုံးထားပါတယ်
    $status = "`r[Progress] $percent% | Downloaded: $received MB / $total MB "
    Write-Host -NoNewline $status -ForegroundColor Cyan
}

$client.add_DownloadProgressChanged($onProgress)

# Async နည်းလမ်းဖြင့် ဆွဲမှသာ Progress bar က အလုပ်လုပ်မှာပါ
$task = $client.DownloadFileTaskAsync($url, $dest)

# Download ပြီးဆုံးသည်အထိ ခဏစောင့်ပေးခြင်း
while (-not $task.IsCompleted) {
    Start-Sleep -Milliseconds 100
}

if ($task.Status -eq "RanToCompletion") {
    Write-Host "`n`nDownload Completed!" -ForegroundColor Green
    Write-Host "Installing Dance-Box..." -ForegroundColor Green
    Start-Process -FilePath $dest -ArgumentList "/S" -Wait
    Write-Host "Done! Software is ready to use." -ForegroundColor Yellow
} else {
    Write-Host "`n`nError: Download failed!" -ForegroundColor Red
}

# Cleanup
if (Test-Path $dest) { Remove-Item $dest -Force }
