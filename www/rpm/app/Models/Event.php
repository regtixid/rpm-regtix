<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use App\Models\Registration;


class Event extends Model
{
    const STATUS = [
        'OPEN' => 'OPEN',
        'CLOSED' => 'CLOSED',
        'TBA' => 'TBA',
        'TC' => 'TEMPORARY CLOSED'
    ];

    const SIZE = [
        'Large' => 'Large',
        'Medium' => 'Medium',
        'Small' => 'Small'
    ];

    protected $fillable = [
        'name',
        'start_date',
        'end_date',
        'location',
        'location_gmaps_url',
        'code_prefix',
        'registration_start_date',
        'registration_end_date',
        'description',
        'rpc_start_date',
        'rpc_end_date',
        'rpc_collection_times',
        'rpc_collection_location',
        'rpc_collection_gmaps_url',
        'event_url',
        'ig_url',
        'fb_url',
        'contact_email',
        'contact_phone',
        'event_owner',
        'event_organizer',
        'event_logo',
        'event_banner',
        'jersey_size_image',
        'slug',
        'status',
        'size'
    ];


    public function registrations()
    {
        // Perbaikan: hasManyThrough hanya mendukung satu tabel intermediate
        // Jalur yang benar: Event -> Category -> CategoryTicketType -> Registration
        // Karena Laravel's hasManyThrough tidak bisa menangani multiple tabel intermediate,
        // kita menggunakan query-based relationship yang menggabungkan melalui chain dengan benar
        // Ini mengembalikan query builder yang memfilter registrasi untuk event ini
        // Catatan: Ini bukan relasi Eloquent sejati tapi berfungsi untuk query
        return Registration::whereHas('categoryTicketType.category', function ($query) {
            $query->where('event_id', $this->id);
        });
    }

    public function campaigns()
    {
        return $this->hasMany(Campaign::class);
    }

    public function categories()
    {
        return $this->hasMany(Category::class);
    }

    public function users()
    {
        return $this->belongsToMany(User::class);
    }

    public function slides(){
        return $this->hasMany(EventSlide::class);
    }

    protected static function boot()
    {
        parent::boot();
        
        static::creating(function ($event) {
            if (empty($event->slug)) {
                $event->slug = Str::slug($event->name);
            }
        });

        static::created(function ($event) {
            // Pindah logo, banner, jersey
            foreach ([
                'event_logo' => 'image/event/logo',
                'event_banner' => 'image/event/banner',
                'jersey_size_image' => 'image/event/jersey-size',
            ] as $column => $folder) {
                $oldPath = $event->{$column};
                if (!empty($oldPath) && is_string($oldPath)) {
                    $newPath = "{$folder}/{$event->id}/" . basename($oldPath);

                    if (Storage::disk('public')->exists($oldPath)) {
                        Storage::disk('public')->move($oldPath, $newPath);
                        $event->updateQuietly([$column => $newPath]);
                    }
                }
            }
        });

        static::updating(function ($event) {
            // hanya jika name berubah
            if (empty($event->slug) || $event->isDirty('name')) {
                $event->slug = Str::slug($event->name);
            }
        });

        // static::saved(function ($event) {
        //     if ($event->slides()->exists()) {
        //         foreach ($event->slides as $slide) {
        //             $oldSlidePath = $slide->image_path;

        //             // Lewati jika sudah di folder final
        //             if (str_starts_with($oldSlidePath, "image/event/slides/{$event->id}/")) {
        //                 continue;
        //             }

        //             if (!empty($oldSlidePath) && is_string($oldSlidePath)) {
        //                 $newSlidePath = "image/event/slides/{$event->id}/" . basename($oldSlidePath);

        //                 if (Storage::disk('public')->exists($oldSlidePath)) {
        //                     Storage::disk('public')->move($oldSlidePath, $newSlidePath);
        //                     $slide->updateQuietly(['image_path' => $newSlidePath]);
        //                 }
        //             }
        //         }
        //     }
        // });
    }
}
