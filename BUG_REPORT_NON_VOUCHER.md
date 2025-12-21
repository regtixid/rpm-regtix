# 📋 Laporan Bug - Sistem Non-Voucher

**Tanggal Laporan:** 2025-01-XX  
**Versi Sistem:** -  
**Status:** 🔴 Critical Issues Found  
**Total Bug:** 10 (3 Critical, 4 High, 3 Medium)

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

Laporan ini mengidentifikasi **10 bug kritis** dalam sistem registrasi dan payment yang tidak terkait dengan voucher, yang dapat menyebabkan:
- ❌ Tiket terjual melebihi quota
- ❌ Double payment tidak terdeteksi
- ❌ Registration yang sudah cancel di-update menjadi confirmed
- ❌ Null pointer exception
- ❌ Data inconsistency dan potensi kerugian finansial

### Statistik Bug

| Prioritas | Jumlah | Persentase |
|-----------|--------|------------|
| 🔴 Critical | 3 | 30% |
| 🟠 High | 4 | 40% |
| 🟡 Medium | 3 | 30% |
| **Total** | **10** | **100%** |

### File yang Terpengaruh

1. `app/Http/Controllers/Api/RegistrationController.php` - 5 bug
2. `app/Http/Controllers/Webhook/MidtransWebhookController.php` - 4 bug
3. `app/Helpers/MidtransUtils.php` - 1 bug

---

## 🐛 Daftar Bug

---

## 🔴 Critical Priority

### Bug #1: Tidak Ada Validasi Quota Tiket

**ID Bug:** REG-001  
**Prioritas:** 🔴 CRITICAL  
**Severity:** Critical  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 69-164

#### 📝 Deskripsi

Sistem tidak memvalidasi apakah tiket masih tersedia (quota) sebelum membuat registration. Ini dapat menyebabkan tiket terjual melebihi quota yang ditetapkan, menyebabkan overbooking dan masalah operasional.

#### 💻 Kode yang Bermasalah

```69:164:app/Http/Controllers/Api/RegistrationController.php
// ==== VALIDASI CATEGORY TICKET TYPE ====
$categoryTicketType = CategoryTicketType::find($data['category_ticket_type_id']);

if (!$categoryTicketType) {
    return response()->json(['message' => 'Category ticket type not found.'], 404);
}

// ... validasi periode ...

// ==== CREATE REGISTRATION DENGAN TRANSACTION ====
// ❌ TIDAK ADA VALIDASI QUOTA
$registration = Registration::create($data);
```

**Masalah:**
- Tidak ada pengecekan apakah `quota` masih tersedia
- Tidak ada validasi `remaining = quota - used > 0`
- Registration bisa dibuat meskipun quota sudah habis

#### ⚠️ Dampak

1. **Overbooking**
   - Tiket bisa terjual melebihi quota
   - Menyebabkan masalah operasional saat event
   - Potensi komplain dari peserta yang tidak bisa masuk

2. **Data Inconsistency**
   - Quota di database tidak sesuai dengan kenyataan
   - Laporan dan analisis data menjadi tidak akurat

3. **Kerugian Finansial**
   - Jika ada refund karena overbooking
   - Potensi denda atau kompensasi

#### 📊 Contoh Skenario

**Skenario: Quota Habis**
```
Category Ticket Type:
- quota: 100
- used: 100 (semua sudah confirmed)
- remaining: 0

User mencoba register:
- ✅ Validasi periode: OK
- ✅ Validasi voucher: OK
- ❌ Tidak ada validasi quota
- ✅ Registration dibuat
- ❌ Quota melebihi limit!
```

#### ✅ Solusi yang Disarankan

