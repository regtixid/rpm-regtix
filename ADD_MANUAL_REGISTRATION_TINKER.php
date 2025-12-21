use App\Models\Registration;
use App\Models\Event;
use App\Models\CategoryTicketType;
use App\Models\Category;
use App\Models\TicketType;
use App\Helpers\GenerateBib;
use App\Helpers\QrUtils;
use App\Helpers\EmailSender;

echo "=== MENAMBAHKAN REGISTRATION MANUAL ===\n\n";

// Data dari Midtrans
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

// 1. Cek apakah registration sudah ada
echo "1. Mengecek apakah registration sudah ada...\n";
$existingRegistration = Registration::where('registration_code', $registrationCode)->first();
if ($existingRegistration) {
    echo "   ⚠️  Registration dengan code '{$registrationCode}' sudah ada!\n";
    echo "   ID: {$existingRegistration->id}\n";
    echo "   Status: {$existingRegistration->status}\n";
    echo "   Payment Status: {$existingRegistration->payment_status}\n";
    echo "\n   Script dihentikan. Jika ingin melanjutkan, hapus registration yang ada terlebih dahulu.\n";
    exit;
}
echo "   ✅ Registration belum ada, lanjut...\n\n";

// 2. Cari Event dengan code_prefix KR26
echo "2. Mencari Event dengan code_prefix 'KR26'...\n";
$event = Event::where('code_prefix', 'KR26')->first();
if (!$event) {
    echo "   ❌ Event dengan code_prefix 'KR26' tidak ditemukan!\n";
    echo "   Event yang tersedia:\n";
    Event::all(['id', 'name', 'code_prefix'])->each(function($e) {
        echo "   - ID: {$e->id}, Name: {$e->name}, Prefix: {$e->code_prefix}\n";
    });
    exit;
}
echo "   ✅ Event ditemukan: {$event->name} (ID: {$event->id})\n\n";

// 3. Cari Category "5K" untuk event tersebut
echo "3. Mencari Category '{$categoryName}' untuk event '{$event->name}'...\n";
$category = Category::where('event_id', $event->id)
    ->where('name', $categoryName)
    ->first();
if (!$category) {
    echo "   ❌ Category '{$categoryName}' tidak ditemukan untuk event '{$event->name}'!\n";
    echo "   Category yang tersedia:\n";
    Category::where('event_id', $event->id)->get(['id', 'name'])->each(function($c) {
        echo "   - ID: {$c->id}, Name: {$c->name}\n";
    });
    exit;
}
echo "   ✅ Category ditemukan: {$category->name} (ID: {$category->id})\n\n";

// 4. Cari Ticket Type "Regular"
echo "4. Mencari Ticket Type '{$ticketTypeName}'...\n";
$ticketType = TicketType::where('name', $ticketTypeName)->first();
if (!$ticketType) {
    echo "   ❌ Ticket Type '{$ticketTypeName}' tidak ditemukan!\n";
    echo "   Ticket Type yang tersedia:\n";
    TicketType::all(['id', 'name'])->each(function($tt) {
        echo "   - ID: {$tt->id}, Name: {$tt->name}\n";
    });
    exit;
}
echo "   ✅ Ticket Type ditemukan: {$ticketType->name} (ID: {$ticketType->id})\n\n";

// 5. Cari Category Ticket Type ID
echo "5. Mencari Category Ticket Type untuk kombinasi Category '{$category->name}' dan Ticket Type '{$ticketType->name}'...\n";
$categoryTicketType = CategoryTicketType::where('category_id', $category->id)
    ->where('ticket_type_id', $ticketType->id)
    ->first();
if (!$categoryTicketType) {
    echo "   ❌ Category Ticket Type tidak ditemukan!\n";
    echo "   Category Ticket Type yang tersedia untuk Category '{$category->name}':\n";
    CategoryTicketType::where('category_id', $category->id)
        ->with('ticketType')
        ->get()
        ->each(function($ctt) {
            echo "   - ID: {$ctt->id}, Ticket Type: {$ctt->ticketType->name}\n";
        });
    exit;
}
echo "   ✅ Category Ticket Type ditemukan: ID {$categoryTicketType->id}, Price: {$categoryTicketType->price}\n\n";

// 6. Buat Registration
echo "6. Membuat Registration...\n";
$registration = Registration::create([
    'category_ticket_type_id' => $categoryTicketType->id,
    'full_name' => $fullName,
    'email' => $email,
    'phone' => $phone,
    'registration_code' => $registrationCode,
    'registration_date' => $transactionTime,
    'status' => 'pending',
    'payment_status' => 'pending',
    'reg_id' => '',
    'jersey_size' => 'DEFAULT',
]);
echo "   ✅ Registration dibuat dengan ID: {$registration->id}\n\n";

// 7. Hitung jumlah confirmed registrations untuk event tersebut
echo "7. Menghitung jumlah confirmed registrations untuk event '{$event->name}'...\n";
$count = Registration::where('status', 'confirmed')
    ->whereHas('categoryTicketType.category.event', function ($q) use ($event) {
        $q->where('event_id', $event->id);
    })
    ->count();
echo "   ✅ Jumlah confirmed registrations: {$count}\n\n";

// 8. Generate Reg ID
echo "8. Generate Reg ID...\n";
$regIdGenerator = new GenerateBib();
$regId = $regIdGenerator->generateRegId($count);
echo "   ✅ Reg ID: {$regId}\n\n";

// 9. Generate QR Code
echo "9. Generate QR Code...\n";
$qrGenerator = new QrUtils();
$qrPath = $qrGenerator->generateQr($registration);
echo "   ✅ QR Code path: {$qrPath}\n\n";

// 10. Update Registration dengan payment status
echo "10. Update Registration dengan payment status...\n";
$registration->update([
    'status' => 'confirmed',
    'payment_status' => 'paid',
    'transaction_code' => $transactionCode,
    'reg_id' => $regId,
    'paid_at' => $transactionTime,
    'payment_type' => $paymentType,
    'gross_amount' => $grossAmount,
    'qr_code_path' => $qrPath,
]);
echo "   ✅ Registration berhasil diupdate\n\n";

// 11. Kirim Email Konfirmasi (Optional - uncomment jika diperlukan)
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

// 12. Verifikasi
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

