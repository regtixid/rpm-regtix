-- Script untuk check event_id dan event_name dari user
-- User: operatorkr26@regtix.id
-- Jalankan di database MySQL/MariaDB

-- 1. Cek user dan event_id-nya
SELECT 
    u.id as user_id,
    u.name as user_name,
    u.email,
    u.event_id,
    e.id as event_id_from_table,
    e.name as event_name,
    e.start_date,
    e.end_date
FROM users u
LEFT JOIN events e ON u.event_id = e.id
WHERE u.email = 'operatorkr26@regtix.id';

-- 2. Jika event_id NULL, cek event dengan ID 1 (fallback yang digunakan frontend)
SELECT 
    id,
    name as event_name,
    start_date,
    end_date
FROM events
WHERE id = 1;

-- 3. Tampilkan semua event yang ada (untuk referensi)
SELECT 
    id,
    name as event_name,
    start_date,
    end_date,
    CASE 
        WHEN id = (SELECT event_id FROM users WHERE email = 'operatorkr26@regtix.id' LIMIT 1) THEN '← DIGUNAKAN OLEH USER'
        ELSE ''
    END as status
FROM events
ORDER BY id;

-- 4. Cek apakah ada event dengan nama "Sanga Sanga Run 2025"
SELECT 
    id,
    name as event_name,
    start_date,
    end_date
FROM events
WHERE name LIKE '%Sanga%' OR name LIKE '%Keramas%'
ORDER BY id;