**Tambahkan Validasi Quota:**
```php
// Setelah validasi periode
$usedCount = Registration::where('category_ticket_type_id', $data['category_ticket_type_id'])
    ->whereIn('status', ['pending', 'confirmed', 'paid'])
    ->count();

$remaining = $categoryTicketType->quota - $usedCount;

if ($remaining <= 0) {
    return response()->json([
        'message' => 'Tiket sudah habis.',
        'error' => 'QUOTA_EXCEEDED'
    ], 400);
}

// Atau gunakan dengan locking untuk race condition
DB::transaction(function () use ($categoryTicketType, $data) {
    $categoryTicketType = CategoryTicketType::lockForUpdate()
        ->find($categoryTicketType->id);
    
    $usedCount = Registration::where('category_ticket_type_id', $categoryTicketType->id)
        ->whereIn('status', ['pending', 'confirmed', 'paid'])
        ->count();
    
    if ($usedCount >= $categoryTicketType->quota) {
        throw new \Exception('Tiket sudah habis');
    }
    
    // Create registration...
});
```

---

### Bug #2: Webhook Update Status Cancel Menjadi Confirmed

**ID Bug:** WEB-001  
**Prioritas:** 🔴 CRITICAL  
**Severity:** Critical  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Webhook/MidtransWebhookController.php`  
**Method:** `updatePaymentStatus()`  
**Baris:** 66-88

#### 📝 Deskripsi

Webhook selalu mengupdate status registration menjadi `confirmed` untuk semua transaction status, termasuk `cancel`. Ini menyebabkan registration yang dibatalkan tetap dianggap confirmed, menyebabkan data inconsistency dan masalah operasional.

#### 💻 Kode yang Bermasalah

```66:88:app/Http/Controllers/Webhook/MidtransWebhookController.php
private function updatePaymentStatus(string $originalOrderId, string $transactionId, string $status, string $transactionTime, string $paymentType, $grossAmount): void
{
    $registration = Registration::where('registration_code', $originalOrderId)->first();
    // ...
    if($registration){
        $registration->update([                
            'status' => 'confirmed',  // ❌ SELALU confirmed
            'payment_status' => $status,  // ✅ Ini benar
            // ...
        ]);
    }
}
```

**Masalah:**
- Status `status` selalu di-set menjadi `confirmed`
- Tidak ada logika untuk status `cancel`, `deny`, `expire`
- Registration yang cancel tetap dianggap confirmed

#### ⚠️ Dampak

1. **Data Inconsistency**
   - Registration dengan payment_status `cancel` memiliki status `confirmed`
   - Sistem menganggap registration valid meskipun payment dibatalkan
   - Laporan dan analisis data menjadi tidak akurat

2. **Operational Issues**
   - Participant yang cancel tetap terhitung sebagai confirmed
   - Quota tidak akurat karena include cancelled registrations
   - Email e-ticket mungkin terkirim untuk cancelled registration

3. **Business Logic Error**
   - Sistem tidak bisa membedakan confirmed vs cancelled
   - Potensi masalah saat check-in event

#### 📊 Contoh Skenario

**Skenario: Payment Cancel**
```
1. User register → status: pending, payment_status: pending
2. User bayar → Midtrans webhook: status: pending
3. User cancel payment → Midtrans webhook: status: cancel
4. Webhook update:
   - status: confirmed ❌ (seharusnya tetap pending atau cancel)
   - payment_status: cancel ✅
5. Hasil: Registration dianggap confirmed meskipun payment cancel
```

#### ✅ Solusi yang Disarankan

**Perbaiki Logika Status:**
```php
private function updatePaymentStatus(string $originalOrderId, string $transactionId, string $status, string $transactionTime, string $paymentType, $grossAmount): void
{
    $registration = Registration::where('registration_code', $originalOrderId)->first();
    
    if (!$registration) {
        return;
    }
    
    // Tentukan status registration berdasarkan payment status
    $registrationStatus = 'pending';
    if ($status === 'paid' || $status === 'settlement') {
        $registrationStatus = 'confirmed';
    } elseif (in_array($status, ['cancel', 'deny', 'expire', 'failure'])) {
        $registrationStatus = 'pending'; // atau 'cancelled' jika ada
        // Jangan update menjadi confirmed
    }
    
    $registration->update([
        'status' => $registrationStatus,  // ✅ Sesuai dengan payment status
        'payment_status' => $status,
        'transaction_code' => $transactionId,
        'paid_at' => $status === 'paid' ? $transactionTime : null,
        'payment_type' => $paymentType,
        'gross_amount' => $grossAmount,
    ]);
    
    // Hanya generate QR dan send email jika paid
    if ($status === 'paid') {
        // Generate QR, send email, dll
    }
}
```

---

### Bug #3: Null Pointer Exception di Webhook

**ID Bug:** WEB-002  
**Prioritas:** 🔴 CRITICAL  
**Severity:** Critical  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Webhook/MidtransWebhookController.php`  
**Method:** `updatePaymentStatus()`  
**Baris:** 68-76

