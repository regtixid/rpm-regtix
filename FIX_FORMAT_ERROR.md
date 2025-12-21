# Fix Error: Call to a member function format() on string

## Masalah
Error "Call to a member function format() on string" terjadi karena `$registration->dob` mungkin sudah berupa string, bukan Carbon/DateTime object.

## Perbaikan yang Sudah Dilakukan

### 1. PrintController.php
- ✅ Menambahkan pengecekan apakah `dob` sudah string atau masih Carbon object
- ✅ Handle kedua kasus dengan benar

### 2. Registration.php
- ✅ Menambahkan cast untuk `dob` sebagai `date` agar otomatis menjadi Carbon instance

## File yang Perlu Diupload

### 1. PrintController.php (DIPERBAIKI)
**Path:** `app/Http/Controllers/Rpc/PrintController.php`
- Menambahkan handling untuk `dob` yang bisa berupa string atau Carbon object

### 2. Registration.php (DIPERBAIKI)
**Path:** `app/Models/Registration.php`
- Menambahkan `casts()` method untuk cast `dob` sebagai date

## Cara Upload

1. **Upload PrintController.php:**
   - Local: `D:\REGTIX\www\rpm\app\Http\Controllers\Rpc\PrintController.php`
   - Server: `/var/www/rpm/app/Http/Controllers/Rpc/PrintController.php`

2. **Upload Registration.php:**
   - Local: `D:\REGTIX\www\rpm\app\Models\Registration.php`
   - Server: `/var/www/rpm/app/Models/Registration.php`

3. **Set permission:**
   ```bash
   sudo chown -R www-data:www-data /var/www/rpm/app/
   sudo chmod -R 644 /var/www/rpm/app/**/*.php
   ```

4. **Clear cache (optional, tapi recommended):**
   ```bash
   cd /var/www/rpm
   php artisan cache:clear
   ```

## Verifikasi

Setelah upload, test print lagi. Error "Call to a member function format() on string" seharusnya sudah teratasi.













