$client = New-Object System.Net.WebClient

$client.DownloadProgressChanged += {
    param($sender, $e)
    $percent = $e.ProgressPercentage
    $received = [Math]::Round($e.BytesReceived / 1MB, 2)
    $total = [Math]::Round($e.TotalBytesToReceive / 1MB, 2)

    Write-Host -NoNewline "`r[Progress] $percent% ($received MB / $total MB)"
}

$client.DownloadFileCompleted += {
    Write-Host "`nDownload Completed!" -ForegroundColor Green
}

$client.DownloadFileAsync($url, $dest)

# IMPORTANT: Event loop
while ($client.IsBusy) {
    Start-Sleep -Milliseconds 100
    [System.Windows.Forms.Application]::DoEvents()  # ← ဒီလို hack လုပ်ရတယ်
}
