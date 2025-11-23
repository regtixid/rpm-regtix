<?php

namespace App\Filament\Resources;

use App\Filament\Resources\VoucherResource\Pages;
use App\Filament\Resources\VoucherResource\RelationManagers;
use App\Models\CategoryTicketType;
use App\Models\Voucher;
use Filament\Tables\Actions\Action;
use Filament\Forms;
use Filament\Forms\Components\Checkbox;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn;

use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;


class VoucherResource extends Resource
{
    protected static ?string $model = Voucher::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?int $navigationSort = 4;
    protected static ?string $navigationGroup = 'Event Management';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('name')
                ->label('Voucher Name')
                ->required(),
            Select::make('category_ticket_type_id')
                ->label('Event Category - Ticket Type')
                ->relationship('categoryTicketType', 'id')
                ->options(function () {

                /** @var \App\Models\User $user */
                    $user = Auth::user();

                    $query = CategoryTicketType::query();

                if ($user->role->name !== 'superadmin') {
                    $userIds = $user->events()->pluck('events.id')->toArray();
                    $query->whereHas('category.event', function ($query) use ($userIds) {
                        $query->whereIn('events.id', $userIds);
                        });
                    }

                    return $query->with(['category.event', 'ticketType'])
                        ->get()
                        ->mapWithKeys(function ($record) {
                            return [
                                $record->id =>
                                $record->category->event->name . ' - ' .
                                    $record->category->name . ' - ' .
                                    $record->ticketType->name,
                            ];
                        })
                        ->toArray();
                })
                ->searchable()
                ->preload()
                ->required(),
            TextInput::make('final_price')
                ->label('Final Price (e.g. 100.000)')
                ->numeric()
                ->required()
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('name')->searchable(),
                TextColumn::make('categoryTicketType.category.name')->label('Category'),
                TextColumn::make('categoryTicketType.ticketType.name')->label('Ticket Type'),
                TextColumn::make('final_price')->label('Final Price')
                ->formatStateUsing(fn($state) => 'Rp. ' . number_format($state, 0, ',', '.')),
                TextColumn::make('voucher_codes_count')
                ->label('Codes')
                ->counts('voucherCodes'),
            ])
            ->filters([])
            ->actions([
            Action::make('viewCodes')
                ->label('View Codes')
                ->url(fn($record) => VoucherCodeResource::getUrl('index', ['voucher_id' => $record->id]))
                ->icon('heroicon-o-eye'),
            // Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
            Action::make('generate')
                ->label('Generate Codes')
                ->icon('heroicon-o-key')
                ->modalWidth('sm')
                ->form([
                    Checkbox::make('is_multiple_use')
                        ->label('Multiple Use')
                        ->reactive()
                        ->default(false),
                    TextInput::make('voucher_code')
                        ->label('Input Voucher Code')
                        ->visible(fn (callable $get) => $get('is_multiple_use')),

                    TextInput::make('quantity')
                        ->label('Code Quantity')
                        ->numeric()
                        ->minValue(1)
                        ->default(1)
                        ->required()
                        ->visible(fn (callable $get) => ! $get('is_multiple_use')),
                ])
                ->action(function ($record, array $data) {
                    if(!empty($data['is_multiple_use'])) {
                        $code = strtoupper($data['voucher_code']);
                        if ($record->voucherCodes()->where('code', $code)->exists()) {
                            Notification::make()
                                ->title('Voucher Code Exists')
                                ->danger()
                                ->body("Voucher Code {$code} already exists.")
                                ->send();
                            return;
                        }

                        $record->voucherCodes()->create([
                            'code' => $data['voucher_code'],
                            'is_multiple_use' => true
                        ]);
                    } else {
                        for ($i = 0; $i < (int) $data['quantity']; $i++) {
                            $record->voucherCodes()->create([
                                'code' => strtoupper(Str::random(10)),
                                'is_multiple_use' => false
                            ]);
                        }
                    }
                     Notification::make()
                        ->title('Voucher codes generated!')
                        ->success()
                        ->send();
                }),         
            ])
            ->bulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
        }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListVouchers::route('/'),
            'create' => Pages\CreateVoucher::route('/create'),
            'edit' => Pages\EditVoucher::route('/{record}/edit'),
        ];
    }


    public static function getEloquentQuery(): Builder
    {
        /** @var \App\Models\User $user */
        $user = Auth::user();

        // Admin lihat semua
        if ($user->role->name === 'superadmin') {
            return parent::getEloquentQuery();
        }

        $eventIds = $user->events()->pluck('events.id')->toArray();

        return parent::getEloquentQuery()
            ->whereHas('categoryTicketType.category.event', function ($query) use ($eventIds) {
                $query->whereIn('id', $eventIds);
            });
    }
}
