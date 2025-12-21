<?php
/**
 * Script untuk check event_id dan event_name dari user
 * Jalankan: php CHECK_USER_EVENT.php
 */

require __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use App\Models\Event;

$email = 'operatorkr26@regtix.id';

echo "=== CHECK USER EVENT ===\n\n";

// Cek user
$user = User::where('email', $email)->first();

if (!$user) {
    echo "❌ User tidak ditemukan dengan email: {$email}\n";
    exit(1);
}

echo "User ditemukan:\n";
echo "  ID: {$user->id}\n";
echo "  Name: {$user->name}\n";
echo "  Email: {$user->email}\n";
echo "  Event ID: " . ($user->event_id ?? 'NULL') . "\n";
echo "\n";

// Cek event berdasarkan event_id user
if ($user->event_id) {
    $event = Event::find($user->event_id);
    
    if ($event) {
        echo "Event berdasarkan user.event_id ({$user->event_id}):\n";
        echo "  ID: {$event->id}\n";
        echo "  Name: {$event->name}\n";
        echo "  Start Date: {$event->start_date}\n";
        echo "  End Date: {$event->end_date}\n";
        echo "\n";
        
        if ($event->name === 'Sanga Sanga Run 2025') {
            echo "⚠️  MASALAH DITEMUKAN!\n";
            echo "   Event name masih 'Sanga Sanga Run 2025'\n";
            echo "   Perlu diupdate menjadi 'Keramas Run 2026'\n";
        } else {
            echo "✅ Event name sudah benar: {$event->name}\n";
        }
    } else {
        echo "❌ Event tidak ditemukan dengan ID: {$user->event_id}\n";
    }
} else {
    echo "⚠️  User tidak memiliki event_id (NULL)\n";
    echo "   Frontend akan menggunakan fallback event_id = 1\n";
    
    // Cek event dengan ID 1
    $event = Event::find(1);
    if ($event) {
        echo "\nEvent dengan ID 1 (fallback):\n";
        echo "  ID: {$event->id}\n";
        echo "  Name: {$event->name}\n";
    }
}

echo "\n=== SEMUA EVENT YANG ADA ===\n";
$allEvents = Event::all(['id', 'name', 'start_date']);
foreach ($allEvents as $evt) {
    $marker = ($evt->id == $user->event_id) ? " ← (digunakan oleh user)" : "";
    echo "  ID: {$evt->id} | Name: {$evt->name}{$marker}\n";
}













