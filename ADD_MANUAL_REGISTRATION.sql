-- Script SQL untuk menambahkan peserta yang sudah bayar namun datanya tidak ada di database
-- 
-- Data dari Midtrans:
-- - registration_code: RTIX-KR26-0ZXEFA
-- - full_name: Anak Agung Gde Rai Semara Putra
-- - email: aagderaisemaraputra@gmail.com
-- - phone: +6281339999815
-- - transaction_code: dcb0e263-0f08-421b-93cf-d2521ff166aa
-- - payment_type: bank_transfer
-- - gross_amount: 224440.00
-- - transaction_time: 2025-11-27 09:30:01
-- - category: 5K - RegularTicket
--
-- CATATAN: Script ini hanya untuk insert data dasar. 
-- Untuk generate reg_id dan QR code, gunakan script PHP Laravel Tinker (ADD_MANUAL_REGISTRATION.php)
--
-- Cara menjalankan:
-- 1. Login ke MySQL: mysql -u [username] -p [database_name]
-- 2. Jalankan script ini
-- 3. Setelah itu, jalankan script PHP untuk generate reg_id dan QR code

-- 1. Cek apakah registration sudah ada
SELECT id, registration_code, status, payment_status 
FROM registrations 
WHERE registration_code = 'RTIX-KR26-0ZXEFA';

-- Jika sudah ada, hapus dulu (HATI-HATI!):
-- DELETE FROM registrations WHERE registration_code = 'RTIX-KR26-0ZXEFA';

-- 2. Cari Event ID untuk KR26
SELECT id, name, code_prefix 
FROM events 
WHERE code_prefix = 'KR26';

-- 3. Cari Category ID untuk "5K" di event tersebut
-- Ganti [EVENT_ID] dengan ID dari query di atas
SELECT c.id, c.name, c.event_id 
FROM categories c
JOIN events e ON c.event_id = e.id
WHERE e.code_prefix = 'KR26' AND c.name = '5K';

-- 4. Cari Ticket Type ID untuk "Regular"
SELECT id, name 
FROM ticket_types 
WHERE name = 'Regular';

-- 5. Cari Category Ticket Type ID
-- Ganti [CATEGORY_ID] dan [TICKET_TYPE_ID] dengan ID dari query di atas
SELECT ctt.id, ctt.category_id, ctt.ticket_type_id, ctt.price
FROM category_ticket_type ctt
WHERE ctt.category_id = (
    SELECT c.id 
    FROM categories c
    JOIN events e ON c.event_id = e.id
    WHERE e.code_prefix = 'KR26' AND c.name = '5K'
    LIMIT 1
)
AND ctt.ticket_type_id = (
    SELECT id FROM ticket_types WHERE name = 'Regular' LIMIT 1
);

-- 6. Hitung jumlah confirmed registrations untuk generate reg_id
-- Ganti [CATEGORY_TICKET_TYPE_ID] dengan ID dari query di atas
SELECT COUNT(*) as confirmed_count
FROM registrations r
JOIN category_ticket_type ctt ON r.category_ticket_type_id = ctt.id
JOIN categories c ON ctt.category_id = c.id
JOIN events e ON c.event_id = e.id
WHERE r.status = 'confirmed' 
AND e.code_prefix = 'KR26';

-- 7. Insert Registration
-- Ganti [CATEGORY_TICKET_TYPE_ID] dengan ID dari query di atas
-- Ganti [CONFIRMED_COUNT] dengan jumlah dari query di atas + 1, lalu format dengan leading zeros (0001, 0002, dst)
-- CATATAN: reg_id dan qr_code_path akan di-generate oleh script PHP
INSERT INTO registrations (
    category_ticket_type_id,
    full_name,
    email,
    phone,
    registration_code,
    registration_date,
    status,
    payment_status,
    transaction_code,
    reg_id,
    paid_at,
    payment_type,
    gross_amount,
    qr_code_path,
    created_at,
    updated_at
) VALUES (
    (SELECT ctt.id
     FROM category_ticket_type ctt
     JOIN categories c ON ctt.category_id = c.id
     JOIN events e ON c.event_id = e.id
     JOIN ticket_types tt ON ctt.ticket_type_id = tt.id
     WHERE e.code_prefix = 'KR26' 
     AND c.name = '5K' 
     AND tt.name = 'Regular'
     LIMIT 1),
    'Anak Agung Gde Rai Semara Putra',
    'aagderaisemaraputra@gmail.com',
    '+6281339999815',
    'RTIX-KR26-0ZXEFA',
    '2025-11-27 09:30:01',
    'confirmed',
    'paid',
    'dcb0e263-0f08-421b-93cf-d2521ff166aa',
    '', -- Akan diisi oleh script PHP
    '2025-11-27 09:30:01',
    'bank_transfer',
    224440.00,
    NULL, -- Akan diisi oleh script PHP
    NOW(),
    NOW()
);

-- 8. Verifikasi
SELECT 
    r.id,
    r.registration_code,
    r.full_name,
    r.email,
    r.phone,
    r.status,
    r.payment_status,
    r.reg_id,
    r.transaction_code,
    r.gross_amount,
    r.paid_at,
    r.qr_code_path,
    c.name as category_name,
    tt.name as ticket_type_name,
    e.name as event_name
FROM registrations r
JOIN category_ticket_type ctt ON r.category_ticket_type_id = ctt.id
JOIN categories c ON ctt.category_id = c.id
JOIN ticket_types tt ON ctt.ticket_type_id = tt.id
JOIN events e ON c.event_id = e.id
WHERE r.registration_code = 'RTIX-KR26-0ZXEFA';



