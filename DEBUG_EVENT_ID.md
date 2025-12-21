# Debug Event ID dan Event Name

## Masalah
Event name yang muncul di print adalah "Sanga Sanga Run 2025" padahal seharusnya "Keramas Run 2026".

## User yang dicek:
- **Email**: operatorkr26@regtix.id
- **Password**: opekr26

## Perbaikan yang sudah dilakukan:

### 1. AuthController.php
- ✅ Dibuat implementasi login yang mengembalikan `event_id` dari user
- ✅ Menggunakan Sanctum untuk authentication token

### 2. LoginResource.php
- ✅ Dibuat resource yang mengembalikan user data dengan `event_id`

### 3. PrintController.php
- ✅ Menggunakan `event_id` dari user yang login jika tidak ada di request
- ✅ Validasi bahwa `event_id` yang digunakan sesuai dengan otoritas user
- ✅ Mengambil `event_name` dari database Event berdasarkan `event_id`

### 4. PrintPayloadRequest.php
- ✅ `event_id` dibuat optional (sometimes, nullable)
- ✅ PrintController akan menggunakan `event_id` dari user jika tidak ada di request

## Cara Debug:

### 1. Cek event_id dari user setelah login:

**Via Browser Console (setelah login):**
```javascript
// Cek user data yang disimpan di localStorage
const user = JSON.parse(localStorage.getItem('rpc_user'));
console.log('User Event ID:', user.event_id);
```

**Via API Test:**
```bash
# Login dan lihat response
curl -X POST https://rpm.regtix.id/api/rpc/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "operatorkr26@regtix.id",
    "password": "opekr26"
  }'

# Response akan berisi:
# {
#   "success": true,
#   "data": {
#     "token": "...",
#     "user": {
#       "id": ...,
#       "name": "...",
#       "email": "operatorkr26@regtix.id",
#       "event_id": [CEK_INI]
#     }
#   }
# }
```

### 2. Cek event_name yang dikembalikan oleh API prints/payload:

**Via Browser Network Tab:**
1. Buka browser DevTools (F12)
2. Buka tab Network
3. Login ke RPC System
4. Print pickup sheet untuk peserta
5. Cari request ke `/api/rpc/v1/prints/payload`
6. Lihat response, cek `data.metadata.event_name`

**Via API Test:**
```bash
# Setelah login, dapatkan token
TOKEN="[TOKEN_DARI_LOGIN]"

# Test prints/payload endpoint
curl -X POST https://rpm.regtix.id/api/rpc/v1/prints/payload \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "print_type": "pickup_sheet",
    "participant_ids": [1],
    "event_id": null
  }'

# Response akan berisi:
# {
#   "success": true,
#   "data": {
#     "metadata": {
#       "event_id": [CEK_INI],
#       "event_name": "[CEK_INI]"
#     }
#   }
# }
```

### 3. Cek di database:

```sql
-- Cek user dan event_id-nya
SELECT u.id, u.name, u.email, u.event_id, e.name as event_name
FROM users u
LEFT JOIN events e ON u.event_id = e.id
WHERE u.email = 'operatorkr26@regtix.id';

-- Cek semua event
SELECT id, name FROM events ORDER BY id;
```

## Kemungkinan Masalah:

1. **User tidak memiliki event_id di database**
   - Solusi: Update user di database untuk menambahkan event_id yang benar

2. **Event dengan event_id user masih bernama "Sanga Sanga Run 2025"**
   - Solusi: Update nama event di database menjadi "Keramas Run 2026"

3. **Frontend mengirim event_id yang salah**
   - Solusi: Pastikan frontend menggunakan `user.event_id` dari response login, bukan hardcoded

4. **Frontend menggunakan fallback event_id = 1**
   - Solusi: Pastikan user memiliki event_id di database, atau update event dengan ID 1

## Langkah Perbaikan:

1. **Cek event_id user di database:**
```sql
SELECT id, name, email, event_id FROM users WHERE email = 'operatorkr26@regtix.id';
```

2. **Cek event dengan event_id tersebut:**
```sql
SELECT id, name FROM events WHERE id = [EVENT_ID_DARI_USER];
```

3. **Jika event name masih salah, update:**
```sql
UPDATE events SET name = 'Keramas Run 2026' WHERE id = [EVENT_ID];
```

4. **Jika user tidak memiliki event_id, update user:**
```sql
UPDATE users SET event_id = [EVENT_ID_KERAMAS_RUN_2026] WHERE email = 'operatorkr26@regtix.id';
```

5. **Test ulang:**
   - Login ulang di frontend
   - Print pickup sheet
   - Pastikan event name sudah benar













