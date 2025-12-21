<?php
/**
 * Script untuk memperbaiki gross_amount yang 0 atau NULL pada registrasi yang sudah paid
 * 
 * Cara menjalankan:
 * 1. Untuk cek semua: php artisan tinker < FIX_GROSS_AMOUNT.php
 * 2. Atau copy-paste ke tinker
 * 
 * Untuk update satu registrasi spesifik, ubah $registrationCode di bawah
 */

use App\Models\Registration;

echo "=== FIX GROSS AMOUNT SCRIPT ===\n\n";

// ============================================
// CEK SATU TIKET SPESIFIK
// ============================================
$registrationCode = 'RTIX-KR26-AF3ICX'; // Registration code yang ingin dicek
$updateAll = false; // false = hanya cek, true = update jika perlu

// ============================================
// LOGIKA PERBAIKAN
// ============================================

function calculateCorrectGrossAmount($registration) {
    // Prioritaskan voucher->final_price jika ada voucher
    if ($registration->voucherCode && $registration->voucherCode->voucher) {
        return floatval($registration->voucherCode->voucher->final_price);
    }
    
    // Fallback ke harga normal tiket
    if ($registration->categoryTicketType) {
        return floatval($registration->categoryTicketType->price);
    }
    
    return 0;
}


// ============================================
// EKSEKUSI - CEK SATU TIKET
// ============================================

echo "=== CEK TIKET: {$registrationCode} ===\n\n";

$registration = Registration::with(['voucherCode.voucher', 'categoryTicketType.category', 'categoryTicketType.ticketType'])
    ->where('registration_code', $registrationCode)
    ->first();

if (!$registration) {
    echo "❌ Registration dengan code '{$registrationCode}' tidak ditemukan!\n";
    exit;
}

// Informasi Registrasi
echo "=== INFORMASI REGISTRASI ===\n";
echo "   Registration Code: {$registration->registration_code}\n";
echo "   ID: {$registration->id}\n";
echo "   Nama: {$registration->full_name}\n";
echo "   Email: {$registration->email}\n";
echo "   Phone: {$registration->phone}\n";
echo "   Status: {$registration->status}\n";
echo "   Payment Status: {$registration->payment_status}\n";
echo "   Transaction Code: " . ($registration->transaction_code ?? 'NULL') . "\n";
echo "   Paid At: " . ($registration->paid_at ?? 'NULL') . "\n";
echo "   Payment Type: " . ($registration->payment_type ?? 'NULL') . "\n";
echo "\n";

// Informasi Tiket
if ($registration->categoryTicketType) {
    echo "=== INFORMASI TIKET ===\n";
    echo "   Category: {$registration->categoryTicketType->category->name}\n";
    echo "   Ticket Type: {$registration->categoryTicketType->ticketType->name}\n";
    echo "   Ticket Price: " . number_format($registration->categoryTicketType->price, 0, ',', '.') . "\n";
    echo "\n";
}

// Informasi Voucher
if ($registration->voucherCode && $registration->voucherCode->voucher) {
    echo "=== INFORMASI VOUCHER ===\n";
    echo "   Voucher Code: {$registration->voucherCode->code}\n";
    echo "   Voucher Name: {$registration->voucherCode->voucher->name}\n";
    echo "   Final Price: " . number_format($registration->voucherCode->voucher->final_price, 0, ',', '.') . "\n";
    echo "   Is Multiple Use: " . ($registration->voucherCode->voucher->is_multiple_use ? 'Yes' : 'No') . "\n";
    echo "\n";
}

// Cek Gross Amount
echo "=== CEK GROSS AMOUNT ===\n";
$currentGrossAmount = $registration->gross_amount;
$correctAmount = calculateCorrectGrossAmount($registration);

echo "   Current gross_amount: " . ($currentGrossAmount === null ? 'NULL' : number_format($currentGrossAmount, 0, ',', '.')) . "\n";
echo "   Correct gross_amount: " . number_format($correctAmount, 0, ',', '.') . "\n";
echo "\n";

$needsFix = ($currentGrossAmount === null || $currentGrossAmount == 0) && $correctAmount > 0;

if ($needsFix) {
    echo "⚠️  PERLU DIPERBAIKI!\n";
    echo "   Current: " . ($currentGrossAmount === null ? 'NULL' : number_format($currentGrossAmount, 0, ',', '.')) . "\n";
    echo "   Should be: " . number_format($correctAmount, 0, ',', '.') . "\n";
    echo "\n";
    
    if ($updateAll) {
        $registration->update(['gross_amount' => $correctAmount]);
        echo "✅ gross_amount berhasil diupdate!\n";
        
        $registration->refresh();
        echo "\nVerifikasi:\n";
        echo "   gross_amount: " . number_format($registration->gross_amount, 0, ',', '.') . "\n";
    } else {
        echo "💡 Untuk update, ubah \$updateAll = true di script ini\n";
    }
} else if ($currentGrossAmount == 0 && $correctAmount == 0) {
    echo "✅ gross_amount = 0 adalah BENAR (voucher gratis)\n";
} else if ($currentGrossAmount == $correctAmount) {
    echo "✅ gross_amount sudah BENAR\n";
} else {
    echo "⚠️  gross_amount tidak sesuai!\n";
    echo "   Current: " . ($currentGrossAmount === null ? 'NULL' : number_format($currentGrossAmount, 0, ',', '.')) . "\n";
    echo "   Expected: " . number_format($correctAmount, 0, ',', '.') . "\n";
    echo "   Difference: " . number_format(abs($currentGrossAmount - $correctAmount), 0, ',', '.') . "\n";
}

echo "\n=== SELESAI ===\n";

