use App\Models\Registration;

$registrationCode = 'RTIX-KR26-AF3ICX';

echo "=== UPDATE GROSS AMOUNT ===\n\n";

$registration = Registration::with(['categoryTicketType'])
    ->where('registration_code', $registrationCode)
    ->first();

if (!$registration) {
    echo "❌ Registration tidak ditemukan!\n";
    exit;
}

echo "Registration Code: {$registration->registration_code}\n";
echo "Nama: {$registration->full_name}\n";
echo "Current gross_amount: " . ($registration->gross_amount ?? 'NULL') . "\n";

if ($registration->categoryTicketType) {
    $ticketPrice = floatval($registration->categoryTicketType->price);
    echo "Ticket Price: " . number_format($ticketPrice, 0, ',', '.') . "\n\n";
    
    if ($registration->gross_amount == 0 || $registration->gross_amount === null) {
        $registration->update(['gross_amount' => $ticketPrice]);
        $registration->refresh();
        
        echo "✅ gross_amount berhasil diupdate!\n";
        echo "   From: " . ($registration->gross_amount == 0 ? '0' : 'NULL') . "\n";
        echo "   To: " . number_format($registration->gross_amount, 0, ',', '.') . "\n";
    } else {
        echo "⚠️  gross_amount sudah ada: " . number_format($registration->gross_amount, 0, ',', '.') . "\n";
        echo "   Tidak diupdate karena sudah ada nilai.\n";
    }
} else {
    echo "❌ Tidak bisa mendapatkan harga tiket!\n";
}

echo "\n=== SELESAI ===\n";



