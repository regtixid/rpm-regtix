# Cek Status Deployment

Jalankan command berikut untuk cek status deployment:

## 1. Cek File Sudah Ter-Upload

```bash
cd /var/www/rpm

# Cek route file
ls -la routes/api-rpc.php

# Cek controllers
ls -la app/Http/Controllers/Rpc/

# Cek requests  
ls -la app/Http/Requests/Rpc/

# Cek resources
ls -la app/Http/Resources/Rpc/

# Cek services
ls -la app/Services/Rpc/
```

## 2. Cek bootstrap/app.php Sudah Di-Update

```bash
# Cek apakah file mengandung api-rpc.php
grep -n "api-rpc.php" bootstrap/app.php

# Cek apakah ada use Route
grep -n "use Illuminate\\Support\\Facades\\Route" bootstrap/app.php

# Cek apakah ada closure then
grep -n "then:" bootstrap/app.php
```

## 3. Jika File Belum Ada

Jika file belum ada, berarti belum di-upload via WinSCP. Upload dulu semua file sesuai panduan.

## 4. Jika File Sudah Ada Tapi Route Tidak Muncul

Jika file sudah ada tapi route tidak muncul, kemungkinan `bootstrap/app.php` belum di-update dengan benar.

### Update bootstrap/app.php

```bash
# Backup dulu
cp bootstrap/app.php bootstrap/app.php.backup

# Edit file
nano bootstrap/app.php
```

**Tambahkan di bagian atas (setelah use statements):**
```php
use Illuminate\Support\Facades\Route;
```

**Ubah bagian withRouting menjadi:**
```php
->withRouting(
    web: __DIR__.'/../routes/web.php',
    api: __DIR__.'/../routes/api.php',
    commands: __DIR__.'/../routes/console.php',
    health: '/up',
    then: function () {
        Route::middleware('api')
            ->prefix('api/rpc/v1')
            ->group(base_path('routes/api-rpc.php'));
    },
)
```

**Save**: Ctrl+X, lalu Y, lalu Enter

**Test lagi:**
```bash
php artisan route:list | grep rpc
```



