#### 📝 Deskripsi

Kode menghitung `reg_id` menggunakan `$registration` sebelum melakukan null check. Jika registration tidak ditemukan, akan terjadi null pointer exception saat mengakses relasi.

#### 💻 Kode yang Bermasalah

```68:76:app/Http/Controllers/Webhook/MidtransWebhookController.php
private function updatePaymentStatus(string $originalOrderId, string $transactionId, string $status, string $transactionTime, string $paymentType, $grossAmount): void
{
    $registration = Registration::where('registration_code', $originalOrderId)->first();
    $count = Registration::where('status', 'confirmed')
        ->whereHas('categoryTicketType.category.event', function ($q) use ($registration) {
            $q->where('event_id', $registration->categoryTicketType->category->event->id);
            // ❌ $registration bisa null di sini
        })
        ->count();
    // ...
    if($registration){  // ✅ Null check di sini, tapi sudah terlambat
```

**Masalah:**
- `$registration` digunakan di `whereHas` closure sebelum null check
- Jika registration tidak ditemukan, akan terjadi error
- `$registration->categoryTicketType->category->event->id` akan throw null pointer exception

#### ⚠️ Dampak

1. **Application Crash**
   - Webhook akan error jika registration tidak ditemukan
   - Midtrans tidak mendapat response success
   - Webhook akan di-retry berulang kali

2. **Data Loss**
   - Payment status tidak terupdate
   - User sudah bayar tetapi status tidak berubah
   - Potensi komplain dan refund

#### ✅ Solusi yang Disarankan

**Pindahkan Null Check ke Awal:**
```php
private function updatePaymentStatus(string $originalOrderId, string $transactionId, string $status, string $transactionTime, string $paymentType, $grossAmount): void
{
    $registration = Registration::where('registration_code', $originalOrderId)->first();
    
    // ✅ Null check di awal
    if (!$registration) {
        Log::warning('Registration not found for webhook', [
            'order_id' => $originalOrderId,
            'transaction_id' => $transactionId,
            'status' => $status
        ]);
        return;
    }
    
    // ✅ Baru hitung count setelah null check
    $count = Registration::where('status', 'confirmed')
        ->whereHas('categoryTicketType.category.event', function ($q) use ($registration) {
            $q->where('event_id', $registration->categoryTicketType->category->event->id);
        })
        ->count();
    
    // Continue dengan proses lainnya...
}
```

---

## 🟠 High Priority

### Bug #4: Duplicate Check Hanya untuk Status Pending

**ID Bug:** REG-002  
**Prioritas:** 🟠 HIGH  
**Severity:** Medium-High  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 32-43

#### 📝 Deskripsi

Duplicate check hanya memfilter berdasarkan status `pending`. User bisa membuat registration baru dengan email dan id_card_number yang sama jika registration sebelumnya sudah `confirmed` atau status lain, menyebabkan duplikasi data.

#### 💻 Kode yang Bermasalah

```32:43:app/Http/Controllers/Api/RegistrationController.php
// ==== CEK REGISTRATION DUPLIKAT ====
$registran = Registration::where('email', $data['email'])
    ->where('category_ticket_type_id', $data['category_ticket_type_id'])
    ->where('id_card_number', $data['id_card_number'])
    ->where('status', 'pending')  // ❌ Hanya cek pending
    ->with([...])
    ->first();
```

**Masalah:**
- Hanya mengecek status `pending`
- User bisa register lagi jika registration sebelumnya sudah `confirmed`
- Tidak ada validasi untuk status lain

#### ⚠️ Dampak

