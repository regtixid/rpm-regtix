use App\Models\Registration;

echo "=== UPDATE JERSEY SIZE KE DEFAULT ===\n\n";

$registrationCode = 'RTIX-KR26-0ZXEFA';

echo "Mencari registration dengan code: {$registrationCode}...\n";
$registration = Registration::where('registration_code', $registrationCode)->first();

if (!$registration) {
    echo "❌ Registration tidak ditemukan!\n";
    exit;
}

echo "✅ Registration ditemukan:\n";
echo "   ID: {$registration->id}\n";
echo "   Nama: {$registration->full_name}\n";
echo "   Jersey Size (sebelum): " . ($registration->jersey_size ?? 'NULL') . "\n\n";

echo "Mengupdate jersey_size ke 'DEFAULT'...\n";
$registration->update([
    'jersey_size' => 'DEFAULT'
]);

echo "✅ Jersey size berhasil diupdate!\n\n";

// Verifikasi
$updated = Registration::find($registration->id);
echo "=== VERIFIKASI ===\n";
echo "Jersey Size (sesudah): {$updated->jersey_size}\n";
echo "\n✅ Selesai!\n";



