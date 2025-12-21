# Fix Apache Configuration untuk API RPC

## Problem
Apache mengembalikan 301 redirect atau HTML instead of JSON.

## Langkah Perbaikan

### 1. Cek Apache Virtual Host Config

```bash
# Cari file config untuk regtix.id
ls -la /etc/apache2/sites-enabled/
cat /etc/apache2/sites-enabled/* | grep -A 20 regtix
```

### 2. Cek Document Root

Pastikan DocumentRoot mengarah ke Laravel public folder:

```bash
grep -r "DocumentRoot" /etc/apache2/sites-enabled/
```

**Harus seperti ini:**
```apache
DocumentRoot /var/www/rpm/public
```

### 3. Cek .htaccess di public folder

```bash
cat /var/www/rpm/public/.htaccess
```

**Harus ada:**
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

### 4. Test dengan HTTPS

Karena ada redirect ke HTTPS, coba test dengan HTTPS:

```bash
curl -X POST https://regtix.id/api/rpc/v1/tickets/scan \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer {token}" \
  -d '{"ticket_code":"RTIX-KR26-VVXD1H"}'
```

### 5. Cek mod_rewrite enabled

```bash
a2enmod rewrite
systemctl restart apache2
```



















