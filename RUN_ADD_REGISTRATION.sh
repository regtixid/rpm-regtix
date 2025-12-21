#!/bin/bash
# Script untuk menjalankan add registration langsung di server
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
use App\Models\Event;
use App\Models\CategoryTicketType;
use App\Models\Category;
use App\Models\TicketType;
use App\Helpers\GenerateBib;
use App\Helpers\QrUtils;
use App\Helpers\EmailSender;
use Carbon\Carbon;

echo "=== MENAMBAHKAN REGISTRATION MANUAL ===\n\n";

$registrationCode = 'RTIX-KR26-0ZXEFA';
$fullName = 'Anak Agung Gde Rai Semara Putra';
$email = 'aagderaisemaraputra@gmail.com';
$phone = '+6281339999815';
$transactionCode = 'dcb0e263-0f08-421b-93cf-d2521ff166aa';
$paymentType = 'bank_transfer';
$grossAmount = 224440.00;
$transactionTime = '2025-11-27 09:30:01';
$categoryName = '5K';
$ticketTypeName = 'Regular';

echo "1. Mengecek apakah registration sudah ada...\n";
$existingRegistration = Registration::where('registration_code', $registrationCode)->first();
if ($existingRegistration) {
    echo "   ⚠️  Registration dengan code '{$registrationCode}' sudah ada!\n";
    echo "   ID: {$existingRegistration->id}\n";
    echo "   Status: {$existingRegistration->status}\n";
    echo "   Payment Status: {$existingRegistration->payment_status}\n";
    echo "\n   Script dihentikan.\n";
    exit;
}
echo "   ✅ Registration belum ada, lanjut...\n\n";

echo "2. Mencari Event dengan code_prefix 'KR26'...\n";
$event = Event::where('code_prefix', 'KR26')->first();
if (!$event) {
    echo "   ❌ Event dengan code_prefix 'KR26' tidak ditemukan!\n";
    Event::all(['id', 'name', 'code_prefix'])->each(function($e) {
        echo "   - ID: {$e->id}, Name: {$e->name}, Prefix: {$e->code_prefix}\n";
    });
    exit;
}
echo "   ✅ Event ditemukan: {$event->name} (ID: {$event->id})\n\n";

echo "3. Mencari Category '{$categoryName}' untuk event '{$event->name}'...\n";
$category = Category::where('event_id', $event->id)->where('name', $categoryName)->first();
if (!$category) {
    echo "   ❌ Category '{$categoryName}' tidak ditemukan!\n";
    Category::where('event_id', $event->id)->get(['id', 'name'])->each(function($c) {
        echo "   - ID: {$c->id}, Name: {$c->name}\n";
    });
    exit;
}
echo "   ✅ Category ditemukan: {$category->name} (ID: {$category->id})\n\n";

echo "4. Mencari Ticket Type '{$ticketTypeName}'...\n";
$ticketType = TicketType::where('name', $ticketTypeName)->first();
if (!$ticketType) {
    echo "   ❌ Ticket Type '{$ticketTypeName}' tidak ditemukan!\n";
    TicketType::all(['id', 'name'])->each(function($tt) {
        echo "   - ID: {$tt->id}, Name: {$tt->name}\n";
    });
    exit;
}
echo "   ✅ Ticket Type ditemukan: {$ticketType->name} (ID: {$ticketType->id})\n\n";

echo "5. Mencari Category Ticket Type...\n";
$categoryTicketType = CategoryTicketType::where('category_id', $category->id)
    ->where('ticket_type_id', $ticketType->id)
    ->first();
if (!$categoryTicketType) {
    echo "   ❌ Category Ticket Type tidak ditemukan!\n";
    exit;
}
echo "   ✅ Category Ticket Type ditemukan: ID {$categoryTicketType->id}, Price: {$categoryTicketType->price}\n\n";

echo "6. Membuat Registration...\n";
$registration = Registration::create([
    'category_ticket_type_id' => $categoryTicketType->id,
    'full_name' => $fullName,
    'email' => $email,
    'phone' => $phone,
    'registration_code' => $registrationCode,
    'registration_date' => Carbon::parse($transactionTime),
    'status' => 'pending',
    'payment_status' => 'pending',
    'reg_id' => '',
]);
echo "   ✅ Registration dibuat dengan ID: {$registration->id}\n\n";

echo "7. Menghitung jumlah confirmed registrations...\n";
$count = Registration::where('status', 'confirmed')
    ->whereHas('categoryTicketType.category.event', function ($q) use ($event) {
        $q->where('event_id', $event->id);
    })
    ->count();
echo "   ✅ Jumlah confirmed registrations: {$count}\n\n";

echo "8. Generate Reg ID...\n";
$regIdGenerator = new GenerateBib();
$regId = $regIdGenerator->generateRegId($count);
echo "   ✅ Reg ID: {$regId}\n\n";

echo "9. Generate QR Code...\n";
$qrGenerator = new QrUtils();
$qrPath = $qrGenerator->generateQr($registration);
echo "   ✅ QR Code path: {$qrPath}\n\n";

echo "10. Update Registration dengan payment status...\n";
$registration->update([
    'status' => 'confirmed',
    'payment_status' => 'paid',
    'transaction_code' => $transactionCode,
    'reg_id' => $regId,
    'paid_at' => Carbon::parse($transactionTime),
    'payment_type' => $paymentType,
    'gross_amount' => $grossAmount,
    'qr_code_path' => $qrPath,
]);
echo "   ✅ Registration berhasil diupdate\n\n";

echo "11. Mengirim email konfirmasi...\n";
try {
    $emailSender = new EmailSender();
    $subject = $event->name . ' - Your Print-At-Home Tickets have arrived! - Do Not Reply';
    $template = file_get_contents(resource_path('email/templates/e-ticket.html'));
    $emailSender->sendEmail($registration, $subject, $template);
    echo "   ✅ Email konfirmasi berhasil dikirim ke {$email}\n\n";
} catch (\Exception $e) {
    echo "   ⚠️  Gagal mengirim email: {$e->getMessage()}\n\n";
}

echo "=== VERIFIKASI ===\n";
$verification = Registration::where('registration_code', $registrationCode)
    ->with(['categoryTicketType.category', 'categoryTicketType.ticketType'])
    ->first();

echo "Registration Code: {$verification->registration_code}\n";
echo "Nama: {$verification->full_name}\n";
echo "Email: {$verification->email}\n";
echo "Phone: {$verification->phone}\n";
echo "Status: {$verification->status}\n";
echo "Payment Status: {$verification->payment_status}\n";
echo "Reg ID: {$verification->reg_id}\n";
echo "Transaction Code: {$verification->transaction_code}\n";
echo "Gross Amount: {$verification->gross_amount}\n";
echo "Paid At: {$verification->paid_at}\n";
echo "QR Code Path: {$verification->qr_code_path}\n";
echo "Category: {$verification->categoryTicketType->category->name}\n";
echo "Ticket Type: {$verification->categoryTicketType->ticketType->name}\n";
echo "Event: {$verification->categoryTicketType->category->event->name}\n";

echo "\n✅ Selesai! Registration berhasil ditambahkan.\n";
PHP_SCRIPT



