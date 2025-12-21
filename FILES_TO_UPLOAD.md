# File yang Perlu Diupload ke Server

## File Backend yang Perlu Diupload

Upload file-file berikut ke server di folder `/var/www/rpm/` (atau sesuai struktur project Anda):

### 1. AuthController.php (BARU - dibuat)
**Path:** `app/Http/Controllers/Rpc/AuthController.php`
- File ini sebelumnya kosong, sekarang sudah ada implementasi login
- **Action:** Upload file baru ini

### 2. PrintController.php (BARU - dibuat)
**Path:** `app/Http/Controllers/Rpc/PrintController.php`
- File ini sebelumnya kosong, sekarang sudah ada implementasi getPayload
- **Action:** Upload file baru ini

### 3. LoginResource.php (BARU - dibuat)
**Path:** `app/Http/Resources/Rpc/LoginResource.php`
- File ini sebelumnya kosong, sekarang sudah ada implementasi resource untuk login
- **Action:** Upload file baru ini

### 4. PrintPayloadRequest.php (DIPERBAIKI)
**Path:** `app/Http/Requests/Rpc/PrintPayloadRequest.php`
- File ini sudah ada, tapi `event_id` diubah menjadi optional
- **Action:** Upload file yang sudah diperbaiki (replace yang lama)

## Daftar File Lengkap untuk Upload

```
www/rpm/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   └── Rpc/
│   │   │       ├── AuthController.php          ← UPLOAD (BARU)
│   │   │       └── PrintController.php         ← UPLOAD (BARU)
│   │   ├── Requests/
│   │   │   └── Rpc/
│   │   │       └── PrintPayloadRequest.php     ← UPLOAD (DIPERBAIKI)
│   │   └── Resources/
│   │       └── Rpc/
│   │           └── LoginResource.php           ← UPLOAD (BARU)
```

## Cara Upload via WinSCP

1. **Buka WinSCP** dan connect ke server

2. **Navigate ke folder project:**
   ```
   /var/www/rpm/
   ```

3. **Upload file-file berikut:**

   **a. AuthController.php**
   - Local: `D:\REGTIX\www\rpm\app\Http\Controllers\Rpc\AuthController.php`
   - Remote: `/var/www/rpm/app/Http/Controllers/Rpc/AuthController.php`

   **b. PrintController.php**
   - Local: `D:\REGTIX\www\rpm\app\Http\Controllers\Rpc\PrintController.php`
   - Remote: `/var/www/rpm/app/Http/Controllers/Rpc/PrintController.php`

   **c. LoginResource.php**
   - Local: `D:\REGTIX\www\rpm\app\Http\Resources\Rpc\LoginResource.php`
   - Remote: `/var/www/rpm/app/Http/Resources/Rpc/LoginResource.php`

   **d. PrintPayloadRequest.php**
   - Local: `D:\REGTIX\www\rpm\app\Http\Requests\Rpc\PrintPayloadRequest.php`
   - Remote: `/var/www/rpm/app/Http/Requests/Rpc/PrintPayloadRequest.php`

4. **Set permission setelah upload:**
   ```bash
   sudo chown -R www-data:www-data /var/www/rpm/app/Http/Controllers/Rpc/
   sudo chown -R www-data:www-data /var/www/rpm/app/Http/Resources/Rpc/
   sudo chown -R www-data:www-data /var/www/rpm/app/Http/Requests/Rpc/
   sudo chmod -R 644 /var/www/rpm/app/Http/Controllers/Rpc/*.php
   sudo chmod -R 644 /var/www/rpm/app/Http/Resources/Rpc/*.php
   sudo chmod -R 644 /var/www/rpm/app/Http/Requests/Rpc/*.php
   ```

5. **Clear cache Laravel (jika perlu):**
   ```bash
   cd /var/www/rpm
   php artisan config:clear
   php artisan cache:clear
   php artisan route:clear
   ```

## Verifikasi Setelah Upload

1. **Test login endpoint:**
   ```bash
   curl -X POST https://rpm.regtix.id/api/rpc/v1/auth/login \
     -H "Content-Type: application/json" \
     -d '{
       "email": "operatorkr26@regtix.id",
       "password": "opekr26"
     }'
   ```
   
   Pastikan response berisi `event_id` di dalam `data.user.event_id`

2. **Test print payload endpoint:**
   ```bash
   # Setelah login, dapatkan token
   TOKEN="[TOKEN_DARI_LOGIN]"
   
   curl -X POST https://rpm.regtix.id/api/rpc/v1/prints/payload \
     -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -d '{
       "print_type": "pickup_sheet",
       "participant_ids": [1]
     }'
   ```
   
   Pastikan response berisi `event_name` yang benar di `data.metadata.event_name`

## Catatan Penting

- ✅ File-file dokumentasi (`.md`, `.sql`, `.sh`) **TIDAK PERLU** diupload ke server
- ✅ Hanya file PHP yang perlu diupload
- ✅ Pastikan permission dan ownership sudah benar setelah upload
- ✅ Clear cache Laravel setelah upload untuk memastikan perubahan terdeteksi













