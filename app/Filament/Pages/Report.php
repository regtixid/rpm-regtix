<?php

namespace App\Filament\Pages;

use App\Filament\Widgets\RegistrationRevenueChart;
use Filament\Pages\Page;
use App\Models\Registration;
use App\Models\Event;
use Filament\Forms\Components\Select;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;

class Report extends Page
{
    protected static string $view = 'filament.pages.report';
    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-list';
    protected static ?int $navigationSort = 5;
    protected static ?string $navigationGroup = 'Race Pack Management';

    public array $chartData = [];
    public int $totalRegistrations = 0;
    public float $totalRevenue = 0;
    public ?int $selectedEvent = null;

    public array $jerseyByCategory = [];
    public array $globalStats = [];
    public array $perTicketStats = [];
    public array $communityRanks = [];
    public array $cityRanks = [];
    public string $reportGeneratedAt;




    public function updateReport(): void
    {
        if (! $this->selectedEvent) {
            $this->resetReportData();
            return;
        }

        $event = Event::find($this->selectedEvent);
        if (! $event) {
            $this->resetReportData();
            return;
        }

        /** @var Collection<int, \App\Models\Registration> $registrations */
        $registrations = Registration::with([
                'categoryTicketType.category', 
                'categoryTicketType.ticketType',
                'voucherCode.voucher'
            ])
            ->whereHas('categoryTicketType.category', fn($q) =>
                $q->where('event_id', $event->id)
            )
            ->where(function ($q) {
                $q->where('payment_status', 'paid');
            })
            ->get();

        // Global totals
        $this->totalRegistrations = $registrations->count();
        $this->totalRevenue = $registrations->sum(function ($r) {
            return $r->voucherCode?->voucher?->final_price ?? $r->categoryTicketType->price ?? 0;
        });

        // Global Stats
        $this->globalStats = [
            'total_participants' => $this->totalRegistrations,
            'total_revenue' => $this->totalRevenue,
            'gender' => [
                'male' => $registrations->where('gender', 'Male')->count(),
                'female' => $registrations->where('gender', 'Female')->count(),
            ],
            'nationality' => [
                'indonesian' => $registrations->where('nationality', 'Indonesia')->count(),
                'foreigner' => $registrations->filter(fn ($r) => $r->nationality && $r->nationality !== 'Indonesia')->count(),
            ],
        ];

        // Group by category & ticket type
        $data = $registrations
            ->groupBy(fn($r) => $r->categoryTicketType->category->name . ' - ' . $r->categoryTicketType->ticketType->name);

        $this->chartData = [
            'labels' => $data->keys()->toArray(),
            'values' => $data->map(fn($group) => count($group))->values()->toArray(),
            'revenues' => $data->map(fn($group) => $group->sum(fn($r) => $r->voucherCode?->voucher?->final_price ?? $r->categoryTicketType->price ?? 0))->values()->toArray(),
        ];

        // Per Ticket Stats
        $this->perTicketStats = $data->map(function (Collection $group, string $label) {
            return [
                'label' => $label,
                'participants' => $group->count(),
                'revenue' => $group->sum(fn($r) => $r->voucherCode?->voucher?->final_price ?? $r->categoryTicketType->price ?? 0),
                'gender' => [
                    'male' => $group->where('gender', 'Male')->count(),
                    'female' => $group->where('gender', 'Female')->count(),
                ],
                'jersey_sizes' => $group->whereNotNull('jersey_size')
                    ->groupBy('jersey_size')
                    ->map->count()
                    ->sortKeys()
                    ->toArray(),
            ];
        })->values()->toArray();

        // Community rank (global)
        $this->communityRanks = $registrations
            ->filter(fn ($r) => filled($r->community_name))
            ->groupBy('community_name')
            ->map->count()
            ->sortDesc()
            ->map(fn ($count, $name) => [
                'name' => $name,
                'count' => $count,
            ])
            ->values()
            ->toArray();

        // City / Regency rank (global) - use district + province if available
        $this->cityRanks = $registrations
            ->map(function ($r) {
                $parts = array_filter([
                    $r->district ?: null,
                    $r->province ?: null,
                ]);

                return count($parts) ? implode(', ', $parts) : ($r->country ?: null);
            })
            ->filter()
            ->groupBy(fn ($location) => $location)
            ->map->count()
            ->sortDesc()
            ->map(fn ($count, $location) => [
                'location' => $location,
                'count' => $count,
            ])
            ->values()
            ->toArray();

        // Jersey by category with custom sorting
        $sizeOrder = ['XS','S','M','L','XL','XXL'];

        $this->jerseyByCategory = $registrations
            ->whereNotNull('jersey_size')
            ->groupBy(fn($r) => $r->categoryTicketType->category->name)
            ->map(function ($group) use ($sizeOrder) {

                // hitung jumlah per size
                $sizes = $group->groupBy('jersey_size')
                            ->map(fn($g) => $g->count())
                            ->toArray(); // harus array dulu untuk uksort

                // custom sort berdasarkan prefix
                uksort($sizes, function($a, $b) use ($sizeOrder) {
                    $indexA = array_search(
                        collect($sizeOrder)->first(fn($p) => str_starts_with($a, $p)),
                        $sizeOrder,
                        true
                    );
                    $indexB = array_search(
                        collect($sizeOrder)->first(fn($p) => str_starts_with($b, $p)),
                        $sizeOrder,
                        true
                    );

                    $indexA = $indexA === false ? 999 : $indexA;
                    $indexB = $indexB === false ? 999 : $indexB;

                    return $indexA <=> $indexB;
                });

                return $sizes;
            })->toArray();

       $this->dispatch('chartUpdated', [
            'chartData' => $this->chartData ?? ['labels'=>[], 'values'=>[], 'revenues'=>[]],
            'jerseySizes' => $this->jerseyByCategory
        ]);
    }


    public function mount(): void
    {
        $this->reportGeneratedAt = now()->timezone(config('app.timezone', 'Asia/Makassar'))->format('l, d F Y : H.i T');

        $user = Auth::user();
        $events = $user->role->name === 'superadmin'
            ? Event::pluck('name', 'id')
            : $user->events()->pluck('events.name', 'events.id');
        $this->selectedEvent =  $events->keys()->first();

        $this->updateReport();
    }
    protected function getFormSchema(): array
    {
        $user = Auth::user();
        $events = $user->role->name === 'superadmin'
            ? Event::pluck('name', 'id')
            : $user->events()->pluck('events.name', 'events.id');

        return [
            Select::make('selectedEvent')
                ->label('Select Event')
                ->default($events->keys()->first())
                ->options($events)
                ->searchable()
                ->reactive()
                ->afterStateUpdated(fn() => $this->updateReport())
                ->extraAttributes(['style' => 'max-width:350px;']),
        ];
    }

    protected function resetReportData(): void
    {
        $this->chartData = [];
        $this->totalRegistrations = 0;
        $this->totalRevenue = 0;
        $this->jerseyByCategory = [];
        $this->globalStats = [];
        $this->perTicketStats = [];
        $this->communityRanks = [];
        $this->cityRanks = [];
    }
}

