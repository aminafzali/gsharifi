# اسکریپت دانلود فایل‌های مورد نیاز برای اجرای آفلاین
# این فایل را در PowerShell اجرا کنید: .\download.ps1

$ErrorActionPreference = "Stop"
$jsDir = $PSScriptRoot

Write-Host "در حال دانلود three.min.js..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri "https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.min.js" `
        -OutFile (Join-Path $jsDir "three.min.js") -UseBasicParsing
    Write-Host "three.min.js دانلود شد." -ForegroundColor Green
} catch {
    Write-Host "خطا در دانلود three.min.js: $_" -ForegroundColor Red
}

Write-Host "در حال دانلود tailwind.js..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri "https://cdn.tailwindcss.com" `
        -OutFile (Join-Path $jsDir "tailwind.js") -UseBasicParsing
    Write-Host "tailwind.js دانلود شد." -ForegroundColor Green
} catch {
    Write-Host "خطا در دانلود tailwind.js: $_" -ForegroundColor Red
}

Write-Host "`nتمام شد. فایل‌ها در پوشه js ذخیره شدند." -ForegroundColor Yellow