1. **Data Duplication**
   - User bisa memiliki multiple registrations untuk tiket yang sama
   - Menyebabkan confusion dan data inconsistency

2. **Business Logic Error**
   - Satu orang bisa memiliki multiple tiket untuk event yang sama
   - Potensi abuse atau error

#### ✅ Solusi yang Disarankan

**Cek Semua Status yang Relevan:**
```php
// Cek apakah sudah ada registration yang aktif
$registran = Registration::where('email', $data['email'])
    ->where('category_ticket_type_id', $data['category_ticket_type_id'])
    ->where('id_card_number', $data['id_card_number'])
    ->whereIn('status', ['pending', 'confirmed', 'paid'])  // ✅ Cek semua status aktif
    ->with([...])
    ->first();

// Atau lebih spesifik: cek apakah sudah confirmed/paid
$existingRegistration = Registration::where('email', $data['email'])
    ->where('category_ticket_type_id', $data['category_ticket_type_id'])
    ->where('id_card_number', $data['id_card_number'])
    ->where(function($query) {
        $query->where('status', 'confirmed')
              ->orWhere('payment_status', 'paid');
    })
    ->first();

if ($existingRegistration) {
    return response()->json([
        'message' => 'Anda sudah terdaftar untuk tiket ini.',
        'data' => $existingRegistration
    ], 409);
}
```

---

### Bug #5: Tidak Ada Validasi Double Payment

**ID Bug:** WEB-003  
**Prioritas:** 🟠 HIGH  
**Severity:** Medium-High  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Webhook/MidtransWebhookController.php`  
**Method:** `updatePaymentStatus()`  
**Baris:** 66-88

#### 📝 Deskripsi

Webhook tidak memvalidasi apakah registration sudah dibayar sebelumnya. Jika Midtrans mengirim webhook berulang kali untuk payment yang sama, sistem akan mengupdate status berulang kali, menyebabkan duplicate processing (email terkirim berulang, QR code di-generate berulang).

#### 💻 Kode yang Bermasalah

```66:88:app/Http/Controllers/Webhook/MidtransWebhookController.php
private function updatePaymentStatus(string $originalOrderId, string $transactionId, string $status, string $transactionTime, string $paymentType, $grossAmount): void
{
    $registration = Registration::where('registration_code', $originalOrderId)->first();
    // ...
    if($registration){
        // ❌ Tidak ada cek apakah sudah paid sebelumnya
        $registration->update([...]);
        
        if($status === 'paid'){
            // ❌ Email akan terkirim berulang jika webhook dipanggil berulang
            $emailSender->sendEmail(...);
        }
    }
}
```

**Masalah:**
- Tidak ada pengecekan `payment_status` sebelum update
- Tidak ada pengecekan `transaction_code` untuk mencegah duplicate processing
- Email dan QR code bisa di-generate berulang kali

#### ⚠️ Dampak

1. **Duplicate Processing**
   - Email e-ticket terkirim berulang kali
   - QR code di-generate berulang (meskipun sama)
   - Menyebabkan spam email

2. **Data Inconsistency**
   - `paid_at` bisa di-update berulang kali
   - Log tidak akurat

3. **User Experience**
   - User mendapat email berulang
   - Menyebabkan confusion

#### ✅ Solusi yang Disarankan

**Tambahkan Validasi Double Payment:**
```php
private function updatePaymentStatus(string $originalOrderId, string $transactionId, string $status, string $transactionTime, string $paymentType, $grossAmount): void
{
    $registration = Registration::where('registration_code', $originalOrderId)->first();
    
    if (!$registration) {
        return;
    }
    
    // ✅ Cek apakah sudah paid sebelumnya
    if ($status === 'paid' && $registration->payment_status === 'paid') {
        // Cek apakah transaction_code sama (valid duplicate webhook)
        if ($registration->transaction_code === $transactionId) {
            Log::info('Duplicate webhook for already paid registration', [
                'registration_code' => $originalOrderId,
                'transaction_id' => $transactionId
            ]);
            return; // Ignore duplicate webhook
        } else {
            // Different transaction ID - mungkin refund atau issue
            Log::warning('Different transaction ID for paid registration', [
                'registration_code' => $originalOrderId,
                'existing_transaction' => $registration->transaction_code,
                'new_transaction' => $transactionId
            ]);
        }
    }
    
    // Update status...
    // Hanya send email jika belum pernah paid
    if ($status === 'paid' && $registration->payment_status !== 'paid') {
        // Send email, generate QR, dll
    }
}
```

---

### Bug #6: Tidak Ada Transaction untuk Update Payment Status

**ID Bug:** WEB-004  
**Prioritas:** 🟠 HIGH  
**Severity:** Medium  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Webhook/MidtransWebhookController.php`  
**Method:** `updatePaymentStatus()`  
**Baris:** 66-109

