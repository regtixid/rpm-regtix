# 🎟️ Analisis Bug Voucher Rp0 – Registrasi Tidak Tercatat

**Tanggal:** 2025-01-XX  
**File terkait:** `app/Http/Controllers/Api/RegistrationController.php`  
**Status:** 🔴 Critical – perlu perbaikan segera

---

## 1. Ringkasan Masalah

Ketika user memasukkan voucher dengan harga Rp0:
- Endpoint `/voucher/check` menampilkan harga akhir Rp0 (berarti kalkulasi voucher benar).
- Saat form disubmit, backend **tidak membuat registrasi baru**. Respons yang dikirim ke frontend adalah data registrasi lama yang masih `pending`.
- Frontend otomatis membuka ulang payment link Midtrans lama (dengan harga Rp222.222), sehingga user tetap diarahkan ke pembayaran.
- Di admin panel (`RPM menu Registrasi`) tidak muncul entri baru, voucher Rp0 tidak terpakai, dan status lama tetap `pending`.

**Kesimpulan:** Alur submit tidak pernah melewati logika “skip Midtrans dan kirim e-ticket”. Semua ini terjadi karena duplicate check di controller menghentikan proses sebelum registrasi baru dibuat.

---

## 2. Detail Teknis

### 2.1 Duplicate check terlalu agresif

```32:66:app/Http/Controllers/Api/RegistrationController.php
// ==== CEK REGISTRATION DUPLIKAT ====
$registran = Registration::where('email', $data['email'])
    ->where('category_ticket_type_id', $data['category_ticket_type_id'])
    ->where('id_card_number', $data['id_card_number'])
    ->where('status', 'pending')
    ->with([...])
    ->first();

if ($registran) {
    // langsung return data registrasi lama (termasuk payment_url lama)
    return response()->json([
        'message' => 'Registration already exists.',
        'data' => $dataResponse
    ], 409);
}
```

- Kondisi ini terpenuhi karena masih ada registrasi lama berstatus `pending` (harga Rp222.222).
- Backend **langsung berhenti** dan mengirim response 409 + payload registrasi lama.
- Frontend membaca field `payment_url` di payload tersebut dan membuka link Midtrans yang lama, sehingga user melihat harga Rp222.222 lagi.

### 2.2 Dampak langsung

| Gejala | Penyebab Teknik |
| --- | --- |
| Harga Rp0 di layar check voucher | Kalkulasi voucher berjalan benar |
| Setelah submit tetap diarahkan ke Midtrans Rp222.222 | Backend memulangkan payload registrasi lama karena duplikat pending |
| Tidak ada data baru di admin | Registrasi baru tidak pernah dibuat (blok 409 di atas) |
| Voucher Rp0 tidak terpakai | Karena registrasi baru tidak tercatat, voucher tidak pernah di-associate |

---

## 3. Solusi yang Disarankan

### 3.1 Opsi A – Izinkan override registrasi pending

1. Saat duplicate check menemukan registrasi pending:
   - Hapus / batalkan record pending lama **atau**
   - Update record lama dengan data baru (voucher, harga, dll) sebelum lanjut.
2. Setelah data lama dibersihkan, lanjutkan proses normal (buat registrasi baru atau reuse record).

Contoh pseudo:
```php
$registran = Registration::where(...)
    ->where('status', 'pending')
    ->first();

if ($registran) {
    $registran->delete(); // atau ubah status ke 'cancelled'
}

// lanjut buat registrasi baru dengan voucher Rp0
```

### 3.2 Opsi B – Cek status aktif (confirmed/paid) saja

- Ubah duplicate check menjadi hanya memblokir jika sudah **confirmed/paid**.
- Jika status masih pending, izinkan user membuat registrasi baru (dengan catatan pending lama dibersihkan otomatis atau manual).

```php
$registran = Registration::where(...)
    ->whereIn('status', ['confirmed', 'paid'])
    ->first();

if ($registran) {
    // block user karena sudah punya tiket valid
}

// else: buat registrasi baru walaupun ada pending lain
```

### 3.3 Opsi C – Endpoint khusus “lanjutkan pembayaran”

- Jika tujuan duplicate check adalah *melanjutkan pembayaran pending*, pisahkan alurnya.
- Buat endpoint `POST /registration/resume` yang hanya mengembalikan payment link lama.
- Endpoint `POST /registration/store` fokus untuk pendaftaran baru (tidak mengembalikan data lama).

---

## 4. Rekomendasi Implementasi

1. Tentukan kebijakan:
   - Apakah registrasi pending lama harus dihapus otomatis?
   - Apakah user boleh memiliki lebih dari satu registrasi pending?
2. Implementasi pilihan solusi (A, B, atau C) sesuai bisnis.
3. Tambahkan logging agar ketika duplicate terjadi diketahui tiket/voucher mana yang terlibat.
4. Setelah perbaikan, uji skenario:
   - Voucher Rp0 → seharusnya langsung skip Midtrans dan kirim e-ticket.
   - Voucher berbayar → tetap diarahkan ke Midtrans baru (bukan link lama).
   - Registrasi pending lama → pastikan tidak menghambat ketika ingin override.

---

## 5. Kesimpulan

Bug bukan pada kalkulasi voucher atau Midtrans, melainkan pada duplicate check yang memulangkan registrasi pending lama. Selama status pending belum dibersihkan, user tidak bisa mendaftar ulang dengan voucher berbeda, sehingga alur voucher gratis gagal total. Memperbaiki logika duplicate (atau menyediakan mekanisme override) akan membuat voucher Rp0 bekerja sesuai harapan.


















