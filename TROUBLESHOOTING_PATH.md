# Troubleshooting: Mencari Lokasi Project di Server

## Problem
Direktori `/var/www/regtix/www/rpm` tidak ditemukan.

## Solusi: Cari Lokasi Project yang Benar

### Step 1: Cari File artisan

File `artisan` adalah file utama Laravel, jadi cari file ini untuk menemukan lokasi project:

```bash
# Cari file artisan di seluruh sistem (mungkin butuh waktu)
find / -name "artisan" -type f 2>/dev/null

# Atau cari di lokasi umum
find /var/www -name "artisan" -type f 2>/dev/null
find /home -name "artisan" -type f 2>/dev/null
find /opt -name "artisan" -type f 2>/dev/null
```

### Step 2: Cari Folder rpm atau regtix

```bash
# Cari folder rpm
find /var/www -type d -name "rpm" 2>/dev/null
find /home -type d -name "rpm" 2>/dev/null

# Cari folder regtix
find /var/www -type d -name "regtix" 2>/dev/null
find /home -type d -name "regtix" 2>/dev/null
```

### Step 3: Cek Lokasi Umum

Coba lokasi-lokasi umum berikut:

```bash
# Lokasi umum 1
cd /var/www/html/rpm
php artisan route:list | grep rpc

# Lokasi umum 2
cd /home/regtix/www/rpm
php artisan route:list | grep rpc

# Lokasi umum 3
cd /var/www/regtix/rpm
php artisan route:list | grep rpc

# Lokasi umum 4
cd /home/www/regtix/rpm
php artisan route:list | grep rpc
```

### Step 4: Cek Web Server Configuration

Cek konfigurasi web server (Nginx/Apache) untuk melihat document root:

```bash
# Cek Nginx
cat /etc/nginx/sites-enabled/* | grep root

# Cek Apache
cat /etc/apache2/sites-enabled/* | grep DocumentRoot
```

### Step 5: Cek dari Domain

Jika tahu domain yang digunakan (misalnya regtix.id), cek konfigurasi:

```bash
# Cek Nginx config untuk domain
grep -r "regtix" /etc/nginx/sites-enabled/

# Atau
ls -la /etc/nginx/sites-enabled/
cat /etc/nginx/sites-enabled/regtix*
```

## Setelah Menemukan Lokasi

Setelah menemukan lokasi project yang benar, update path di semua command:

```bash
# Contoh jika ditemukan di /var/www/html/rpm
cd /var/www/html/rpm
php artisan route:list | grep rpc
```

## Alternatif: Cari via WinSCP

Jika menggunakan WinSCP:

1. Buka WinSCP
2. Login ke server
3. Di panel Remote, gunakan **Search** (Ctrl+F)
4. Cari file: `artisan`
5. Setelah ditemukan, catat path lengkapnya

## Quick Check Commands

Jalankan command berikut untuk quick check:

```bash
# Cek di current directory dan subdirectories
ls -la
find . -name "artisan" -type f 2>/dev/null

# Cek di /var/www
ls -la /var/www/
ls -la /var/www/html/

# Cek di home directory user
ls -la ~/
ls -la ~/www/
```

Setelah menemukan lokasi yang benar, lanjutkan deployment sesuai panduan dengan path yang benar.



















