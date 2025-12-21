# Troubleshooting: Endpoint Mengembalikan HTML (404)

## Problem
Endpoint API mengembalikan HTML (halaman frontend) bukan JSON response.

## Penyebab
Web server (Nginx/Apache) tidak mengarahkan request `/api/rpc/v1/*` ke Laravel, melainkan ke frontend static files.

## Solusi

### 1. Cek Web Server Configuration

#### Untuk Nginx

Cek file config di `/etc/nginx/sites-enabled/` atau `/etc/nginx/conf.d/`:

```bash
# Cari file config untuk regtix.id
grep -r "regtix.id" /etc/nginx/sites-enabled/
cat /etc/nginx/sites-enabled/regtix*
```

**Pastikan config seperti ini:**

```nginx
server {
    listen 80;
    server_name regtix.id;
    root /var/www/rpm/public;  # Pastikan ini benar
    
    index index.php;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }
    
    # Pastikan semua /api/* diarahkan ke Laravel
    location /api {
        try_files $uri $uri/ /index.php?$query_string;
    }
}
```

**Jika ada location untuk frontend, pastikan tidak override /api:**

```nginx
# JANGAN seperti ini (salah):
location / {
    root /var/www/regtix/public;  # Frontend
    try_files $uri $uri/ /index.html;
}

# HARUS seperti ini (benar):
location / {
    root /var/www/rpm/public;  # Laravel public
    try_files $uri $uri/ /index.php?$query_string;
}

# Atau jika frontend di lokasi terpisah:
location / {
    root /var/www/rpm/public;
    try_files $uri $uri/ /index.php?$query_string;
}

location ~ ^/(assets|image|favico) {
    root /var/www/regtix/public;  # Static assets dari frontend
    try_files $uri =404;
}
```

#### Untuk Apache

Cek file `.htaccess` di `/var/www/rpm/public/.htaccess`:

```apache
<IfModule mod_rewrite.c>
    <IfModule mod_negotiation.c>
        Options -MultiViews -Indexes
    </IfModule>

    RewriteEngine On

    # Handle Authorization Header
    RewriteCond %{HTTP:Authorization} .
    RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]

    # Redirect Trailing Slashes If Not A Folder...
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_URI} (.+)/$
    RewriteRule ^ %1 [L,R=301]

    # Send Requests To Front Controller...
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [L]
</IfModule>
```

### 2. Test Route di Server

```bash
cd /var/www/rpm

# Test route langsung dari server
php artisan route:list | grep rpc

# Test dengan tinker
php artisan tinker
>>> Route::getRoutes()->getByName('rpc.tickets.scan');
```

### 3. Test Endpoint dari Server (Localhost)

```bash
# Test dari server sendiri
curl -X POST http://localhost/api/rpc/v1/tickets/scan \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer {token}" \
  -d '{"ticket_code":"RTIX-KR26-VVXD1H"}'
```

Jika ini berhasil, berarti masalahnya di web server config.

### 4. Cek Laravel Log

```bash
tail -f /var/www/rpm/storage/logs/laravel.log
```

Lalu coba akses endpoint lagi dari Postman, lihat apakah ada error di log.

### 5. Cek .htaccess atau Nginx Config

Pastikan semua request `/api/*` diarahkan ke `index.php` Laravel, bukan ke frontend static files.

### 6. Reload Web Server

Setelah update config:

```bash
# Untuk Nginx
nginx -t  # Test config
systemctl reload nginx

# Untuk Apache
apache2ctl configtest
systemctl reload apache2
```



















