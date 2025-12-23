# Script untuk export database langsung dari server remote
# Edit kredensial di bawah sebelum menjalankan

param(
    [Parameter(Mandatory=$false)]
    [string]$ServerHost = "your-server-ip-or-hostname",
    
    [Parameter(Mandatory=$false)]
    [string]$ServerPort = "3306",
    
    [Parameter(Mandatory=$false)]
    [string]$DbUsername = "your-db-username",
    
    [Parameter(Mandatory=$false)]
    [string]$DbPassword = "your-db-password",
    
    [Parameter(Mandatory=$false)]
    [string]$DbName = "rpm",
    
    [Parameter(Mandatory=$false)]
    [string]$OutputFile = "dump_from_server_$(Get-Date -Format 'yyyyMMdd_HHmmss').sql"
)

$MariaDBPath = "C:\Program Files\MariaDB 12.1\bin"
$MySQLDumpExe = Join-Path $MariaDBPath "mysqldump.exe"

Write-Host "Exporting database from server..." -ForegroundColor Cyan
Write-Host "Server: $ServerHost:$ServerPort" -ForegroundColor Yellow
Write-Host "Database: $DbName" -ForegroundColor Yellow
Write-Host "Output: $OutputFile" -ForegroundColor Yellow
Write-Host ""

if (-not (Test-Path $MySQLDumpExe)) {
    Write-Host "Error: mysqldump tidak ditemukan di $MariaDBPath" -ForegroundColor Red
    exit 1
}

# Export database
$env:MYSQL_PWD = $DbPassword
& $MySQLDumpExe -h $ServerHost -P $ServerPort -u $DbUsername --single-transaction --routines --triggers $DbName > $OutputFile

if ($LASTEXITCODE -eq 0) {
    $fileSize = (Get-Item $OutputFile).Length / 1MB
    Write-Host ""
    Write-Host "Export berhasil!" -ForegroundColor Green
    Write-Host "File: $OutputFile" -ForegroundColor Green
    Write-Host "Size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Green
    Write-Host ""
    Write-Host "Sekarang import ke database lokal dengan:" -ForegroundColor Cyan
    Write-Host "  Get-Content $OutputFile | & `"$MariaDBPath\mysql.exe`" -h 127.0.0.1 -P 3306 -u root rpm" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "Export gagal!" -ForegroundColor Red
    Write-Host "Periksa:" -ForegroundColor Yellow
    Write-Host "  1. Server dapat diakses dari komputer ini" -ForegroundColor Yellow
    Write-Host "  2. Firewall mengizinkan koneksi MySQL" -ForegroundColor Yellow
    Write-Host "  3. Kredensial database benar" -ForegroundColor Yellow
    exit 1
}




