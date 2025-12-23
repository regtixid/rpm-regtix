<?php

namespace App\Http\Controllers\Api;

use App\Helpers\EmailSender;
use App\Helpers\GenerateBib;
use App\Helpers\MidtransUtils;
use App\Helpers\QrUtils;
use App\Http\Controllers\Controller;
use App\Http\Requests\StoreRegistrationRequest;
use App\Models\CategoryTicketType;
use App\Models\Event;
use App\Models\Registration;
use App\Models\VoucherCode;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class RegistrationController extends Controller
{
    public function store(StoreRegistrationRequest $request)
    {
        try {
            $data = $request->validated();
            $event = Event::find($data['event_id']);

            if (!$event) {
                return response()->json(['message' => 'Event not found.'], 404);
            }

            // ==== CEK REGISTRATION DUPLIKAT ====
            $registran = Registration::where('email', $data['email'])
                ->where('category_ticket_type_id', $data['category_ticket_type_id'])
                ->where('id_card_number', $data['id_card_number'])
                ->with([
                    'categoryTicketType.ticketType',
                    'categoryTicketType.category',
                    'categoryTicketType.category.event',
                    'voucherCode.voucher'
                ])
                ->first();

            if ($registran) {
                // Jika payment_url null → delete registrasi agar bisa daftar ulang
                if (!$registran->payment_url) {
                    if ($registran->voucherCode) {
                        $registran->voucherCode->update(['used' => false]);
                    }
                    $registran->delete();
                } else {
                    $res = $registran->makeHidden('category_ticket_type')->toArray();
                    $res['payment_url'] = $registran->payment_status === 'paid' 
                        ? "https://regtix.id/payment/finish/{$registran->registration_code}" 
                        : $registran->payment_url;

                    return response()->json([
                        'message' => $registran->payment_status === 'paid' 
                            ? 'Registration exists' 
                            : 'Registration pending exists',
                        'data' => $res
                    ], $registran->payment_status === 'paid' ? 201 : 200);
                }
            }


            // ==== VALIDASI VOUCHER DAN CREATE REGISTRATION DALAM TRANSACTION ====
            $voucherCode = null;
            $voucher = null;
            $voucherValid = false;
            $finalPrice = 0;
            // Perbaikan: Load categoryTicketType dengan withCount untuk menghindari bug registrations_count
            $categoryTicketType = CategoryTicketType::withCount('registrations')
                ->find($data['category_ticket_type_id']);
            
            if (!$categoryTicketType) {
                return response()->json(['message' => 'Category ticket type not found.'], 404);
            }
            
            $ticketType = $categoryTicketType->ticketType;
            
            // Perbaikan: Validasi ticketType tidak null
            if (!$ticketType) {
                return response()->json(['message' => 'Ticket type not found for this category ticket type.'], 404);
            }

            // Wrap voucher validation and registration creation in transaction
            try {
                $registration = DB::transaction(function () use ($data, $event, &$voucherCode, &$voucher, &$voucherValid, &$finalPrice, $categoryTicketType, $ticketType) {
                    // Perbaikan: Pindahkan pengecekan quota ke dalam transaction dengan lock untuk prevent race condition
                    $categoryTicketTypeLocked = CategoryTicketType::lockForUpdate()
                        ->withCount(['registrations' => function ($query) {
                            $query->where('payment_status', 'paid');
                        }])
                        ->find($categoryTicketType->id);
                    
                    $quota = $categoryTicketTypeLocked->quota;
                    $used = $categoryTicketTypeLocked->registrations_count ?? 0;
                    $remaining = max($quota - $used, 0);

                    // Jika quota sudah habis → throw exception
                    if ($remaining <= 0) {
                        throw new \Exception('Quota untuk kategori ini sudah habis. Silahkan daftar pada kategori lain');
                    }
                    
                    if (!empty($data['voucher_code'])) {
                        // Lock voucher code row to prevent race condition
                        $voucherCode = VoucherCode::where('code', $data['voucher_code'])
                            ->lockForUpdate()
                            ->with('voucher')
                            ->first();

                        if (!$voucherCode) {
                            throw new \Exception('Voucher code not found.');
                        }

                        $voucher = $voucherCode->voucher;

                        if (!$voucher) {
                            throw new \Exception('Voucher data invalid.');
                        }

                        // ==== Hitung penggunaan voucher dengan lock untuk prevent race condition ====
                        // Perbaikan: Hanya hitung registrasi yang sudah paid, bukan semua registrasi
                        // Voucher hanya terhitung digunakan ketika pembayaran berhasil
                        $usedCount = $voucherCode->registrations()->where('payment_status', 'paid')->count();

                        if ($voucher->is_multiple_use) {
                            $voucherValid = $usedCount < $voucher->max_usage;
                        } else {
                            $voucherValid = !$voucherCode->used;
                        }

                        if (!$voucherValid) {
                            throw new \Exception('Voucher code already used or expired.');
                        }
                    }

                    // ==== Hitung harga final ====
                    if ($voucherValid && $voucher) {
                        $finalPrice = floatval($voucher->final_price);
                    } else {
                        $finalPrice = floatval($categoryTicketType->price);
                    }

                    // ==== CREATE REGISTRATION ====
                    $registrationData = $data;
                    $registrationData['registration_code'] = 'RTIX-' . $event->code_prefix . '-' . strtoupper(Str::random(6));
                    $registrationData['registration_date'] = Carbon::now();
                    $registrationData['status'] = 'pending';
                    $registrationData['payment_status'] = 'pending';
                    $registrationData['reg_id'] = "";

                    // Assign voucher ke registration jika valid
                    if ($voucherValid && $voucherCode) {
                        $registrationData['voucher_code_id'] = $voucherCode->id;
                    }

                    $registration = Registration::create($registrationData);

                    return $registration;
                });
            } catch (\Exception $e) {
                $message = $e->getMessage();
                $statusCode = 500;
                
                if (str_contains($message, 'Voucher code not found')) {
                    $statusCode = 404;
                } elseif (str_contains($message, 'Voucher data invalid')) {
                    $statusCode = 404;
                } elseif (str_contains($message, 'already used or expired')) {
                    $statusCode = 400;
                } elseif (str_contains($message, 'Quota untuk kategori ini sudah habis')) {
                    $statusCode = 409;
                }
                
                return response()->json(['message' => $message], $statusCode);
            }

            // ==== SIAPKAN RESPONSE ====
            $regData = $registration->makeHidden('category_ticket_type')->toArray();

            $regData['category'] = $categoryTicketType->category->toArray();
            $regData['category']['event'] = $event->toArray();

            $regData['voucher_code'] = $voucherCode ? [
                ...$voucherCode->toArray(),
                'valid' => $voucherValid
            ] : null;

            // Perbaikan: Refresh categoryTicketType untuk mendapatkan registrations_count yang ter-update
            $categoryTicketType->refresh();
            $categoryTicketType->loadCount(['registrations' => function ($query) {
                $query->where('payment_status', 'paid');
            }]);
            
            $regData['ticket_type'] = [
                'name' => $ticketType->name,
                'price' => $categoryTicketType->price,
                'quota' => $categoryTicketType->quota,
                'used' => $categoryTicketType->registrations_count ?? 0,
                'remaining' => $categoryTicketType->quota - ($categoryTicketType->registrations_count ?? 0),
                'valid_from' => $categoryTicketType->valid_from,
                'valid_until' => $categoryTicketType->valid_until,
                'final_price' => $finalPrice,
            ];

            // ==== FREE (final_price = 0) → langsung confirmed ====
            if ($finalPrice == 0) {
                // Perbaikan: Gunakan transaction untuk prevent race condition pada generateRegId dan voucher update
                DB::transaction(function () use ($registration, $event, $voucher, $voucherCode, &$regData) {
                    // Perbaikan: Lock untuk prevent race condition saat generate reg_id
                    $count = Registration::lockForUpdate()
                        ->where('category_ticket_type_id', $registration->category_ticket_type_id)
                        ->where('status', 'confirmed')
                        ->count();

                    $regIdGenerator = new GenerateBib();
                    $qrGenerator = new QrUtils();

                    $regId = $regIdGenerator->generateRegId($count);
                    $qrPath = $qrGenerator->generateQr($registration);

                    $registration->update([
                        'status' => 'confirmed',
                        'payment_status' => 'paid',
                        'paid_at' => now(),
                        'payment_type' => '',
                        'gross_amount' => 0,
                        'qr_code_path' => $qrPath,
                        'reg_id' => $regId
                    ]);

                    // Perbaikan: Update voucher code dalam transaction untuk prevent race condition
                    if ($voucher && $voucherCode && !$voucher->is_multiple_use) {
                        $voucherCode->lockForUpdate();
                        $voucherCode->used = true;
                        $voucherCode->save();
                    }
                });

                $subject = $event->name . ' - Your Print-At-Home Tickets have arrived! - Do Not Reply';
                $template = file_get_contents(resource_path('email/templates/e-ticket.html'));
                
                // Refresh registration untuk mendapatkan reg_id yang baru
                $registration->refresh();
                $regData['payment_url'] = "https://regtix.id/payment/finish/{$registration->registration_code}";

            } else {
                // ==== NOT FREE → PAYMENT LINK ====
                $midtrans = new MidtransUtils();
                $paymment = $midtrans->generatePaymentLink($registration, $event);

                $regData['payment_url'] = $paymment['payment_url'];
                $registration->update(['payment_url' => $paymment['payment_url']]);

                $subject = '[' . $event->name . '] Tagihan Pembayaran - Do Not Reply';
                $template = file_get_contents(resource_path('email/templates/payment-instruction.html'));
            }

            // ==== SEND EMAIL ====
            $email = new EmailSender();
            $email->sendEmail($registration, $subject, $template);

            return response()->json([
                'message' => 'Registration successful.',
                'data' => $regData
            ], 201);

        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function checkRegistration(Request $request)
    {
        try {

            $reg = Registration::where('registration_code', $request->registration_code)
                ->with(['categoryTicketType.ticketType', 'categoryTicketType.category', 'categoryTicketType.category.event', 'voucherCode.voucher'])
                ->first();

            if (!$reg) {
                return response()->json([
                    'message' => 'Registration not found.'
                ], 404);
            }

            $data = [
                ...$reg->toArray(),
                'category_ticket_type' => [
                    ...$reg->categoryTicketType->toArray(),
                    'ticket_type' => [
                        ...$reg->categoryTicketType->ticketType->toArray(),
                    ],
                    'category' => [
                        ...$reg->categoryTicketType->category->toArray(),
                        'event' => [
                            ...$reg->categoryTicketType->category->event->toArray(),
                            'event_logo' => asset('storage/' . $reg->categoryTicketType->category->event->event_logo),
                            'event_banner' => asset('storage/' . $reg->categoryTicketType->category->event->event_banner)
                        ]
                    ]
                ]
            ];
            return response()->json([
                'message' => 'Registration found.',
                'data' => $data
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
