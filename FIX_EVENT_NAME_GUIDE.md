# Panduan Fix Event Name di Database

## Masalah
Event name yang muncul di print adalah "Sanga Sanga Run 2025" padahal seharusnya "Keramas Run 2026".

## Penyebab
Backend API mengambil `event_name` dari database tabel `events` berdasarkan `event_id` yang dikirim dari frontend. Jika di database nama event masih "Sanga Sanga Run 2025", maka itu yang akan muncul.

## Solusi

### Opsi 1: Update via SQL (Recommended)

1. **Login ke database MySQL/MariaDB**:
```bash
mysql -u [username] -p [database_name]
```

2. **Cek event yang ada**:
```sql
SELECT id, name, start_date, end_date FROM events ORDER BY id;
```

3. **Cek event_id dari user yang digunakan**:
```sql
SELECT u.id, u.name, u.email, u.event_id, e.name as event_name 
FROM users u 
LEFT JOIN events e ON u.event_id = e.id 
WHERE u.email = '[EMAIL_OPERATOR_YANG_DIGUNAKAN]';
```

4. **Update nama event**:
```sql
-- Update berdasarkan nama yang salah
UPDATE events 
SET name = 'Keramas Run 2026'
WHERE name = 'Sanga Sanga Run 2025';

-- ATAU update berdasarkan event_id tertentu
UPDATE events 
SET name = 'Keramas Run 2026'
WHERE id = [EVENT_ID_YANG_BENAR];
```

5. **Verifikasi**:
```sql
SELECT id, name FROM events WHERE name LIKE '%Keramas%' OR name LIKE '%Sanga%';
```

### Opsi 2: Update via Laravel Tinker

```bash
cd www/rpm
php artisan tinker
```

```php
// Cek event yang ada
\App\Models\Event::all(['id', 'name']);

// Update nama event
\App\Models\Event::where('name', 'Sanga Sanga Run 2025')
    ->update(['name' => 'Keramas Run 2026']);

// Verifikasi
\App\Models\Event::where('name', 'LIKE', '%Keramas%')->get(['id', 'name']);
```

### Opsi 3: Update via Filament Admin Panel

1. Login ke admin panel Filament
2. Buka menu **Events**
3. Cari event dengan nama "Sanga Sanga Run 2025"
4. Edit dan ubah nama menjadi "Keramas Run 2026"
5. Save

## Verifikasi Setelah Update

1. **Test dari frontend**:
   - Login ke RPC System
   - Print pickup sheet untuk peserta
   - Pastikan event name yang muncul adalah "Keramas Run 2026"

2. **Test langsung dari API** (jika perlu):
```bash
curl -X POST https://rpm.regtix.id/api/rpc/v1/prints/payload \
  -H "Authorization: Bearer [TOKEN]" \
  -H "Content-Type: application/json" \
  -d '{
    "print_type": "pickup_sheet",
    "participant_ids": [1],
    "event_id": [EVENT_ID]
  }'
```

## Catatan Penting

- Pastikan `event_id` yang digunakan di frontend (`user.event_id`) mengarah ke event yang benar
- Jika ada beberapa event dengan nama yang salah, update semua
- Backup database sebelum melakukan update (jika production)













