# File yang Perlu Diupload ke Server (HANYA FOLDER RPC)

## ⚠️ Penting: Hanya upload file di folder RPC

Semua perubahan hanya dilakukan di folder `app/Http/Controllers/Rpc/`, `app/Http/Resources/Rpc/`, dan `app/Http/Requests/Rpc/`.

**TIDAK ADA perubahan di luar folder RPC.**

## File yang Perlu Diupload (4 file)

### 1. AuthController.php (BARU)
**Path:** `app/Http/Controllers/Rpc/AuthController.php`
- File ini sebelumnya kosong, sekarang sudah ada implementasi login
- Mengembalikan `event_id` dari user di response login

### 2. PrintController.php (DIPERBAIKI)
**Path:** `app/Http/Controllers/Rpc/PrintController.php`
- File ini sebelumnya kosong, sekarang sudah ada implementasi getPayload
- Menggunakan `event_id` dari user yang login jika tidak ada di request
- **Fix error format()**: Handle `dob` yang bisa berupa string atau Carbon object
- Mengambil `event_name` dari database Event berdasarkan `event_id`

### 3. LoginResource.php (BARU)
**Path:** `app/Http/Resources/Rpc/LoginResource.php`
- File ini sebelumnya kosong, sekarang sudah ada implementasi resource untuk login
- Mengembalikan user data dengan `event_id` di response

### 4. PrintPayloadRequest.php (DIPERBAIKI)
**Path:** `app/Http/Requests/Rpc/PrintPayloadRequest.php`
- File ini sudah ada, tapi `event_id` diubah menjadi optional
- PrintController akan menggunakan `event_id` dari user jika tidak ada di request

## Daftar File Lengkap untuk Upload

```
www/rpm/
└── app/
    └── Http/
        ├── Controllers/
        │   └── Rpc/
        │       ├── AuthController.php          ← UPLOAD (BARU)
        │       └── PrintController.php         ← UPLOAD (DIPERBAIKI)
        ├── Requests/
        │   └── Rpc/
        │       └── PrintPayloadRequest.php     ← UPLOAD (DIPERBAIKI)
        └── Resources/
            └── Rpc/
                └── LoginResource.php           ← UPLOAD (BARU)
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
   Pastikan tidak ada error "Call to a member function format() on string"

## Catatan Penting

- ✅ **HANYA** file di folder RPC yang diubah
- ✅ **TIDAK ADA** perubahan di `app/Models/Registration.php` atau file lain di luar folder RPC
- ✅ File-file dokumentasi (`.md`, `.sql`, `.sh`) **TIDAK PERLU** diupload ke server
- ✅ Hanya file PHP yang perlu diupload
- ✅ Pastikan permission dan ownership sudah benar setelah upload
- ✅ PrintController sudah handle `dob` dengan benar tanpa perlu mengubah model Registration













