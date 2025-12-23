# PowerShell script untuk setup Laravel setelah database diimport
# Usage: .\setup_laravel.ps1

Write-Host "Setting up Laravel..." -ForegroundColor Cyan

# Check if artisan exists
if (-not (Test-Path "artisan")) {
    Write-Host "Error: artisan file tidak ditemukan!" -ForegroundColor Red
    Write-Host "Pastikan Anda berada di direktori root Laravel" -ForegroundColor Yellow
    exit 1
}

# Check if .env exists
if (-not (Test-Path ".env")) {
    Write-Host "Error: .env file tidak ditemukan!" -ForegroundColor Red
    exit 1
}

Write-Host "1. Generating application key..." -ForegroundColor Yellow
php artisan key:generate --force

Write-Host "2. Clearing configuration cache..." -ForegroundColor Yellow
php artisan config:clear

Write-Host "3. Clearing application cache..." -ForegroundColor Yellow
php artisan cache:clear

Write-Host "4. Clearing route cache..." -ForegroundColor Yellow
php artisan route:clear

Write-Host "5. Clearing view cache..." -ForegroundColor Yellow
php artisan view:clear

Write-Host "6. Optimizing application..." -ForegroundColor Yellow
php artisan config:cache
php artisan route:cache
php artisan view:cache

Write-Host "7. Running migrations (if needed)..." -ForegroundColor Yellow
php artisan migrate --force

Write-Host ""
Write-Host "Laravel setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  - Verify database connection: php artisan tinker"
Write-Host "  - Start development server: php artisan serve"
Write-Host "  - Check routes: php artisan route:list"




