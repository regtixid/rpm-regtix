-- Script untuk update nama event dari "Sanga Sanga Run 2025" ke "Keramas Run 2026"
-- Jalankan di database MySQL/MariaDB

-- 1. Cek event yang ada di database
SELECT id, name, start_date, end_date FROM events ORDER BY id;

-- 2. Update nama event untuk event tertentu
-- Ganti ID dengan event_id yang benar (cek dulu dengan query di atas)
UPDATE events 
SET name = 'Keramas Run 2026'
WHERE name = 'Sanga Sanga Run 2025';
-- atau jika ingin update berdasarkan ID tertentu:
-- WHERE id = [EVENT_ID_YANG_BENAR];

-- 3. Verifikasi update
SELECT id, name, start_date, end_date FROM events WHERE name LIKE '%Keramas%' OR name LIKE '%Sanga%';

-- 4. Jika perlu update berdasarkan event_id user yang sedang digunakan:
-- Cek event_id dari user yang login
SELECT u.id, u.name, u.email, u.event_id, e.name as event_name 
FROM users u 
LEFT JOIN events e ON u.event_id = e.id 
WHERE u.email = '[EMAIL_OPERATOR_YANG_DIGUNAKAN]';

-- 5. Update event berdasarkan event_id dari user
-- UPDATE events 
-- SET name = 'Keramas Run 2026'
-- WHERE id = (SELECT event_id FROM users WHERE email = '[EMAIL_OPERATOR_YANG_DIGUNAKAN]' LIMIT 1);













