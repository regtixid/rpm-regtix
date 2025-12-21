# API RPC (Race Pack Collection) Documentation

## Base URL
`https://regtix.id/api/rpc/v1`

## Authentication
Semua endpoint kecuali `/auth/login` memerlukan Bearer Token di header:
```
Authorization: Bearer {token}
```

## Endpoints

### 1. POST /auth/login
Login operator untuk mendapatkan token.

**Request:**
```json
{
  "email": "operator@example.com",
  "password": "password"
}
```

**Response Success (200):**
```json
{
  "success": true,
  "message": "Login berhasil.",
  "data": {
    "token": "1|abc123...",
    "user": {
      "id": 1,
      "name": "Operator Name",
      "email": "operator@example.com"
    }
  }
}
```

**Response Error (401):**
```json
{
  "success": false,
  "message": "Email atau password salah."
}
```

---

### 2. POST /tickets/scan
Scan dan verifikasi tiket peserta.

**Headers:**
```
Authorization: Bearer {token}
```

**Request:**
```json
{
  "ticket_code": "RTIX-KR-ABC123"
}
```

**Response Success (200):**
```json
{
  "success": true,
  "message": "Tiket ditemukan.",
  "data": {
    "participant_id": 123,
    "name": "John Doe",
    "registration_code": "RTIX-KR-ABC123",
    "ticket_category": "5K",
    "ticket_type": "Early Bird",
    "bib_number": "0001",
    "jersey_size": "L",
    "status": "NOT_VALIDATED",
    "event": {
      "id": 1,
      "name": "Keramas Run 2025"
    }
  }
}
```

**Response Error (404):**
```json
{
  "success": false,
  "message": "Tiket tidak ditemukan."
}
```

**Response Error (409):**
```json
{
  "success": false,
  "message": "Tiket sudah divalidasi."
}
```

---

### 3. POST /prints/payload
Ambil payload data untuk cetak (pickup_sheet atau power_of_attorney).

**Headers:**
```
Authorization: Bearer {token}
```

**Request (pickup_sheet):**
```json
{
  "print_type": "pickup_sheet",
  "participant_ids": [123],
  "event_id": 1
}
```

**Request (power_of_attorney):**
```json
{
  "print_type": "power_of_attorney",
  "participant_ids": [123, 124, 125],
  "event_id": 1,
  "representative_data": {
    "name": "Jane Doe",
    "ktp_number": "9876543210987654",
    "dob": "1985-05-15",
    "address": "Jl. Perwakilan No. 456",
    "phone": "081234567892",
    "relationship": "Teman"
  }
}
```

**Response Success (200):**
```json
{
  "success": true,
  "message": "Payload cetak berhasil diambil.",
  "data": {
    "print_type": "pickup_sheet",
    "participants": [
      {
        "id": 123,
        "name": "John Doe",
        "ktp_number": "1234567890123456",
        "dob": "1990-01-01",
        "address": "Jl. Contoh No. 123",
        "phone": "081234567890",
        "gender": "Male",
        "ticket_category": "5K",
        "ticket_type": "Early Bird",
        "bib_number": "0001",
        "jersey_size": "L",
        "registration_code": "RTIX-KR-ABC123",
        "status": "NOT_VALIDATED"
      }
    ],
    "representative": null,
    "metadata": {
      "generated_at": "2025-01-15T10:30:00+00:00",
      "operator_id": 1,
      "operator_name": "Operator Name",
      "event_id": 1,
      "event_name": "Keramas Run 2025"
    }
  }
}
```

---

### 4. GET /participants/search
Search peserta untuk keperluan validasi.

**Headers:**
```
Authorization: Bearer {token}
```

**Query Parameters:**
- `keyword` (required): Nama, registration_code, atau id_card_number
- `event_id` (required): ID event
- `status` (optional): `NOT_VALIDATED` atau `VALIDATED`

**Example:**
```
GET /api/rpc/v1/participants/search?keyword=John&event_id=1&status=NOT_VALIDATED
```

**Response Success (200):**
```json
{
  "success": true,
  "message": "Pencarian peserta berhasil.",
  "data": [
    {
      "id": 123,
      "name": "John Doe",
      "registration_code": "RTIX-KR-ABC123",
      "ticket_category": "5K",
      "ticket_type": "Early Bird",
      "bib_number": "0001",
      "jersey_size": "L",
      "status": "NOT_VALIDATED"
    }
  ]
}
```

---

### 5. POST /validate
Validasi pengambilan RPC (ubah status is_validated menjadi true).

**Headers:**
```
Authorization: Bearer {token}
```

**Request:**
```json
{
  "participant_id": 123,
  "note": "Optional note"
}
```

**Response Success (200):**
```json
{
  "success": true,
  "message": "Validasi berhasil.",
  "data": {
    "participant_id": 123,
    "status": "VALIDATED",
    "validated_at": "2025-01-15T10:30:00+00:00",
    "validated_by": {
      "id": 1,
      "name": "Operator Name"
    }
  }
}
```

**Response Error (404):**
```json
{
  "success": false,
  "message": "Peserta tidak ditemukan."
}
```

**Response Error (409):**
```json
{
  "success": false,
  "message": "Peserta sudah divalidasi."
}
```

---

## Error Handling

Semua error response mengikuti format:
```json
{
  "success": false,
  "message": "Error message"
}
```

**HTTP Status Codes:**
- `200`: Success
- `400`: Bad Request (validation error)
- `401`: Unauthorized (invalid token atau login failed)
- `404`: Not Found
- `409`: Conflict (sudah validated atau duplicate)
- `500`: Internal Server Error

---

## Catatan Penting

1. **Representative Data**: Data perwakilan disimpan di cache (tidak di database) dengan TTL 24 jam
2. **Atomic Validation**: Endpoint `/validate` menggunakan database transaction dengan row lock untuk mencegah double validate
3. **Status Field**: Hanya field `is_validated` yang diubah dari `false` ke `true`
4. **Tidak Ada Perubahan Database**: Tidak ada migration atau perubahan struktur database

---

## Deployment

1. Upload semua file baru ke server
2. Replace `bootstrap/app.php` dengan versi yang sudah di-update
3. Sistem langsung aktif (tidak perlu artisan command)

---

**Dibuat untuk**: Sistem RPC Regtix  
**Versi**: 1.0  
**Tanggal**: 2025



















