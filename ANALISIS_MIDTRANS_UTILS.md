# 📋 Analisis MidtransUtils.php - Compliance Check

**Tanggal Analisis:** 2025-01-XX  
**File:** `app/Helpers/MidtransUtils.php`  
**Status:** ⚠️ Perlu Perbaikan

---

## 📊 Ringkasan

Setelah membandingkan dengan dokumentasi resmi Midtrans Payment Link API, ditemukan **6 masalah** yang perlu diperbaiki:

| No | Masalah | Prioritas | Status |
|----|---------|-----------|--------|
| 1 | Assignment salah di line 44 | 🔴 Critical | ❌ Bug |
| 2 | Tidak ada error handling | 🔴 Critical | ❌ Missing |
| 3 | Address concatenation bisa null | 🟠 High | ❌ Bug |
| 4 | Struktur payload tidak lengkap | 🟠 High | ⚠️ Warning |
| 5 | Tidak ada validasi input | 🟡 Medium | ⚠️ Warning |
| 6 | Gross amount tidak validasi | 🟡 Medium | ⚠️ Warning |

---

## 🔴 Critical Issues

### Bug #1: Assignment Salah di Line 44

**Lokasi:** `app/Helpers/MidtransUtils.php` baris 44

**Kode yang Bermasalah:**
```php
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
- Nama voucher tidak terisi dengan benar di item details
- Bisa menyebabkan error jika `$registration->voucherCode->voucher` null

**Dampak:**
- Nama voucher di Midtrans payment link tidak terlihat
- Item details tidak lengkap
- User confusion saat melihat detail pembayaran

**Solusi:**
```php
'name' => $voucher->name,  // ✅ Ambil dari $voucher yang sudah didefinisikan di line 17
```

---

### Bug #2: Tidak Ada Error Handling

**Lokasi:** `app/Helpers/MidtransUtils.php` baris 84-94

**Kode yang Bermasalah:**
```php
$client = new Client();
$response = $client->request('POST', $apiUrl, [
    'headers' => [...],
    'body' => json_encode($payload)
]);

return json_decode($response->getBody()->getContents(), true);
```

**Masalah:**
- Tidak ada try-catch untuk menangani error
- Tidak ada validasi response status code
- Jika Midtrans API error, akan throw exception tanpa handling
- Tidak ada logging untuk debugging

**Dampak:**
- Application crash jika Midtrans API down
- User mendapat error 500 tanpa informasi jelas
- Sulit untuk debugging masalah payment

**Solusi yang Disarankan:**
```php
use Illuminate\Support\Facades\Log;
use GuzzleHttp\Exception\RequestException;

try {
    $client = new Client();
    $response = $client->request('POST', $apiUrl, [
        'headers' => [
            'Accept' => 'application/json',
            'Content-Type' => 'application/json',
            'Authorization' => $auth
        ],
        'body' => json_encode($payload),
        'timeout' => 30  // Timeout 30 detik
    ]);
    
    $statusCode = $response->getStatusCode();
    $responseBody = json_decode($response->getBody()->getContents(), true);
    
    // Validasi response
    if ($statusCode !== 200 && $statusCode !== 201) {
        Log::error('Midtrans API error', [
            'status_code' => $statusCode,
            'response' => $responseBody,
            'registration_code' => $registration->registration_code
        ]);
        throw new \Exception('Failed to generate payment link: ' . ($responseBody['status_message'] ?? 'Unknown error'));
    }
    
    // Validasi payment_url ada
    if (!isset($responseBody['payment_url'])) {
        Log::error('Midtrans response missing payment_url', [
            'response' => $responseBody,
            'registration_code' => $registration->registration_code
        ]);
        throw new \Exception('Payment URL not found in Midtrans response');
    }
    
    return $responseBody;
    
} catch (RequestException $e) {
    Log::error('Midtrans API request failed', [
        'error' => $e->getMessage(),
        'registration_code' => $registration->registration_code,
        'response' => $e->hasResponse() ? $e->getResponse()->getBody()->getContents() : null
    ]);
    throw new \Exception('Failed to connect to Midtrans: ' . $e->getMessage());
} catch (\Exception $e) {
    Log::error('Midtrans payment link generation failed', [
        'error' => $e->getMessage(),
        'registration_code' => $registration->registration_code
    ]);
    throw $e;
}
```

---

## 🟠 High Priority Issues

### Bug #3: Address Concatenation Bisa Null

**Lokasi:** `app/Helpers/MidtransUtils.php` baris 28

**Kode yang Bermasalah:**
```php
$address = $registration->address . ', ' . $registration->district . ', ' . $registration->province;
```

**Masalah:**
- Jika `district` atau `province` null, akan menghasilkan "Jl. Merdeka, null, null"
- Tidak user-friendly
- Bisa menyebabkan error di Midtrans API

**Dampak:**
- Address tidak valid di Midtrans
- User melihat "null" di alamat
- Potensi error saat Midtrans validasi data

**Solusi yang Disarankan:**
```php
$addressParts = array_filter([
    $registration->address,
    $registration->district,
    $registration->province
], function($part) {
    return !empty($part);
});