#### 📝 Deskripsi

Update payment status tidak menggunakan database transaction. Jika ada error di tengah proses (misalnya saat generate QR code atau send email), status registration sudah terupdate tetapi proses tidak lengkap, menyebabkan data inconsistency.

#### 💻 Kode yang Bermasalah

```66:109:app/Http/Controllers/Webhook/MidtransWebhookController.php
private function updatePaymentStatus(...): void
{
    $registration = Registration::where('registration_code', $originalOrderId)->first();
    // ...
    if($registration){
        // ❌ Tidak ada transaction
        $registration->update([...]);  // Update status
        
        if($status === 'paid'){
            // Jika error di sini, status sudah terupdate
            $qrPath = $qrGenerator->generateQr($registration);  // Bisa error
            $emailSender->sendEmail(...);  // Bisa error
        }
    }
}
```

**Masalah:**
- Tidak ada `DB::transaction()`
- Jika error terjadi setelah update status, data tidak konsisten
- Status sudah `paid` tetapi QR code atau email tidak terkirim

#### ✅ Solusi yang Disarankan

**Gunakan Database Transaction:**
```php
use Illuminate\Support\Facades\DB;

private function updatePaymentStatus(...): void
{
    $registration = Registration::where('registration_code', $originalOrderId)->first();
    
    if (!$registration) {
        return;
    }
    
    try {
        DB::transaction(function () use ($registration, $status, $transactionId, $transactionTime, $paymentType, $grossAmount) {
            // Generate QR code dulu (bisa error)
            $qrGenerator = new QrUtils();
            $qrPath = $qrGenerator->generateQr($registration);
            
            // Update status setelah semua berhasil
            $registration->update([
                'status' => $status === 'paid' ? 'confirmed' : 'pending',
                'payment_status' => $status,
                'transaction_code' => $transactionId,
                'qr_code_path' => $qrPath,
                // ...
            ]);
            
            // Send email (bisa di luar transaction jika tidak critical)
            if ($status === 'paid') {
                $emailSender = new EmailSender();
                $emailSender->sendEmail(...);
            }
        });
    } catch (\Exception $e) {
        Log::error('Failed to update payment status', [
            'registration_code' => $originalOrderId,
            'error' => $e->getMessage()
        ]);
        throw $e; // Re-throw untuk webhook retry
    }
}
```

---

### Bug #7: checkRegistration Menggunakan orWhere Tanpa Grouping

**ID Bug:** REG-003  
**Prioritas:** 🟠 HIGH  
**Severity:** Medium  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `checkRegistration()`  
**Baris:** 282-285

#### 📝 Deskripsi

Query menggunakan `orWhere` tanpa grouping, menyebabkan query bisa mengembalikan registration yang salah. Jika `registration_code` tidak ditemukan, query akan mencari semua registration dengan `id_card_number` yang sama, bukan hanya yang sesuai dengan `registration_code`.

#### 💻 Kode yang Bermasalah

```282:285:app/Http/Controllers/Api/RegistrationController.php
$reg = Registration::where('registration_code', $request->registration_code)
    ->orWhere('id_card_number', $request->registration_code)
    ->with([...])
    ->first();
```

**Masalah:**
- `orWhere` tanpa grouping menyebabkan query logic salah
- Jika `registration_code` tidak match, akan mencari semua dengan `id_card_number` yang sama
- Bisa return registration yang salah

#### ⚠️ Dampak

