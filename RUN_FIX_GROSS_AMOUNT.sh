#!/bin/bash
# Script untuk cek gross_amount satu tiket spesifik
# Cara pakai: copy semua baris di bawah ini dan paste di Termius

# Step 1: Cari path project
echo "Mencari lokasi project..."
FOUND_PATH=$(find /var/www /home -name "artisan" -type f 2>/dev/null | head -1 | xargs dirname)

if [ -z "$FOUND_PATH" ]; then
    echo "❌ Project tidak ditemukan. Coba jalankan manual:"
    echo "find /var/www -name artisan -type f"
    exit 1
fi

echo "✅ Project ditemukan di: $FOUND_PATH"
cd "$FOUND_PATH"

# Step 2: Jalankan dengan tinker menggunakan heredoc
php artisan tinker << 'PHP_SCRIPT'
use App\Models\Registration;

echo "=== CEK GROSS AMOUNT ===\n\n";

$registrationCode = 'RTIX-KR26-AF3ICX';
$updateAll = false;

function calculateCorrectGrossAmount($registration) {
    if ($registration->voucherCode && $registration->voucherCode->voucher) {
        return floatval($registration->voucherCode->voucher->final_price);
    }
    if ($registration->categoryTicketType) {
        return floatval($registration->categoryTicketType->price);
    }
    return 0;
}

echo "=== CEK TIKET: {$registrationCode} ===\n\n";

$registration = Registration::with(['voucherCode.voucher', 'categoryTicketType.category', 'categoryTicketType.ticketType'])
    ->where('registration_code', $registrationCode)
    ->first();

if (!$registration) {
    echo "❌ Registration dengan code '{$registrationCode}' tidak ditemukan!\n";
    exit;
}

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

if ($registration->categoryTicketType) {
    echo "=== INFORMASI TIKET ===\n";
    echo "   Category: {$registration->categoryTicketType->category->name}\n";
    echo "   Ticket Type: {$registration->categoryTicketType->ticketType->name}\n";
    echo "   Ticket Price: " . number_format($registration->categoryTicketType->price, 0, ',', '.') . "\n";
    echo "\n";
}

if ($registration->voucherCode && $registration->voucherCode->voucher) {
    echo "=== INFORMASI VOUCHER ===\n";
    echo "   Voucher Code: {$registration->voucherCode->code}\n";
    echo "   Voucher Name: {$registration->voucherCode->voucher->name}\n";
    echo "   Final Price: " . number_format($registration->voucherCode->voucher->final_price, 0, ',', '.') . "\n";
    echo "   Is Multiple Use: " . ($registration->voucherCode->voucher->is_multiple_use ? 'Yes' : 'No') . "\n";
    echo "\n";
}

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
        echo "💡 Untuk update, set \$updateAll = true di script\n";
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
PHP_SCRIPT
