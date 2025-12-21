#!/bin/bash
# Script untuk check event_id dan event_name dari user di server
# Jalankan di server: bash CHECK_USER_EVENT_SERVER.sh

echo "=== CHECK USER EVENT ==="
echo ""

# Konfigurasi database (sesuaikan dengan .env)
DB_HOST="${DB_HOST:-localhost}"
DB_DATABASE="${DB_DATABASE:-rpm}"
DB_USERNAME="${DB_USERNAME:-root}"
DB_PASSWORD="${DB_PASSWORD:-}"

EMAIL="operatorkr26@regtix.id"

echo "Checking user: $EMAIL"
echo ""

# Query untuk cek user dan event
mysql -h "$DB_HOST" -u "$DB_USERNAME" -p"$DB_PASSWORD" "$DB_DATABASE" <<EOF
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
WHERE u.email = '$EMAIL';

-- 2. Tampilkan semua event yang ada
SELECT 
    id,
    name as event_name,
    start_date,
    end_date
FROM events
ORDER BY id;

-- 3. Cek event dengan nama yang mengandung Sanga atau Keramas
SELECT 
    id,
    name as event_name
FROM events
WHERE name LIKE '%Sanga%' OR name LIKE '%Keramas%'
ORDER BY id;
EOF

echo ""
echo "=== DONE ==="