1. **Security Issue**
   - User bisa mengakses registration orang lain dengan mengetahui id_card_number
   - Data privacy violation

2. **Data Leakage**
   - Informasi registration bisa diakses oleh user yang tidak berhak
   - Potensi abuse

#### ✅ Solusi yang Disarankan

**Gunakan Grouping atau Separate Queries:**
```php
// Opsi 1: Gunakan grouping
$reg = Registration::where(function($query) use ($request) {
        $query->where('registration_code', $request->registration_code)
              ->orWhere('id_card_number', $request->registration_code);
    })
    ->with([...])
    ->first();

// Opsi 2: Separate queries (lebih aman)
$reg = Registration::where('registration_code', $request->registration_code)
    ->with([...])
    ->first();

if (!$reg) {
    $reg = Registration::where('id_card_number', $request->registration_code)
        ->with([...])
        ->first();
}

// Opsi 3: Validasi input untuk menentukan field mana yang digunakan
if (strlen($request->registration_code) === 20 && strpos($request->registration_code, 'RTIX-') === 0) {
    // Registration code format
    $reg = Registration::where('registration_code', $request->registration_code)
        ->with([...])
        ->first();
} else {
    // ID card number format
    $reg = Registration::where('id_card_number', $request->registration_code)
        ->with([...])
        ->first();
}
```

---

## 🟡 Medium Priority

### Bug #8: Assignment Salah di MidtransUtils

**ID Bug:** MID-001  
**Prioritas:** 🟡 MEDIUM  
**Severity:** Low  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Helpers/MidtransUtils.php`  
**Method:** `generatePaymentLink()`  
**Baris:** 44

#### 📝 Deskripsi

Baris 44 melakukan assignment (`$voucher = ...`) di dalam array, bukan mengambil nilai. Ini menyebabkan nama voucher di item details tidak terisi dengan benar.

#### 💻 Kode yang Bermasalah

```39:46:app/Helpers/MidtransUtils.php
if($voucher) {
    $itemDetails[] = [
        'id' => 'voucher-'.$registration->id,
        'price' => -$priceReduction,
        'quantity' => 1,
        'name' => $voucher = $registration->voucherCode->voucher->name,  // ❌ Assignment salah
    ];
}
```

**Masalah:**
- `$voucher = ...` melakukan assignment, bukan mengambil nilai
- Nama voucher tidak terisi dengan benar
- Bisa menyebabkan error jika `$registration->voucherCode->voucher` null

#### ✅ Solusi yang Disarankan

**Perbaiki Assignment:**
```php
if($voucher) {
    $itemDetails[] = [
        'id' => 'voucher-'.$registration->id,
        'price' => -$priceReduction,
        'quantity' => 1,
        'name' => $voucher->name,  // ✅ Ambil dari $voucher yang sudah didefinisikan
    ];
}
```

---

### Bug #9: Tidak Ada Null Check untuk TicketType

**ID Bug:** REG-004  
**Prioritas:** 🟡 MEDIUM  
**Severity:** Low  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Http/Controllers/Api/RegistrationController.php`  
**Method:** `store()`  
**Baris:** 85

#### 📝 Deskripsi

Setelah `CategoryTicketType::find()`, kode langsung mengakses `$categoryTicketType->ticketType` tanpa null check. Jika relasi tidak ada, akan terjadi error.

#### 💻 Kode yang Bermasalah

```69:85:app/Http/Controllers/Api/RegistrationController.php
$categoryTicketType = CategoryTicketType::find($data['category_ticket_type_id']);

if (!$categoryTicketType) {
    return response()->json(['message' => 'Category ticket type not found.'], 404);
}

// ... validasi periode ...

$ticketType = $categoryTicketType->ticketType;  // ❌ Bisa null
```

**Masalah:**
- Tidak ada null check untuk `ticketType`
- Jika relasi tidak ada, akan error saat mengakses `$ticketType->name` di response

#### ✅ Solusi yang Disarankan

**Tambahkan Null Check:**
```php
$ticketType = $categoryTicketType->ticketType;

if (!$ticketType) {
    return response()->json(['message' => 'Ticket type not found.'], 404);
}
```

