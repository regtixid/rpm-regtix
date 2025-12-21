# 📋 Laporan Bug - Sistem Voucher

**Tanggal Laporan:** 2025-01-XX  
**Versi Sistem:** -  
**Status:** 🔴 Critical Issues Found  
**Total Bug:** 8 (3 Critical, 2 High, 3 Medium)

---

## 📑 Daftar Isi

- [Ringkasan Eksekutif](#ringkasan-eksekutif)
- [Daftar Bug](#daftar-bug)
  - [🔴 Critical Priority](#-critical-priority)
  - [🟠 High Priority](#-high-priority)
  - [🟡 Medium Priority](#-medium-priority)
- [Rekomendasi Perbaikan](#rekomendasi-perbaikan)
- [Lampiran](#lampiran)

---

## 📊 Ringkasan Eksekutif

### Overview

Laporan ini mengidentifikasi **8 bug kritis** dalam sistem voucher yang dapat menyebabkan:
- ❌ Voucher gratis tidak terdeteksi valid
- ❌ Voucher multiple use tidak berfungsi setelah pembayaran pertama
- ❌ Voucher bisa digunakan untuk tiket yang salah
- ❌ Race condition menyebabkan voucher digunakan melebihi limit
- ❌ Data inconsistency dan potensi kerugian finansial

### Statistik Bug

| Prioritas | Jumlah | Persentase |
|-----------|--------|------------|
| 🔴 Critical | 3 | 37.5% |
| 🟠 High | 2 | 25% |
| 🟡 Medium | 3 | 37.5% |
| **Total** | **8** | **100%** |

### File yang Terpengaruh

1. `app/Http/Controllers/Api/RegistrationController.php` - 6 bug
2. `app/Http/Controllers/Webhook/MidtransWebhookController.php` - 1 bug
3. `app/Http/Controllers/Api/VoucherController.php` - 1 bug (inconsistency)

---

## 🐛 Daftar Bug

---

## 🔴 Critical Priority

### Bug #1: Multiple Use Voucher Menghitung Pending Registrations

**ID Bug:** VCH-001  
**Prioritas:** 🔴 CRITICAL  
**Severity:** High  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 89-96

#### 📝 Deskripsi

Sistem menghitung **semua registrations** yang menggunakan voucher tanpa memfilter berdasarkan status. Registrations dengan status `pending` (belum dibayar) ikut terhitung, sehingga voucher multiple use bisa dianggap sudah mencapai limit meskipun banyak yang masih pending.

#### 💻 Kode yang Bermasalah

```89:96:app/Http/Controllers/Api/RegistrationController.php
// ==== Hitung penggunaan voucher sebelum registration dibuat ====
$usedCount = $voucherCode->registrations()->count();

if ($voucher->is_multiple_use) {
    $voucherValid = $usedCount < $voucher->max_usage;
} else {
    $voucherValid = !$voucherCode->used && !$voucherCode->registration;
}
```

**Masalah:**
- `registrations()->count()` tidak memfilter berdasarkan status
- Menghitung registrations `pending`, `confirmed`, `paid`, dan `cancel` secara bersamaan
- Tidak membedakan registrations yang sudah benar-benar terpakai vs yang masih pending

#### ⚠️ Dampak

1. **Voucher Gratis Tidak Terdeteksi Valid**
   - Voucher dengan `final_price = 0` dan `max_usage = 10`
   - Jika ada 10 registrations pending, voucher dianggap sudah habis
   - Padahal seharusnya langsung confirmed tanpa payment

2. **Voucher Multiple Use Dianggap Habis Prematur**
   - Voucher dengan `max_usage = 10`
   - 5 registrations `pending` + 5 `confirmed` = 10 total
   - Sistem menganggap voucher sudah habis, padahal hanya 5 yang terpakai

3. **User Experience Buruk**
   - User mendapat error "Voucher sudah digunakan" meskipun voucher masih valid
   - Menyebabkan frustrasi dan kemungkinan kehilangan customer

#### 📊 Contoh Skenario

**Skenario 1: Voucher Gratis**
```
Voucher: OTWGFQ6KVD
- max_usage: 10
- final_price: 0 (gratis)
- Status: Multiple use

Situasi:
- 8 registrations dengan status 'pending' (belum dibayar)
- 2 registrations dengan status 'confirmed'

Hasil:
- usedCount = 10 (semua terhitung)
- voucherValid = false (10 < 10 = false)
- finalPrice = harga normal tiket (bukan 0)
- ❌ Voucher gratis tidak terdeteksi!
```

**Skenario 2: Voucher Berbayar**
```
Voucher: DISKON50
- max_usage: 5
- final_price: 50000

Situasi:
- 3 registrations 'pending'
- 2 registrations 'confirmed'

Hasil:
- usedCount = 5
- voucherValid = false
- ❌ Voucher dianggap habis padahal masih bisa digunakan 3x
```

#### ✅ Solusi yang Disarankan

**Opsi 1: Filter Berdasarkan Status (Recommended)**
```php
// Hitung hanya registrations yang sudah confirmed/paid
$usedCount = $voucherCode->registrations()
    ->where(function($query) {
        $query->whereIn('status', ['confirmed', 'paid'])
              ->orWhere('payment_status', 'paid');
    })
    ->count();
```

**Opsi 2: Filter Lebih Spesifik**
```php
$usedCount = $voucherCode->registrations()
    ->where('status', 'confirmed')
    ->where('payment_status', 'paid')
    ->count();
```

**Opsi 3: Gunakan Scope di Model (Best Practice)**
```php
// Di VoucherCode model
public function confirmedRegistrations()
{
    return $this->registrations()
        ->where('status', 'confirmed')
        ->where('payment_status', 'paid');
}

// Di Controller
$usedCount = $voucherCode->confirmedRegistrations()->count();
```

#### 🔗 Related Issues

- Bug #4: Race Condition (juga terkait dengan counting)
- Bug #5: Single Use Validasi (logika serupa)

---

### Bug #2: Tidak Validasi Voucher untuk category_ticket_type_id

**ID Bug:** VCH-002  
**Prioritas:** 🔴 CRITICAL  
**Severity:** High  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 74-101

#### 📝 Deskripsi

Sistem tidak memvalidasi apakah voucher berlaku untuk `category_ticket_type_id` yang digunakan. Voucher yang dibuat untuk tiket tertentu bisa digunakan untuk tiket lain, menyebabkan diskon tidak sesuai dan potensi kerugian finansial.

#### 💻 Kode yang Bermasalah

```74:101:app/Http/Controllers/Api/RegistrationController.php
if (!empty($data['voucher_code'])) {
    $voucherCode = VoucherCode::where('code', $data['voucher_code'])
        ->with('voucher')
        ->first();

    if (!$voucherCode) {
        return response()->json(['message' => 'Voucher code not found.'], 404);
    }

    $voucher = $voucherCode->voucher;

    if (!$voucher) {
        return response()->json(['message' => 'Voucher data invalid.'], 404);
    }

    // ==== Hitung penggunaan voucher sebelum registration dibuat ====
    $usedCount = $voucherCode->registrations()->count();
    
    // ❌ TIDAK ADA VALIDASI category_ticket_type_id
}
```

**Masalah:**
- Query hanya mencari berdasarkan `code`, tidak memfilter `category_ticket_type_id`
- Tidak ada pengecekan apakah `$voucher->category_ticket_type_id` sama dengan `$data['category_ticket_type_id']`
- Voucher untuk tiket A bisa digunakan untuk tiket B

#### ⚠️ Dampak

1. **Kerugian Finansial**
   - Voucher diskon 50% untuk tiket Early Bird (Rp 100.000) bisa digunakan untuk tiket Regular (Rp 200.000)
   - Seharusnya diskon Rp 50.000, tetapi bisa diskon Rp 100.000

2. **Data Inconsistency**
   - Voucher yang seharusnya hanya untuk kategori tertentu bisa digunakan di kategori lain
   - Laporan dan analisis data menjadi tidak akurat

3. **Security Issue**
   - User bisa exploit dengan menggunakan voucher untuk tiket yang lebih mahal
   - Tidak ada validasi business rule

#### 📊 Contoh Skenario

**Skenario: Voucher Diskon untuk Early Bird**
```
Voucher: EARLY50
- category_ticket_type_id: 10 (Early Bird)
- final_price: 50000
- Harga normal Early Bird: 100000

User mencoba menggunakan untuk:
- category_ticket_type_id: 20 (Regular)
- Harga normal Regular: 200000

Hasil:
- ✅ Voucher ditemukan
- ❌ Tidak ada validasi category_ticket_type_id
- ✅ Voucher digunakan untuk Regular
- 💰 User mendapat diskon untuk tiket yang lebih mahal!
```

#### 🔍 Perbandingan dengan VoucherController

Di `VoucherController.php` (endpoint check voucher), sudah ada validasi:

```php
$voucherCode = VoucherCode::with([...])
    ->where('code', $request->code)
    ->whereHas('voucher.categoryTicketType', function ($query) use ($request) {
        $query->where('id', $request->category_ticket_type_id);
    })
    ->first();
```

Tetapi di `RegistrationController.php` tidak ada validasi ini, menyebabkan inconsistency.

#### ✅ Solusi yang Disarankan

**Opsi 1: Validasi Setelah Fetch (Simple)**
```php
$voucher = $voucherCode->voucher;

if (!$voucher) {
    return response()->json(['message' => 'Voucher data invalid.'], 404);
}

// Validasi category_ticket_type_id
if ($voucher->category_ticket_type_id != $data['category_ticket_type_id']) {
    return response()->json([
        'message' => 'Voucher code tidak berlaku untuk tiket ini.',
        'error' => 'INVALID_CATEGORY'
    ], 400);
}
```

**Opsi 2: Validasi di Query (Recommended)**
```php
$voucherCode = VoucherCode::where('code', $data['voucher_code'])
    ->whereHas('voucher.categoryTicketType', function ($query) use ($data) {
        $query->where('id', $data['category_ticket_type_id']);
    })
    ->with('voucher')
    ->first();

if (!$voucherCode) {
    return response()->json([
        'message' => 'Voucher code tidak ditemukan atau tidak berlaku untuk tiket ini.'
    ], 404);
}
```

**Opsi 3: Buat Helper Function (Best Practice)**
```php
// Di BaseController atau Helper class
protected function validateVoucherCode($code, $categoryTicketTypeId)
{
    return VoucherCode::where('code', $code)
        ->whereHas('voucher.categoryTicketType', function ($query) use ($categoryTicketTypeId) {
            $query->where('id', $categoryTicketTypeId);
        })
        ->with('voucher')
        ->first();
}

// Di Controller
$voucherCode = $this->validateVoucherCode($data['voucher_code'], $data['category_ticket_type_id']);
```

#### 🔗 Related Issues

- Bug #7: Inconsistency dengan VoucherController

---

### Bug #3: Webhook Mark Semua Voucher sebagai Used

**ID Bug:** VCH-003  
**Prioritas:** 🔴 CRITICAL  
**Severity:** Critical  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Webhook/MidtransWebhookController.php`  
**Method:** `updatePaymentStatus()`  
**Baris:** 97-101

#### 📝 Deskripsi

Webhook Midtrans selalu menandai semua voucher sebagai `used = true` setelah pembayaran berhasil, termasuk voucher multiple use. Ini menyebabkan voucher multiple use tidak bisa digunakan lagi setelah pembayaran pertama, padahal seharusnya bisa digunakan hingga mencapai `max_usage`.

#### 💻 Kode yang Bermasalah

```97:101:app/Http/Controllers/Webhook/MidtransWebhookController.php
if ($registration->voucherCode) {
    $registration->voucherCode->update([
        'used' => true
    ]);
}
```

**Masalah:**
- Tidak ada pengecekan apakah voucher multiple use atau single use
- Semua voucher langsung di-mark `used = true`
- Multiple use voucher seharusnya tidak di-mark `used`

#### ⚠️ Dampak

1. **Multiple Use Voucher Tidak Berfungsi**
   - Voucher dengan `max_usage = 10` hanya bisa digunakan 1x
   - Setelah pembayaran pertama, voucher langsung di-mark `used = true`
   - 9 penggunaan lainnya tidak bisa digunakan

2. **Business Logic Error**
   - Sistem voucher multiple use menjadi tidak berfungsi sama sekali
   - Fitur yang seharusnya tersedia menjadi tidak bisa digunakan

3. **User Experience Buruk**
   - User yang membeli voucher multiple use tidak bisa menggunakannya untuk registration berikutnya
   - Menyebabkan komplain dan refund request

#### 📊 Contoh Skenario

**Skenario: Voucher Multiple Use**
```
Voucher: GROUP10
- is_multiple_use: true
- max_usage: 10
- final_price: 0 (gratis untuk grup)

Penggunaan:
1. Registration #1 menggunakan voucher → Payment success
   - Webhook: used = true ❌
   - Seharusnya: used tetap false

2. Registration #2 mencoba menggunakan voucher
   - Validasi: !$voucherCode->used = false ❌
   - Hasil: Voucher dianggap sudah digunakan
   - ❌ Tidak bisa digunakan padahal masih 9 slot tersedia
```

#### ✅ Solusi yang Disarankan

**Perbaiki dengan Cek is_multiple_use:**
```php
if ($registration->voucherCode) {
    $voucher = $registration->voucherCode->voucher;
    
    // Hanya mark used untuk single use voucher
    if ($voucher && !$voucher->is_multiple_use) {
        $registration->voucherCode->update([
            'used' => true
        ]);
    }
    // Multiple use voucher tidak perlu di-mark used
    // Penggunaan dihitung berdasarkan jumlah registrations
}
```

**Atau dengan validasi lebih ketat:**
```php
if ($registration->voucherCode) {
    $voucherCode = $registration->voucherCode;
    $voucher = $voucherCode->voucher;
    
    if ($voucher) {
        // Single use: mark as used
        if (!$voucher->is_multiple_use) {
            $voucherCode->update(['used' => true]);
        }
        // Multiple use: tidak perlu update, usage dihitung dari registrations
    }
}
```

#### 🔗 Related Issues

- Bug #1: Multiple use counting (logika terkait)
- Bug #5: Single use validasi (logika terkait)

---

## 🟠 High Priority

### Bug #4: Race Condition untuk Multiple Use Voucher

**ID Bug:** VCH-004  
**Prioritas:** 🟠 HIGH  
**Severity:** Medium-High  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 89-132

#### 📝 Deskripsi

Tidak ada mekanisme locking atau transaction saat validasi dan assign voucher. Jika dua request simultan menggunakan voucher yang sama dengan `max_usage` tersisa 1, keduanya bisa lolos validasi dan keduanya di-assign, menyebabkan voucher digunakan melebihi limit.

#### 💻 Kode yang Bermasalah

```89:132:app/Http/Controllers/Api/RegistrationController.php
// ==== Hitung penggunaan voucher sebelum registration dibuat ====
$usedCount = $voucherCode->registrations()->count();

if ($voucher->is_multiple_use) {
    $voucherValid = $usedCount < $voucher->max_usage;
} else {
    $voucherValid = !$voucherCode->used && !$voucherCode->registration;
}

if (!$voucherValid) {
    return response()->json(['message' => 'Voucher code already used or expired.'], 400);
}

// ... CREATE REGISTRATION ...

// Assign voucher ke registration (setelah semua valid)
if ($voucherValid && $voucherCode) {
    $registration->voucher_code_id = $voucherCode->id;
    $registration->save();
}
```

**Masalah:**
- Tidak ada database transaction
- Tidak ada row locking
- Validasi dan assignment tidak atomic
- Race condition bisa terjadi

#### ⚠️ Dampak

1. **Voucher Melebihi Limit**
   - Voucher dengan `max_usage = 10` bisa digunakan 11x atau lebih
   - Terjadi jika ada multiple concurrent requests

2. **Data Inconsistency**
   - Jumlah penggunaan voucher tidak sesuai dengan `max_usage`
   - Laporan dan analisis data menjadi tidak akurat

3. **Potensi Kerugian**
   - Jika voucher gratis, bisa digunakan lebih dari yang seharusnya
   - Menyebabkan kerugian finansial

#### 📊 Contoh Skenario Race Condition

**Timeline Race Condition:**
```
Time    Request A                          Request B
--------------------------------------------------------
T0      Cek usedCount = 9                  -
T1      max_usage = 10 → Valid            -
T2      -                                 Cek usedCount = 9
T3      -                                 max_usage = 10 → Valid
T4      Create Registration                -
T5      Assign voucher_code_id            -
T6      usedCount sekarang = 10           -
T7      -                                 Create Registration
T8      -                                 Assign voucher_code_id
T9      -                                 usedCount sekarang = 11 ❌
```

**Hasil:**
- Request A: ✅ Berhasil (usedCount = 10)
- Request B: ✅ Berhasil (usedCount = 11) ❌ Melebihi limit!

#### ✅ Solusi yang Disarankan

**Gunakan Database Transaction dengan Locking:**
```php
use Illuminate\Support\Facades\DB;

DB::transaction(function () use ($voucherCode, $voucher, $data, $event) {
    // Lock voucher code untuk update (pessimistic locking)
    $voucherCode = VoucherCode::lockForUpdate()
        ->where('id', $voucherCode->id)
        ->first();
    
    // Reload voucher untuk memastikan data terbaru
    $voucher = $voucherCode->voucher;
    
    // Validasi ulang setelah lock
    $usedCount = $voucherCode->registrations()
        ->whereIn('status', ['confirmed', 'paid'])
        ->count();
    
    if ($voucher->is_multiple_use) {
        if ($usedCount >= $voucher->max_usage) {
            throw new \Exception('Voucher code usage limit reached');
        }
    } else {
        if ($voucherCode->used || $voucherCode->registration) {
            throw new \Exception('Voucher code already used');
        }
    }
    
    // Create registration
    $registration = Registration::create($data);
    
    // Assign voucher
    $registration->voucher_code_id = $voucherCode->id;
    $registration->save();
    
    // Mark single use voucher as used
    if (!$voucher->is_multiple_use) {
        $voucherCode->used = true;
        $voucherCode->save();
    }
    
    // Continue dengan proses lainnya...
    return $registration;
});
```

**Atau gunakan Optimistic Locking:**
```php
// Tambahkan version column di voucher_codes table
// Saat update, cek version masih sama
$voucherCode = VoucherCode::find($id);
$originalVersion = $voucherCode->version;

// ... validasi dan assignment ...

$voucherCode->version = $originalVersion + 1;
$updated = $voucherCode->where('version', $originalVersion)->update([
    'used' => true,
    'version' => $voucherCode->version
]);

if (!$updated) {
    throw new \Exception('Voucher code was modified by another process');
}
```

#### 🔗 Related Issues

- Bug #1: Multiple use counting (logika terkait)
- Bug #6: Transaction untuk consistency

---

### Bug #6: Voucher Di-mark Used Meskipun Registration Gagal

**ID Bug:** VCH-006  
**Prioritas:** 🟠 HIGH  
**Severity:** Medium  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 120-132

#### 📝 Deskripsi

Jika `Registration::create()` berhasil tetapi ada error setelahnya (misalnya saat generate QR code atau send email), voucher single use sudah di-mark `used = true`, tetapi registration mungkin tidak lengkap atau gagal. Ini menyebabkan voucher terpakai meskipun registration tidak berhasil.

#### 💻 Kode yang Bermasalah

```120:132:app/Http/Controllers/Api/RegistrationController.php
$registration = Registration::create($data);

// Assign voucher ke registration (setelah semua valid)
if ($voucherValid && $voucherCode) {
    $registration->voucher_code_id = $voucherCode->id;
    $registration->save();

    // Tandai voucher single-use
    if (!$voucher->is_multiple_use) {
        $voucherCode->used = true;
        $voucherCode->save();
    }
}

// ... Generate QR, send email, dll (bisa error di sini)
```

**Masalah:**
- Tidak ada database transaction
- Voucher di-mark used sebelum semua proses selesai
- Jika ada error setelah mark used, voucher tidak bisa digunakan lagi

#### ⚠️ Dampak

1. **Voucher Terpakai Meskipun Gagal**
   - Registration gagal generate QR code
   - Voucher sudah di-mark used
   - User tidak bisa menggunakan voucher lagi

2. **Data Inconsistency**
   - Voucher marked as used tetapi tidak ada registration yang valid
   - Atau registration tidak lengkap (tanpa QR code, dll)

3. **User Experience Buruk**
   - User kehilangan voucher meskipun registration tidak berhasil
   - Menyebabkan komplain dan refund request

#### 📊 Contoh Skenario

**Skenario: Error Setelah Mark Used**
```
1. Registration::create() → ✅ Success
2. Assign voucher_code_id → ✅ Success
3. Mark voucher as used → ✅ Success
4. Generate QR code → ❌ Error (disk full, permission denied, dll)
5. Send email → ❌ Error

Hasil:
- Voucher: used = true ❌
- Registration: status = pending, tidak ada QR code
- ❌ Voucher terpakai meskipun registration tidak lengkap
```

#### ✅ Solusi yang Disarankan

**Gunakan Database Transaction:**
```php
use Illuminate\Support\Facades\DB;

try {
    DB::beginTransaction();
    
    // Create registration
    $registration = Registration::create($data);
    
    // Assign voucher
    if ($voucherValid && $voucherCode) {
        $registration->voucher_code_id = $voucherCode->id;
        $registration->save();
    }
    
    // Generate QR code
    $qrGenerator = new QrUtils();
    $qrPath = $qrGenerator->generateQr($registration);
    
    // Update registration dengan QR code
    $registration->update(['qr_code_path' => $qrPath]);
    
    // Mark voucher as used HANYA setelah semua berhasil
    if ($voucherValid && $voucherCode && !$voucher->is_multiple_use) {
        $voucherCode->used = true;
        $voucherCode->save();
    }
    
    // Send email
    $email = new EmailSender();
    $email->sendEmail($registration, $subject, $template);
    
    DB::commit();
    
} catch (\Exception $e) {
    DB::rollBack();
    // Voucher tidak akan di-mark used jika ada error
    throw $e;
}
```

**Atau dengan Try-Catch yang Lebih Spesifik:**
```php
DB::transaction(function () use ($data, $voucherCode, $voucher, $voucherValid, $event) {
    $registration = Registration::create($data);
    
    if ($voucherValid && $voucherCode) {
        $registration->voucher_code_id = $voucherCode->id;
        $registration->save();
    }
    
    // Semua operasi yang bisa error
    $qrPath = (new QrUtils())->generateQr($registration);
    $registration->update(['qr_code_path' => $qrPath]);
    
    // Mark used HANYA di akhir, setelah semua berhasil
    if ($voucherValid && $voucherCode && !$voucher->is_multiple_use) {
        $voucherCode->used = true;
        $voucherCode->save();
    }
    
    // Send email (bisa di luar transaction jika tidak critical)
    (new EmailSender())->sendEmail($registration, $subject, $template);
});
```

#### 🔗 Related Issues

- Bug #4: Race condition (juga perlu transaction)

---

## 🟡 Medium Priority

### Bug #5: Single Use Voucher - Logika Validasi Tidak Konsisten

**ID Bug:** VCH-005  
**Prioritas:** 🟡 MEDIUM  
**Severity:** Low-Medium  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 92-96

#### 📝 Deskripsi

Untuk single use voucher, validasi menggunakan `!$voucherCode->registration`. Relasi `registration()` adalah `hasOne`, yang bisa mengembalikan registration dengan status apapun (termasuk `pending` atau `cancel`). Logika ini tidak konsisten dengan multiple use yang menghitung semua registrations.

#### 💻 Kode yang Bermasalah

```92:96:app/Http/Controllers/Api/RegistrationController.php
if ($voucher->is_multiple_use) {
    $voucherValid = $usedCount < $voucher->max_usage;
} else {
    $voucherValid = !$voucherCode->used && !$voucherCode->registration;
}
```

**Masalah:**
- `$voucherCode->registration` bisa mengembalikan registration dengan status apapun
- Tidak konsisten dengan multiple use yang menghitung semua registrations
- Bisa menyebabkan voucher dianggap belum digunakan meskipun sudah ada registration

#### ⚠️ Dampak

1. **Logika Tidak Konsisten**
   - Single use: cek `registration` (apapun statusnya)
   - Multiple use: count semua registrations
   - Tidak ada konsistensi dalam logika

2. **Edge Case Issues**
   - Registration dengan status `cancel` masih dianggap sebagai penggunaan
   - Registration dengan status `pending` tidak dianggap sebagai penggunaan
   - Bisa menyebabkan confusion

#### ✅ Solusi yang Disarankan

**Gunakan Logika yang Konsisten:**
```php
if ($voucher->is_multiple_use) {
    $usedCount = $voucherCode->registrations()
        ->whereIn('status', ['confirmed', 'paid'])
        ->orWhere('payment_status', 'paid')
        ->count();
    $voucherValid = $usedCount < $voucher->max_usage;
} else {
    // Single use: cek apakah sudah ada registration yang confirmed/paid
    $hasConfirmedRegistration = $voucherCode->registrations()
        ->where(function($query) {
            $query->whereIn('status', ['confirmed', 'paid'])
                  ->orWhere('payment_status', 'paid');
        })
        ->exists();
    
    $voucherValid = !$voucherCode->used && !$hasConfirmedRegistration;
}
```

---

### Bug #7: Inconsistency - VoucherController vs RegistrationController

**ID Bug:** VCH-007  
**Prioritas:** 🟡 MEDIUM  
**Severity:** Low  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

- `app/Http/Controllers/Api/VoucherController.php` baris 24-26
- `app/Http/Controllers/Api/RegistrationController.php` baris 75-77

#### 📝 Deskripsi

Logika validasi berbeda antara endpoint check voucher (`VoucherController`) dan endpoint registration (`RegistrationController`). VoucherController memvalidasi `category_ticket_type_id`, sedangkan RegistrationController tidak.

#### 💻 Kode yang Bermasalah

**VoucherController.php:**
```php
$voucherCode = VoucherCode::with([...])
    ->where('code', $request->code)
    ->whereHas('voucher.categoryTicketType', function ($query) use ($request) {
        $query->where('id', $request->category_ticket_type_id);
    })
    ->first();
```

**RegistrationController.php:**
```php
$voucherCode = VoucherCode::where('code', $data['voucher_code'])
    ->with('voucher')
    ->first();
// ❌ TIDAK ADA VALIDASI category_ticket_type_id
```

#### ⚠️ Dampak

1. **Inconsistency**
   - User check voucher → valid
   - User registrasi → bisa error atau voucher digunakan untuk tiket yang salah
   - Menyebabkan confusion

2. **User Experience Buruk**
   - User mendapat response valid dari check endpoint
   - Tetapi saat registrasi, voucher tidak bisa digunakan atau digunakan untuk tiket yang salah

#### ✅ Solusi yang Disarankan

**Buat Helper Function untuk Konsistensi:**
```php
// Di BaseController atau Helper class
protected function validateVoucherCode($code, $categoryTicketTypeId)
{
    return VoucherCode::where('code', $code)
        ->whereHas('voucher.categoryTicketType', function ($query) use ($categoryTicketTypeId) {
            $query->where('id', $categoryTicketTypeId);
        })
        ->with('voucher')
        ->first();
}

// Di VoucherController
$voucherCode = $this->validateVoucherCode($request->code, $request->category_ticket_type_id);

// Di RegistrationController
$voucherCode = $this->validateVoucherCode($data['voucher_code'], $data['category_ticket_type_id']);
```

---

### Bug #8: Tidak Ada Validasi Tanggal Voucher

**ID Bug:** VCH-008  
**Prioritas:** 🟡 MEDIUM  
**Severity:** Low  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 74-101

#### 📝 Deskripsi

Tidak ada pengecekan apakah voucher masih berlaku berdasarkan tanggal. `CategoryTicketType` memiliki `valid_from` dan `valid_until`, tetapi tidak ada validasi apakah voucher masih berlaku untuk periode tersebut.

#### ⚠️ Dampak

- Voucher bisa digunakan di luar periode yang seharusnya
- Jika `CategoryTicketType` memiliki periode valid, voucher seharusnya juga mengikuti periode tersebut

#### ✅ Solusi yang Disarankan

**Tambahkan Validasi Tanggal:**
```php
$categoryTicketType = CategoryTicketType::find($data['category_ticket_type_id']);

if (!$categoryTicketType) {
    return response()->json(['message' => 'Category ticket type not found.'], 404);
}

// Validasi periode category ticket type
$now = Carbon::now();
if ($categoryTicketType->valid_from && $now->lt(Carbon::parse($categoryTicketType->valid_from))) {
    return response()->json(['message' => 'Tiket belum tersedia.'], 400);
}
if ($categoryTicketType->valid_until && $now->gt(Carbon::parse($categoryTicketType->valid_until))) {
    return response()->json(['message' => 'Tiket sudah tidak tersedia.'], 400);
}
```

---

## 🎯 Rekomendasi Perbaikan

### Prioritas Perbaikan

#### 🔴 Phase 1: Critical Fixes (Segera)
1. **Bug #3**: Perbaiki webhook untuk tidak mark multiple use voucher sebagai used
2. **Bug #1**: Filter status registrations saat menghitung penggunaan voucher
3. **Bug #2**: Tambahkan validasi `category_ticket_type_id` di RegistrationController

#### 🟠 Phase 2: High Priority (1-2 Minggu)
4. **Bug #4**: Implement database transaction dengan locking untuk race condition
5. **Bug #6**: Gunakan transaction untuk memastikan voucher tidak di-mark used jika registration gagal

#### 🟡 Phase 3: Medium Priority (1 Bulan)
6. **Bug #5**: Konsistensikan logika validasi single use voucher
7. **Bug #7**: Buat helper function untuk konsistensi validasi voucher
8. **Bug #8**: Tambahkan validasi tanggal voucher

### Best Practices yang Disarankan

1. **Database Transaction**
   - Gunakan `DB::transaction()` untuk semua operasi voucher
   - Pastikan atomicity (all or nothing)

2. **Row Locking**
   - Gunakan `lockForUpdate()` untuk mencegah race condition
   - Implement pessimistic locking untuk critical operations

3. **Status Filtering**
   - Selalu filter berdasarkan status saat menghitung penggunaan
   - Hanya hitung registrations yang sudah `confirmed`/`paid`

4. **Validation Consistency**
   - Buat helper function untuk validasi voucher
   - Gunakan logika yang sama di semua controller

5. **Error Handling**
   - Rollback transaction jika ada error
   - Jangan mark voucher as used sebelum semua proses selesai

6. **Testing**
   - Test race condition dengan concurrent requests
   - Test edge cases (pending, cancel, expired)
   - Test multiple use voucher dengan berbagai skenario

---

## 📎 Lampiran

### File yang Terpengaruh

1. `app/Http/Controllers/Api/RegistrationController.php`
   - Method: `store()`
   - Bugs: #1, #2, #4, #5, #6, #8

2. `app/Http/Controllers/Webhook/MidtransWebhookController.php`
   - Method: `updatePaymentStatus()`
   - Bugs: #3

3. `app/Http/Controllers/Api/VoucherController.php`
   - Method: `checkVoucherCode()`
   - Bugs: #7 (inconsistency)

### Model yang Terkait

- `App\Models\Voucher`
- `App\Models\VoucherCode`
- `App\Models\Registration`
- `App\Models\CategoryTicketType`

### Database Tables

- `vouchers`
- `voucher_codes`
- `registrations`
- `category_ticket_type`

---

**Dokumen ini dibuat untuk keperluan tracking dan perbaikan bug sistem voucher.**  
**Terakhir diperbarui:** 2025-01-XX  
**Status:** 🔴 Critical Issues - Perlu Perbaikan Segera
