# Debug Error 500 di /api/rpc/v1/prints/payload

## Error yang Terjadi
```
rpm.regtix.id/api/rpc/v1/prints/payload:1 Failed to load resource: the server responded with a status of 500 ()
```

## Perbaikan yang Sudah Dilakukan

### 1. PrintController.php
- ✅ Menambahkan null safety operator (`?->`) untuk `categoryTicketType`
- ✅ Menambahkan try-catch untuk menangkap semua error
- ✅ Menambahkan logging untuk debugging
- ✅ Memberikan error message yang lebih jelas

## Cara Debug Error 500

### 1. Cek Laravel Log
```bash
# SSH ke server
ssh user@server

# Cek log Laravel
tail -50 /var/www/rpm/storage/logs/laravel.log

# Atau cek log terbaru
tail -f /var/www/rpm/storage/logs/laravel.log
```

### 2. Cek Apache Error Log
```bash
# Cek error log Apache
tail -50 /var/log/apache2/error.log

# Atau cek error log khusus untuk RPM
tail -50 /var/log/apache2/rpm_error.log
```

### 3. Test API Langsung dari Server
```bash
# Login dulu untuk dapatkan token
curl -X POST https://rpm.regtix.id/api/rpc/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "operatorkr26@regtix.id",
    "password": "opekr26"
  }'

# Setelah dapat token, test print payload dengan verbose
curl -v -X POST https://rpm.regtix.id/api/rpc/v1/prints/payload \
  -H "Authorization: Bearer [TOKEN]" \
  -H "Content-Type: application/json" \
  -d '{
    "print_type": "pickup_sheet",
    "participant_ids": [1]
  }'
```

### 4. Cek Response Error Detail di Browser
1. Buka **Developer Tools** (F12)
2. Buka tab **Network**
3. Cari request ke `/api/rpc/v1/prints/payload`
4. Klik request tersebut
5. Buka tab **Response** untuk melihat error message detail
6. Buka tab **Headers** untuk melihat status code dan headers

## Kemungkinan Penyebab Error 500

### 1. Error di PrintController
- **Penyebab**: Null pointer saat mengakses relasi
- **Solusi**: Sudah diperbaiki dengan null safety operator (`?->`)

### 2. Error di PrintPayloadResource
- **Penyebab**: Property tidak ada di object
- **Solusi**: Pastikan semua property ada di `$payloadData`

### 3. Error Database Connection
- **Penyebab**: Database tidak bisa diakses
- **Solusi**: Cek koneksi database di `.env`

### 4. Error Missing Relationship
- **Penyebab**: `categoryTicketType` atau relasinya tidak ada
- **Solusi**: Pastikan data participant memiliki relasi yang lengkap

### 5. Error di PrintPayloadRequest Validation
- **Penyebab**: Request tidak valid
- **Solusi**: Cek apakah semua field yang required sudah dikirim

## File yang Perlu Diupload (Update)

### PrintController.php (DIPERBAIKI LAGI)
**Path:** `app/Http/Controllers/Rpc/PrintController.php`
- Menambahkan null safety operator untuk `categoryTicketType`
- Menambahkan try-catch untuk error handling
- Menambahkan logging untuk debugging

## Langkah Perbaikan

1. **Upload PrintController.php yang sudah diperbaiki:**
   ```bash
   # Upload file ke server
   # Local: D:\REGTIX\www\rpm\app\Http\Controllers\Rpc\PrintController.php
   # Server: /var/www/rpm/app/Http/Controllers/Rpc/PrintController.php
   ```

2. **Set permission:**
   ```bash
   sudo chown -R www-data:www-data /var/www/rpm/app/Http/Controllers/Rpc/
   sudo chmod -R 644 /var/www/rpm/app/Http/Controllers/Rpc/*.php
   ```

3. **Cek log setelah test:**
   ```bash
   tail -50 /var/www/rpm/storage/logs/laravel.log
   ```

4. **Test lagi dari browser:**
   - Buka aplikasi RPC
   - Login
   - Scan ticket dan print
   - Cek apakah error masih terjadi

## Informasi yang Dibutuhkan untuk Debug Lebih Lanjut

Jika error masih terjadi setelah upload file yang diperbaiki, kirimkan:

1. **Error message dari Laravel log:**
   ```bash
   tail -100 /var/www/rpm/storage/logs/laravel.log | grep -A 20 "PrintController"
   ```

2. **Response body dari Network tab di browser:**
   - Buka Developer Tools > Network
   - Klik request yang error
   - Copy response body

3. **Request payload yang dikirim:**
   - Buka Developer Tools > Network
   - Klik request yang error
   - Copy request payload

4. **Stack trace dari error log:**
   ```bash
   tail -200 /var/www/rpm/storage/logs/laravel.log
   ```













