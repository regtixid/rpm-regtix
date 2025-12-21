# Cara Check Event ID dan Event Name dari User

## User yang akan dicek:
- **Email**: operatorkr26@regtix.id
- **Password**: opekr26

## Opsi 1: Menggunakan Laravel Tinker (Recommended)

Jalankan di server atau lokal (jika database bisa diakses):

```bash
cd /var/www/rpm  # atau D:\REGTIX\www\rpm di Windows
php artisan tinker
```

Kemudian jalankan perintah berikut di Tinker:

```php
// Cek user
$user = \App\Models\User::where('email', 'operatorkr26@regtix.id')->first();
echo "User ID: " . $user->id . "\n";
echo "User Name: " . $user->name . "\n";
echo "Event ID: " . ($user->event_id ?? 'NULL') . "\n";

// Cek event berdasarkan event_id user
if ($user->event_id) {
    $event = \App\Models\Event::find($user->event_id);
    echo "Event ID: " . $event->id . "\n";
    echo "Event Name: " . $event->name . "\n";
    echo "Start Date: " . $event->start_date . "\n";
    
    if ($event->name === 'Sanga Sanga Run 2025') {
        echo "\n⚠️  MASALAH: Event name masih 'Sanga Sanga Run 2025'\n";
        echo "   Perlu diupdate menjadi 'Keramas Run 2026'\n";
    }
} else {
    echo "\n⚠️  User tidak memiliki event_id (NULL)\n";
    echo "   Frontend akan menggunakan fallback event_id = 1\n";
    
    $event = \App\Models\Event::find(1);
    if ($event) {
        echo "Event ID 1 (fallback): " . $event->name . "\n";
    }
}

// Tampilkan semua event
echo "\n=== SEMUA EVENT ===\n";
\App\Models\Event::all(['id', 'name'])->each(function($e) use ($user) {
    $marker = ($e->id == $user->event_id) ? " ← (digunakan)" : "";
    echo "ID: {$e->id} | Name: {$e->name}{$marker}\n";
});
```

## Opsi 2: Menggunakan SQL Langsung

Login ke database MySQL/MariaDB:

```bash
mysql -u [username] -p [database_name]
```

Kemudian jalankan query dari file `CHECK_USER_EVENT.sql`:

```sql
-- Cek user dan event_id-nya
SELECT 
    u.id as user_id,
    u.name as user_name,
    u.email,
    u.event_id,
    e.id as event_id_from_table,
    e.name as event_name,
    e.start_date,
    e.end_date
FROM users u
LEFT JOIN events e ON u.event_id = e.id
WHERE u.email = 'operatorkr26@regtix.id';

-- Tampilkan semua event
SELECT id, name as event_name, start_date, end_date
FROM events
ORDER BY id;

-- Cek event dengan nama yang mengandung Sanga atau Keramas
SELECT id, name as event_name
FROM events
WHERE name LIKE '%Sanga%' OR name LIKE '%Keramas%'
ORDER BY id;
```

## Opsi 3: Menggunakan API Endpoint (jika sudah ada)

Test login dan lihat response:

```bash
curl -X POST https://rpm.regtix.id/api/rpc/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "operatorkr26@regtix.id",
    "password": "opekr26"
  }'
```

Response akan berisi `event_id` yang digunakan user tersebut.

## Setelah Mengetahui Event ID

Jika event name masih "Sanga Sanga Run 2025", update dengan:

```sql
UPDATE events 
SET name = 'Keramas Run 2026'
WHERE id = [EVENT_ID_YANG_DITEMUKAN];
```

atau via Tinker:

```php
\App\Models\Event::where('id', [EVENT_ID])->update(['name' => 'Keramas Run 2026']);
```