---

### Bug #10: Address Concatenation Bisa Error jika Null

**ID Bug:** MID-002  
**Prioritas:** 🟡 MEDIUM  
**Severity:** Low  
**Status:** ❌ Not Fixed

#### 📍 Lokasi

**File:** `app/Helpers/MidtransUtils.php`  
**Method:** `generatePaymentLink()`  
**Baris:** 28

#### 📝 Deskripsi

Address di-concatenate tanpa null check. Jika `district` atau `province` null, akan menghasilkan string dengan "null" atau error.

#### 💻 Kode yang Bermasalah

```28:28:app/Helpers/MidtransUtils.php
$address = $registration->address . ', ' . $registration->district . ', ' . $registration->province;
```

**Masalah:**
- Jika `district` atau `province` null, akan menghasilkan "Jl. Merdeka, null, null"
- Tidak user-friendly

#### ✅ Solusi yang Disarankan

**Gunakan Null Coalescing atau Filter:**
```php
$addressParts = array_filter([
    $registration->address,
    $registration->district,
    $registration->province
]);

$address = implode(', ', $addressParts);

// Atau
$address = trim(implode(', ', array_filter([
    $registration->address,
    $registration->district,
    $registration->province
])), ', ');
```

---

## 🎯 Rekomendasi Perbaikan

### Prioritas Perbaikan

#### 🔴 Phase 1: Critical Fixes (Segera)
1. **Bug #1**: Tambahkan validasi quota tiket
2. **Bug #2**: Perbaiki logika status di webhook (jangan set confirmed untuk cancel)
3. **Bug #3**: Pindahkan null check ke awal di webhook

#### 🟠 Phase 2: High Priority (1-2 Minggu)
4. **Bug #4**: Perbaiki duplicate check untuk semua status aktif
5. **Bug #5**: Tambahkan validasi double payment
6. **Bug #6**: Gunakan transaction untuk update payment status
7. **Bug #7**: Perbaiki query checkRegistration dengan grouping

#### 🟡 Phase 3: Medium Priority (1 Bulan)
8. **Bug #8**: Perbaiki assignment di MidtransUtils
9. **Bug #9**: Tambahkan null check untuk ticketType
10. **Bug #10**: Perbaiki address concatenation

### Best Practices yang Disarankan

1. **Validasi Quota dengan Locking**
   - Gunakan `lockForUpdate()` untuk mencegah race condition
   - Validasi quota sebelum create registration

2. **Idempotent Webhook**
   - Cek `transaction_code` untuk mencegah duplicate processing
   - Log duplicate webhook untuk monitoring

3. **Database Transaction**
   - Gunakan transaction untuk semua operasi yang memerlukan atomicity
   - Rollback jika ada error

4. **Null Safety**
   - Selalu lakukan null check sebelum mengakses relasi
   - Gunakan optional chaining atau null coalescing

5. **Query Safety**
   - Gunakan grouping untuk `orWhere`
   - Validasi input sebelum query

6. **Error Handling**
   - Log error dengan context yang jelas
   - Return error message yang user-friendly

---

## 📎 Lampiran

### File yang Terpengaruh

1. `app/Http/Controllers/Api/RegistrationController.php`
   - Method: `store()`, `checkRegistration()`
   - Bugs: #1, #4, #7, #9

2. `app/Http/Controllers/Webhook/MidtransWebhookController.php`
   - Method: `updatePaymentStatus()`
   - Bugs: #2, #3, #5, #6

3. `app/Helpers/MidtransUtils.php`
   - Method: `generatePaymentLink()`
   - Bugs: #8, #10

### Model yang Terkait

- `App\Models\Registration`
- `App\Models\CategoryTicketType`
- `App\Models\Event`

### Database Tables

- `registrations`
- `category_ticket_type`
- `events`

---

**Dokumen ini dibuat untuk keperluan tracking dan perbaikan bug sistem non-voucher.**  
**Terakhir diperbarui:** 2025-01-XX  
**Status:** 🔴 Critical Issues - Perlu Perbaikan Segera


















