# Panduan Test API RPC via Terminal

## Tools yang Bisa Digunakan

1. **curl** - Paling umum dan tersedia di semua sistem
2. **httpie** - Lebih user-friendly (perlu install)
3. **wget** - Alternatif curl

---

## Setup Awal

### Simpan Token di Variable (Untuk Memudahkan)

```bash
# Setelah login, simpan token di variable
TOKEN="paste_token_di_sini"

# Atau bisa langsung dari response login
TOKEN=$(curl -s -X POST https://rpm.regtix.id/api/rpc/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"operator@example.com","password":"password123"}' \
  | grep -o '"token":"[^"]*' | cut -d'"' -f4)

echo "Token: $TOKEN"
```

---

## Test Endpoint

### 1. Login (Dapat Token)

```bash
curl -X POST https://rpm.regtix.id/api/rpc/v1/auth/login \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "email": "operator@example.com",
    "password": "password123"
  }' | jq
```

**Output:**
```json
{
  "success": true,
  "message": "Login berhasil.",
  "data": {
    "token": "1|abc123...",
    "user": {...}
  }
}
```

**Simpan token:**
```bash
TOKEN="1|abc123def456..."
```

---

### 2. Scan Ticket

```bash
curl -X POST https://rpm.regtix.id/api/rpc/v1/tickets/scan \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "ticket_code": "RTIX-KR26-VVXD1H"
  }' | jq
```

**Tanpa jq (jika tidak terinstall):**
```bash
curl -X POST https://rpm.regtix.id/api/rpc/v1/tickets/scan \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"ticket_code":"RTIX-KR26-VVXD1H"}'
```

---

### 3. Print Payload (Pickup Sheet)

```bash
curl -X POST https://rpm.regtix.id/api/rpc/v1/prints/payload \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "print_type": "pickup_sheet",
    "participant_ids": [123],
    "event_id": 1
  }' | jq
```

---

### 4. Print Payload (Power of Attorney)

```bash
curl -X POST https://rpm.regtix.id/api/rpc/v1/prints/payload \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "print_type": "power_of_attorney",
    "participant_ids": [123, 124],
    "event_id": 1,
    "representative_data": {
      "name": "Jane Doe",
      "ktp_number": "9876543210987654",
      "dob": "1985-05-15",
      "address": "Jl. Perwakilan No. 456",
      "phone": "081234567892",
      "relationship": "Teman"
    }
  }' | jq
```

---

### 5. Search Participants

```bash
curl -X GET "https://rpm.regtix.id/api/rpc/v1/participants/search?keyword=John&event_id=1&status=NOT_VALIDATED" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" | jq
```

**Atau dengan URL encoding:**
```bash
curl -X GET "https://rpm.regtix.id/api/rpc/v1/participants/search" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" \
  -G \
  -d "keyword=John" \
  -d "event_id=1" \
  -d "status=NOT_VALIDATED" | jq
```

---

### 6. Validate Participant

```bash
curl -X POST https://rpm.regtix.id/api/rpc/v1/validate \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "participant_id": 123,
    "note": "Peserta sudah mengambil RPC lengkap"
  }' | jq
```

---

## Script Lengkap untuk Test Semua Endpoint

Buat file `test_rpc_api.sh`:

```bash
#!/bin/bash

# Warna untuk output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

BASE_URL="https://rpm.regtix.id/api/rpc/v1"

echo -e "${YELLOW}=== Test API RPC ===${NC}\n"

# 1. Login
echo -e "${GREEN}1. Testing Login...${NC}"
LOGIN_RESPONSE=$(curl -s -X POST ${BASE_URL}/auth/login \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "email": "operator@example.com",
    "password": "password123"
  }')

TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
    echo -e "${RED}Login failed!${NC}"
    echo $LOGIN_RESPONSE | jq
    exit 1
fi

echo -e "${GREEN}Login successful!${NC}"
echo "Token: ${TOKEN:0:20}..."
echo ""

# 2. Scan Ticket
echo -e "${GREEN}2. Testing Scan Ticket...${NC}"
curl -s -X POST ${BASE_URL}/tickets/scan \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"ticket_code":"RTIX-KR26-VVXD1H"}' | jq
echo ""

# 3. Search Participants
echo -e "${GREEN}3. Testing Search Participants...${NC}"
curl -s -X GET "${BASE_URL}/participants/search?keyword=John&event_id=1" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" | jq
echo ""

# 4. Print Payload
echo -e "${GREEN}4. Testing Print Payload...${NC}"
curl -s -X POST ${BASE_URL}/prints/payload \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "print_type": "pickup_sheet",
    "participant_ids": [123],
    "event_id": 1
  }' | jq
echo ""

# 5. Validate (Comment jika tidak ingin test validate)
# echo -e "${GREEN}5. Testing Validate...${NC}"
# curl -s -X POST ${BASE_URL}/validate \
#   -H "Authorization: Bearer $TOKEN" \
#   -H "Content-Type: application/json" \
#   -H "Accept: application/json" \
#   -d '{"participant_id":123}' | jq

echo -e "${GREEN}=== Test Complete ===${NC}"
```

