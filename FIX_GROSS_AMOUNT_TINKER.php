use App\Models\Registration;

echo "=== CEK GROSS AMOUNT ===\n\n";

$registrationCode = 'RTIX-KR26-AF3ICX';
$updateAll = true; // Set true untuk update

function calculateCorrectGrossAmount($registration) {
    // Jika gross_amount = 0, gunakan harga tiket normal (bukan voucher final_price)
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

// Jika gross_amount = 0, ubah menjadi harga tiket normal
$needsFix = ($currentGrossAmount === null || $currentGrossAmount == 0) && $correctAmount > 0;

if ($needsFix) {
    echo "⚠️  PERLU DIPERBAIKI!\n";
    echo "   Current: " . ($currentGrossAmount === null ? 'NULL' : number_format($currentGrossAmount, 0, ',', '.')) . "\n";
    echo "   Will be updated to: " . number_format($correctAmount, 0, ',', '.') . " (harga tiket normal)\n";
    echo "\n";
    
    if ($updateAll) {
        $registration->update(['gross_amount' => $correctAmount]);
        echo "✅ gross_amount berhasil diupdate!\n";
        $registration->refresh();
        echo "\nVerifikasi:\n";
        echo "   gross_amount: " . number_format($registration->gross_amount, 0, ',', '.') . "\n";
    } else {
        echo "💡 Untuk update, set \$updateAll = true\n";
    }
} else if ($currentGrossAmount == 0 && $correctAmount == 0) {
    echo "⚠️  gross_amount = 0, akan diubah menjadi harga tiket normal\n";
    if ($registration->categoryTicketType && $updateAll) {
        $ticketPrice = floatval($registration->categoryTicketType->price);
        $registration->update(['gross_amount' => $ticketPrice]);
        echo "✅ gross_amount diupdate dari 0 menjadi " . number_format($ticketPrice, 0, ',', '.') . "\n";
        $registration->refresh();
        echo "\nVerifikasi:\n";
        echo "   gross_amount: " . number_format($registration->gross_amount, 0, ',', '.') . "\n";
    } else if ($registration->categoryTicketType) {
        echo "   Akan diubah menjadi: " . number_format($registration->categoryTicketType->price, 0, ',', '.') . "\n";
        echo "💡 Set \$updateAll = true untuk update\n";
    }
} else if ($currentGrossAmount == $correctAmount) {
    echo "✅ gross_amount sudah BENAR\n";
} else {
    echo "⚠️  gross_amount tidak sesuai!\n";
    echo "   Current: " . ($currentGrossAmount === null ? 'NULL' : number_format($currentGrossAmount, 0, ',', '.')) . "\n";
    echo "   Expected: " . number_format($correctAmount, 0, ',', '.') . "\n";
    echo "   Difference: " . number_format(abs($currentGrossAmount - $correctAmount), 0, ',', '.') . "\n";
}

echo "\n=== SELESAI ===\n";

