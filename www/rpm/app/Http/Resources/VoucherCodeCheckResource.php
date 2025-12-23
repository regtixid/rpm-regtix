<?php

namespace App\Http\Resources;

use App\Models\CategoryTicketType;
use Illuminate\Http\Resources\Json\JsonResource;

class VoucherCodeCheckResource extends JsonResource
{
    public function toArray($request)
    {
        $voucher = $this->voucher;
        // #region agent log
        file_put_contents('d:\REGTIX\.cursor\debug.log', json_encode(['sessionId'=>'debug-session','runId'=>'run1','hypothesisId'=>'C','location'=>'VoucherCodeCheckResource.php:13','message'=>'Before accessing categoryTicketType->ticketType','data'=>['voucher_exists'=>!is_null($voucher),'category_ticket_type_exists'=>!is_null($voucher?->categoryTicketType)],'timestamp'=>time()*1000])."\n", FILE_APPEND);
        // #endregion
        $ticketType = $voucher?->categoryTicketType?->ticketType;
        $categoryTicketType = $voucher?->categoryTicketType;
        $isUsed = (bool) $this->used;
        if ($voucher) {
            $finalPrice = $voucher->final_price;
        } else {
            $finalPrice = $categoryTicketType?->price ?? 0;
        }


        $categoryTicketTypeWithCount = $categoryTicketType ? CategoryTicketType::withCount('registrations')->find($categoryTicketType->id) : null;
        $used = $categoryTicketTypeWithCount?->registrations_count ?? 0;
        return [
            'code' => $this->code,
            'is_used' => $isUsed,
            'is_valid' => !$isUsed, // valid jika belum digunakan
            'voucher' => [
                'id' => $voucher?->id,
                'name' => $voucher?->name,
                'final_price' => $voucher?->final_price,
                'is_multiple_use' => $voucher?->is_multiple_use,
                'max_usage' => $voucher?->max_usage
            ],

            'ticket_type' => ($ticketType && $categoryTicketType) ? [
                'id' => $ticketType->id,
                'name' => $ticketType->name,
                'price' => $categoryTicketType->price,
                'quota' => $categoryTicketType->quota,
                'used' => $used,
                'remaining' => $categoryTicketType->quota - $used,
                'valid_from' => $categoryTicketType->valid_from,
                'valid_until' => $categoryTicketType->valid_until,
                'final_price' => $finalPrice,
            ] : null,
        ];
    }
}