**Cara pakai:**
```bash
chmod +x test_rpc_api.sh
./test_rpc_api.sh
```

---

## Test dari Server (Localhost)

Jika test dari server sendiri:

```bash
# Login
curl -X POST http://localhost/api/rpc/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"operator@example.com","password":"password123"}'

# Scan (dengan token)
curl -X POST http://localhost/api/rpc/v1/tickets/scan \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"ticket_code":"RTIX-KR26-VVXD1H"}'
```

---

## Install jq untuk Format JSON yang Lebih Rapi

**Ubuntu/Debian:**
```bash
apt-get update
apt-get install jq
```

**CentOS/RHEL:**
```bash
yum install jq
```

**MacOS:**
```bash
brew install jq
```

**Windows (PowerShell):**
```powershell
# Install via Chocolatey
choco install jq

# Atau download dari: https://stedolan.github.io/jq/download/
```

---

## Alternatif: Menggunakan httpie

**Install httpie:**
```bash
# Ubuntu/Debian
apt-get install httpie

# MacOS
brew install httpie

# Python
pip install httpie
```

**Contoh penggunaan:**

```bash
# Login
http POST https://rpm.regtix.id/api/rpc/v1/auth/login \
  email=operator@example.com \
  password=password123

# Scan (dengan token)
http POST https://rpm.regtix.id/api/rpc/v1/tickets/scan \
  Authorization:"Bearer $TOKEN" \
  ticket_code=RTIX-KR26-VVXD1H

# Search
http GET https://rpm.regtix.id/api/rpc/v1/participants/search \
  Authorization:"Bearer $TOKEN" \
  keyword==John \
  event_id==1
```

---

## Tips

1. **Simpan token di variable** untuk memudahkan:
   ```bash
   TOKEN="1|abc123..."
   ```

2. **Gunakan jq** untuk format JSON yang lebih rapi:
   ```bash
   curl ... | jq
   ```

3. **Simpan response ke file** untuk analisis:
   ```bash
   curl ... > response.json
   cat response.json | jq
   ```

4. **Test dengan verbose mode** untuk debug:
   ```bash
   curl -v -X POST ...
   ```

5. **Test error handling**:
   ```bash
   # Test dengan token invalid
   curl -X POST ... -H "Authorization: Bearer invalid_token"
   
   # Test dengan ticket code tidak valid
   curl -X POST ... -d '{"ticket_code":"INVALID"}'
   ```

---

## Contoh Test Flow Lengkap

```bash
#!/bin/bash

BASE_URL="https://rpm.regtix.id/api/rpc/v1"

# 1. Login
echo "=== LOGIN ==="
RESPONSE=$(curl -s -X POST ${BASE_URL}/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"operator@example.com","password":"password123"}')

TOKEN=$(echo $RESPONSE | jq -r '.data.token')
echo "Token: $TOKEN"
echo ""

# 2. Scan Ticket
echo "=== SCAN TICKET ==="
curl -s -X POST ${BASE_URL}/tickets/scan \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"ticket_code":"RTIX-KR26-VVXD1H"}' | jq
echo ""

# 3. Search
echo "=== SEARCH PARTICIPANTS ==="
curl -s -X GET "${BASE_URL}/participants/search?keyword=John&event_id=1" \
  -H "Authorization: Bearer $TOKEN" | jq
echo ""

# 4. Validate (jika perlu)
# echo "=== VALIDATE ==="
# curl -s -X POST ${BASE_URL}/validate \
#   -H "Authorization: Bearer $TOKEN" \
#   -H "Content-Type: application/json" \
#   -d '{"participant_id":123}' | jq
```

---

**Selamat Testing! 🚀**



