$address = implode(', ', $addressParts);

// Fallback jika semua null
if (empty($address)) {
    $address = 'Address not provided';
}
```

---

### Issue #4: Struktur Payload Tidak Lengkap

**Lokasi:** `app/Helpers/MidtransUtils.php` baris 48-82

**Masalah:**
Berdasarkan dokumentasi Midtrans Payment Link API, beberapa field penting mungkin kurang:

1. **`payment_link_id`** - Sudah di-comment, tapi bisa digunakan untuk tracking
2. **`enabled_payments`** - Tidak ada, padahal bisa digunakan untuk membatasi metode pembayaran
3. **`custom_field1`, `custom_field2`, `custom_field3`** - Bisa digunakan untuk tracking registration_code
4. **`whitelist_bins`** - Tidak ada, untuk whitelist kartu tertentu
5. **`credit_card`** - Tidak ada konfigurasi untuk 3DS, installment, dll

**Dampak:**
- Tidak bisa tracking payment link dengan ID khusus
- Tidak bisa membatasi metode pembayaran
- Tidak bisa custom field untuk tracking

**Solusi yang Disarankan:**
```php
$payload = [
    'transaction_details' => [
        'order_id' => $registration->registration_code,
        'gross_amount' => intval($finalPrice),  // ✅ Pastikan integer
    ],
    'payment_link_id' => 'reg-' . $registration->registration_code,  // ✅ Untuk tracking
    'usage_limit' => 1,
    'customer_details' => [
        'first_name' => $registration->full_name,
        'last_name' => '',  // ✅ Tambahkan jika ada
        'email' => $registration->email,
        'phone' => $registration->phone,
        'billing_address' => [
            'first_name' => $registration->full_name,
            'last_name' => '',
            'address' => $address,
            'city' => $registration->district ?? '',
            'postal_code' => '',  // ✅ Tambahkan jika ada
            'country_code' => 'IDN'
        ],
        'shipping_address' => [
            'first_name' => $registration->full_name,
            'last_name' => '',
            'address' => $address,
            'city' => $registration->district ?? '',
            'postal_code' => '',
            'country_code' => 'IDN'
        ],
    ],
    'expiry' => [
        'duration' => 1,
        'unit' => 'days'
    ],
    'item_details' => $itemDetails,
    'title' => $event->name . " ticket payment",
    'callbacks' => [
        'finish' => 'https://regtix.id/payment/finish/' . $registration->registration_code,
    ],
    'custom_field1' => $registration->registration_code,  // ✅ Tracking
    'custom_field2' => $registration->id,  // ✅ Tracking
    'custom_field3' => $event->id,  // ✅ Tracking
    // 'enabled_payments' => ['credit_card', 'gopay'],  // ✅ Optional: limit payment methods
];
```

---

## 🟡 Medium Priority Issues

### Issue #5: Tidak Ada Validasi Input

**Masalah:**
- Tidak ada validasi apakah `$registration` valid
- Tidak ada validasi apakah `$event` valid
- Tidak ada validasi apakah `$categoryTicketType` valid
- Tidak ada validasi apakah `$finalPrice` > 0 (seharusnya tidak dipanggil jika 0)

**Dampak:**
- Bisa error jika data tidak lengkap
- Bisa generate payment link untuk harga 0 (tidak seharusnya)

**Solusi yang Disarankan:**
```php
public static function generatePaymentLink($registration, $event)
{
    // Validasi input
    if (!$registration) {
        throw new \InvalidArgumentException('Registration is required');
    }
    
    if (!$event) {
        throw new \InvalidArgumentException('Event is required');
    }
    
    $categoryTicketType = $registration->categoryTicketType;
    if (!$categoryTicketType) {
        throw new \InvalidArgumentException('Category ticket type not found');
    }
    
    // Validasi final price
    $voucher = $registration->voucherCode->voucher ?? null;
    $finalPrice = $voucher ? floatval($voucher->final_price) : floatval($categoryTicketType->price);
    
    if ($finalPrice <= 0) {
        throw new \InvalidArgumentException('Final price must be greater than 0. Use skip payment flow instead.');
    }
    
    // Continue dengan proses...
}
```

---

### Issue #6: Gross Amount Tidak Validasi

**Masalah:**
- `gross_amount` di payload menggunakan `$finalPrice` yang bisa float
- Midtrans memerlukan integer (dalam rupiah, tanpa desimal)
- Tidak ada validasi apakah `gross_amount` sesuai dengan total `item_details`

**Dampak:**
- Midtrans bisa reject jika format salah
- Potensi mismatch antara gross_amount dan item_details total

**Solusi yang Disarankan:**
```php
// Pastikan gross_amount adalah integer (dalam rupiah)
$grossAmount = intval(round($finalPrice));

// Validasi total item_details sesuai dengan gross_amount
$itemTotal = 0;
foreach ($itemDetails as $item) {
    $itemTotal += intval($item['price']) * intval($item['quantity']);
}

if ($itemTotal !== $grossAmount) {
    Log::warning('Item total mismatch with gross amount', [
        'gross_amount' => $grossAmount,
        'item_total' => $itemTotal,
        'registration_code' => $registration->registration_code
    ]);
    // Adjust item details atau throw error
}

$payload = [
    'transaction_details' => [
        'order_id' => $registration->registration_code,
        'gross_amount' => $grossAmount,  // ✅ Integer
    ],
    // ...
];
```

---

## 📋 Checklist Compliance dengan Dokumentasi Midtrans

### ✅ Yang Sudah Benar

1. ✅ Menggunakan Basic Auth dengan base64 encoding
2. ✅ Struktur `transaction_details` dengan `order_id` dan `gross_amount`
3. ✅ Struktur `customer_details` dengan `first_name`, `email`, `phone`
4. ✅ Struktur `item_details` dengan `id`, `price`, `quantity`, `name`
5. ✅ Struktur `expiry` dengan `duration` dan `unit`
6. ✅ Struktur `callbacks` dengan `finish` URL

### ❌ Yang Perlu Diperbaiki

1. ❌ Assignment bug di line 44
2. ❌ Tidak ada error handling
3. ❌ Address concatenation bisa null
4. ❌ Gross amount tidak di-validasi sebagai integer
5. ❌ Tidak ada validasi input
6. ❌ Tidak ada logging untuk debugging
7. ❌ Tidak ada timeout untuk HTTP request
8. ❌ Tidak ada validasi response dari Midtrans

---

## 🎯 Rekomendasi Perbaikan

### Prioritas 1: Critical (Segera)
1. **Perbaiki assignment bug** di line 44
2. **Tambahkan error handling** dengan try-catch
3. **Tambahkan logging** untuk debugging

### Prioritas 2: High (1-2 Minggu)
4. **Perbaiki address concatenation** dengan null check
5. **Validasi gross_amount** sebagai integer
6. **Validasi response** dari Midtrans API

### Prioritas 3: Medium (1 Bulan)
7. **Tambahkan validasi input** di awal method
8. **Lengkapi payload** dengan custom_field untuk tracking
9. **Tambahkan timeout** untuk HTTP request

---

## 📚 Referensi

- [Midtrans Payment Link API Documentation](https://docs.midtrans.com/reference/payment-link-api)
- [Midtrans Error Handling](https://docs.midtrans.com/docs/error-code-response)
- [Midtrans API Reference](https://docs.midtrans.com/reference)

---

**Kesimpulan:** File `MidtransUtils.php` memiliki beberapa bug critical yang perlu diperbaiki, terutama error handling dan assignment bug. Setelah perbaikan, kode akan lebih robust dan sesuai dengan best practices Midtrans.














