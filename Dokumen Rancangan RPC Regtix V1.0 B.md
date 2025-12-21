Rancangan ini disusun agar Team Regtix dapat memahami alur RPC dengan baik, berikut adalah flowchart proses dari Race Pack Collection (RPC).   
**A. Flowchart** 

Peserta datang ke lokasi pengambilan RPC dan melakukan pengecekan awal di POS 1 untuk verifikasi identitas (KTP dan TIKET) serta penentuan jalur pengambilan, apakah sebagai peserta mandiri atau sebagai perwakilan. Peserta mandiri melanjutkan ke POS 2 untuk melakukan scan QR e-ticket, sistem menampilkan data peserta dan mencetak lembar pengambilan RPC. Untuk jalur perwakilan, petugas POS 2 menginput data lengkap perwakilan (nama, KTP, tanggal lahir, alamat, nomor telepon, dan hubungan), memilih daftar peserta yang diwakili, lalu mencetak surat kuasa dan daftar peserta untuk ditandatangani. Selanjutnya peserta atau perwakilan membawa lembar tersebut ke POS 3 untuk proses penyiapan dan penyerahan fisik RPC sesuai kategori tiket dan ukuran jersey. Setelah RPC diterima, peserta menuju POS 4 untuk pengecekan akhir kelengkapan item, melakukan tanda tangan sebagai bukti penerimaan, dan petugas menekan tombol validasi sehingga status peserta resmi tercatat telah menyelesaikan pengambilan RPC.

**B. POV (Point of View) dari Peserta** 

“Saya datang ke lokasi dan dicek secara singkat di POS 1 untuk memastikan saya mengambil sendiri atau diwakilkan. Karena saya mengambil sendiri, saya langsung ke POS 2 dan e-ticket saya di-scan. Di layar muncul nama dan data tiket saya lalu petugas mencetak lembar pengambilan. Dengan lembar itu, saya menuju POS 3 dan petugas menyiapkan paket race pack sesuai ukuran jersey dan kategori tiket saya. Setelah menerima paket lengkap, saya lanjut ke POS 4 untuk pengecekan terakhir. Saya diminta tanda tangan sebagai bukti penerimaan, lalu petugas melakukan validasi di sistem. Setelah itu, proses saya selesai dan saya bisa meninggalkan area.”

# **C. DESKRIPSI KERJA MASING-MASING POS** 

## **POS 1 — Pengecekan Awal & Pengarahan Jalur**

**Tujuan utama:**  
 Memastikan peserta yang datang benar orangnya dan mengarahkan ke jalur yang tepat (Mandiri atau Perwakilan).  
Aktivitas utama:

1. Peserta datang dan menunjukkan:  
   * E-ticket (di HP) atau Informasi nama/kode booking.  
   * KTP asli / foto / fotocopy   
2. Petugas **mencocokkan secara visual** dengan identitas peserta.  
3. Petugas menanyakan:  
   * Apakah hadir sendiri (Mandiri) atau  
   * Mewakili peserta lain (Perwakilan).  
4. Peserta diarahkan:  
   * → **Ke POS 2 Jalur Mandiri** jika mengambil untuk diri sendiri.  
   * → **Ke POS 2 Jalur Perwakilan** jika mengambil untuk orang lain.

Output bisnis POS 1:

* Memastikan kelengkapan yang dibawa perserta (KTP/E-tiket)  
* Status jalur peserta jelas: Mandiri / Perwakilan  
* Tidak ada pencatatan sistem di POS 1 (murni seleksi alur).

## **✅ POS 2 — Scan Mandiri & Input Data Perwakilan (Pusat Administrasi)**

### **🔹 A. Jalur Mandiri (Ambil Sendiri)**

1. Peserta menyerahkan QR E-ticket untuk dipindai.  
2. Sistem menampilkan data peserta:  
   * Nama  
   * Jenis tiket  
   * Ukuran jersey

3. Jika data valid dan **belum pernah mengambil RPC**, maka:  
   * Sistem mencetak **lembar data pengambilan RPC**.

**Output:**

* Peserta menerima **lembar data fisik**.  
* Data peserta siap diproses oleh POS 3\.

### **🔹 B. Jalur Perwakilan (Ambil untuk Orang Lain)**

           Petugas wajib menginput data perwakilan berikut:

1. Nama lengkap  
2. Nomor KTP  
3. Tanggal lahir  
4. Alamat domisili  
5. Nomor telepon  
6. Hubungan dengan peserta (misal: teman, saudara, rekan kerja, orangtua)

**Alur kerja:**

1. Petugas menginput seluruh data perwakilan.  
2. Petugas memilih daftar peserta yang diwakilkan (**bisa lebih dari satu**).  
3. Sistem mencetak:  
   * **Surat kuasa otomatis (didalamnya sudah ada daftar nama peserta, Kode tiket yang diwakili)**  
   * **Masing-masing Datadiri peserta.**

4. Perwakilan melakukan **tanda tangan manual di atas kertas**.

**Output:**

* Lembar surat kuasa \+ daftar peserta tercetak.  
* Lembar tersebut menjadi **dokumen sah pengambilan RPC** di POS 3\.

## **✅ POS 3 — Persiapan & Penyerahan Fisik RPC (Gudang)**

**POS 3 adalah pusat fisik logistik. Tidak ada interaksi sistem.**

**Input dari peserta/perwakilan:**

* Lembar data pengambilan (dari POS 2\)  
* Bisa berupa:  
  * Mandiri → 1 peserta  
  * Perwakilan → banyak peserta sekaligus

**Aktivitas utama:**

1. Petugas mengecek Lembar data:  
   * Nama peserta  
   * Jenis tiket  
   * Ukuran jersey  
   * BIB  
2. Petugas menyiapkan:  
   * Jersey sesuai ukuran  
   * BIB  
   * Tas  
   * Komponen lain sesuai kategori tiket  
3. RPC diserahkan kembali ke peserta/perwakilan bersama **lembar data**.

**Output bisnis:**

* Peserta sudah memegang RPC lengkap secara fisik  
* Siap masuk ke tahap validasi final

---

## **✅ POS 4 — Validasi Final & Checklist Resmi Pengambilan**

**POS 4 adalah titik pengesahan resmi pengambilan RPC.**

**Aktivitas utama:**

1. Petugas menerima:  
   * RPC fisik  
   * Lembar data pengambilan

2. Petugas dan peserta melakukan:  
   * Cek nama peserta  
   * Cek kesesuaian jersey  
   * Cek kelengkapan setiap item paket  
3. Peserta diminta:  
   * Tanda tangan manual sebagai bukti resmi penerimaan

4. Jika semua dinyatakan lengkap:  
   * Petugas menekan tombol **VALIDATE**

**Makna VALIDATE secara bisnis:**

* Peserta dianggap **resmi sudah mengambil RPC**  
* Sistem merekam:  
  * Tanggal  
  * Jam  
  * Operator yang memvalidasi

**Output akhir:**

* Status pengambilan \= **SELESAI**  
* **Tidak dapat diulang atau diubah secara normal**

**CATATAN :**   
**Jika terdapat kesalahan data diri pada lembar cetak pengambilan RPC, peserta diperbolehkan langsung melakukan koreksi manual menggunakan ballpoint pada kertas tersebut. proses pengambilan RPC dan validasi tetap dilakukan seperti biasa di POS 4\. Seluruh koreksi pada kertas akan di-input kembali ke sistem oleh tim backoffice setelah seluruh rangkaian acara RPC selesai.**

# **Rancangan bagian BE**

---

## **1\. Prinsip Umum Sistem**

1. Sistem RPC hanya berfokus pada:  
   * Scan tiket  
   * Cetak lembar pengambilan / surat kuasa  
   * Validasi pengambilan RPC

2. Sistem **tidak melakukan edit data peserta selama event berlangsung**.

3. Jika ada kesalahan data:  
   * Peserta melakukan koreksi manual dengan ballpoint di kertas  
   * Validasi tetap berjalan  
   * Data diperbaiki oleh backoffice **setelah event selesai**

4. **Backend tidak mengatur desain cetak**.  
   * Backend hanya mengirim **payload data mentah**  
   * Frontend yang mengisi payload ke **template XML cetak**

5. **Status peserta hanya dua:**  
   * `NOT_VALIDATED`  
   * `VALIDATED`

6. **Perubahan status hanya boleh dilakukan oleh POS 4**

7. Sistem harus:  
   * Aman dari double validate  
   * Aman dari retry akibat jaringan  
   * Tetap ringan dan cepat

---

# **2\. Base URL & Otentikasi**

**Base URL:**  
 `https://rpc.regtix.id/api/v1`  
**Otentikasi:**  
 Bearer Token (`operator`)  
Semua endpoint kecuali login wajib menggunakan token ini.

---

# **3\. DAFTAR API FINAL**

---

## **3.1 `POST /auth/login`**

### **Tujuan**

Login operator POS RPC.

### **Data Dikirim**

* Email  
* Password

### **Data Diterima**

* Token autentikasi  
* Data profil operator

### **Perilaku Sistem**

* Jika login benar → token diberikan  
* Jika salah → ditolak

### **Status Kode**

* `200` Berhasil  
* `401` Gagal autentikasi

---

## **3.2 `POST /tickets/scan` ✅ (API UTAMA POS 2\)**

### **Tujuan**

Memverifikasi tiket hasil scan QR atau input kode manual, sekaligus menampilkan data peserta.

### **Data Dikirim**

* Kode tiket / QR payload

### **Data Diterima**

* ID peserta  
* Nama peserta  
* Kategori tiket  
* Nomor bib  
* Ukuran jersey  
* Status peserta (`NOT_VALIDATED` / `VALIDATED`)

### **Perilaku Sistem**

* Jika tiket **tidak ditemukan** → ditolak  
* Jika tiket **sudah VALIDATED** → ditolak  
* Jika tiket **masih NOT\_VALIDATED** → data dikirim ke frontend  
* Endpoint ini **tidak mengubah status apa pun**

### **Status Kode**

* `200` Berhasil  
* `404` Tiket tidak ditemukan  
* `409` Tiket sudah divalidasi

---

## **3.3 `POST /prints/payload` ✅ PRINTING API BERBASIS XML**

**Satu-satunya API resmi untuk kebutuhan cetak**

### **Tujuan**

Mengirim **payload data diri lengkap peserta** untuk diisikan ke **template XML cetak di frontend**.

### **Data Dikirim**

* Jenis cetakan:  
  * `pickup_sheet` (mandiri)  
  * `power_of_attorney` (perwakilan)

* ID peserta (satu atau banyak) **atau**  
* ID perwakilan  
* ID event

### **Data Diterima (Payload Cetak)**

#### **Data Peserta:**

* ID peserta  
* Nama lengkap  
* Nomor KTP  
* Tanggal lahir  
* Alamat  
* Nomor telepon  
* Jenis kelamin  
* Kategori tiket  
* Nomor bib  
* Ukuran jersey  
* Status validasi

#### **Data Perwakilan (jika ada):**

* Nama perwakilan  
* Nomor KTP  
* Tanggal lahir  
* Alamat  
* Nomor telepon  
* Hubungan dengan peserta  
* Daftar peserta yang diwakili

#### **Metadata Cetak:**

* Jenis cetakan  
* Waktu generate payload  
* ID operator  
* ID event

### **Perilaku Sistem**

* ✅ Backend **hanya mengirim data**  
* ❌ Tidak mengubah status peserta  
* ❌ Tidak menandai sebagai “sudah dicetak”  
* Boleh dipanggil berulang kali jika cetakan gagal

### **Status Kode**

* `200` Berhasil  
* `400` Data permintaan tidak lengkap  
* `404` Peserta atau perwakilan tidak ditemukan

### **Tanggung Jawab Frontend**

* Menyimpan template cetak dalam bentuk **XML**  
* Mengisi payload dari backend ke template  
* Menyediakan preview (opsional)  
* Menjalankan proses cetak ke printer lokal

---

## **3.4 `POST /representatives`**

### **Tujuan**

Menyimpan **data perwakilan** di POS 2\.

### **Data Dikirim**

* Nama  
* Nomor KTP  
* Tanggal lahir  
* Alamat  
* Nomor telepon  
* Hubungan dengan peserta

### **Data Diterima**

* ID perwakilan  
* Ringkasan data

### **Perilaku Sistem**

* Semua data wajib diisi  
* Validasi sederhana format KTP

### **Status Kode**

* `201` Berhasil  
* `400` Data tidak valid

---

## **3.5 `POST /representatives/{id}/assign`**

### **Tujuan**

Mengaitkan perwakilan dengan satu atau banyak peserta.

### **Data Dikirim**

* ID perwakilan  
* Daftar ID peserta

### **Data Diterima**

* Daftar peserta yang berhasil dikaitkan  
* Daftar peserta yang gagal (dengan alasan)

### **Perilaku Sistem**

* Peserta yang sudah `VALIDATED` otomatis ditolak  
* Tidak ada perubahan status peserta

---

## **3.6 `GET /participants/search` ✅ (POS 4\)**

### **Tujuan**

Mencari peserta untuk keperluan validasi.

### **Parameter**

* Nama / kode tiket  
* Status (opsional)  
* Event ID

### **Data Diterima**

* Daftar peserta (ringkas)

---

## **3.7 `GET /jerseys/stock`**

### **Tujuan**

Menampilkan stok teoritis jersey per ukuran.

### **Data Diterima**

* Ukuran jersey  
* Stok awal  
* Prediksi terambil  
* Sisa teoritis

### **Catatan**

Data ini hanya sebagai **informasi lapangan**, bukan stok real-time fisik mutlak.  
---

## **3.8 `POST /validate` ✅ ENDPOINT PALING KRITIS (POS 4\)**

### **Tujuan**

Melakukan validasi pengambilan RPC dan mengubah status peserta menjadi `VALIDATED`.

### **Data Dikirim**

* ID peserta  
* ID operator  
* Catatan opsional

### **Data Diterima**

* ID peserta  
* Status baru (`VALIDATED`)  
* Waktu validasi  
* Operator yang memvalidasi

### **Aturan Wajib Sistem**

1. Hanya peserta dengan status `NOT_VALIDATED` yang boleh divalidasi  
2. Jika sudah `VALIDATED` → ditolak  
3. Wajib:  
   * Atomic (tidak boleh double validate)  
   * Aman dari retry jaringan  
4. Proses ini **final dan tidak bisa dibatalkan di sistem RPC**

### **Status Kode**

* `200` Berhasil  
* `404` Peserta tidak ditemukan  
* `409` Sudah divalidasi

---

## **3.9 `GET /health`**

### **Tujuan**

Cek kesehatan sistem RPC.

### **Data Diterima**

* Status layanan  
* Versi aplikasi  
* Koneksi database

---

# **4\. Tabel API**

| No | Method | Endpoint | Digunakan Oleh | Tujuan | Data Masuk (Judul) | Data Keluar (Judul) | Efek ke Status | Catatan Penting |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| 1 | POST | `/auth/login` | Semua POS | Login operator | email, password | token, profil\_operator | ❌ Tidak ada | Token wajib untuk dapat menggunakan semua API lain |
| 2 | POST | `/tickets/scan` | POS 2 | Verifikasi tiket hasil scan | kode\_tiket / qr\_payload | ringkasan\_peserta, status\_validasi | ❌ Tidak ada | Menolak jika sudah VALIDATED |
| 3 | POST | `/prints/payload` | POS 2 | Ambil payload data cetak | jenis\_cetakan, participant\_ids / rep\_id, event\_id | data\_peserta\_lengkap, metadata\_cetak | ❌ Tidak ada | FE isi ke template XML |
| 4 | POST | `/representatives` | POS 2 | Simpan data perwakilan | nama, ktp, ttl, alamat, telp, hubungan | id\_perwakilan | ❌ Tidak ada | Semua field wajib |
| 5 | POST | `/representatives/{id}/assign` | POS 2 | Hubungkan perwakilan ↔ peserta | id\_perwakilan, participant\_ids\[\] | assigned\_list, failed\_list | ❌ Tidak ada | Peserta VALIDATED ditolak |
| 6 | GET | `/participants/search` | POS 2 & 4 | Cari peserta | keyword, status?, event\_id | daftar\_peserta | ❌ Tidak ada | Dipakai untuk lookup |
| 7 | GET | `/jerseys/stock` | POS 2 / Logistik | Info stok teoritis jersey | \- | stok\_per\_ukuran | ❌ Tidak ada | Tidak mengurangi stok |
| 8 | POST | `/validate` | POS 4 | Finalisasi pengambilan RPC | participant\_id, operator\_id, note? | status\_baru, waktu\_validasi | ✅ Ubah ke VALIDATED | Harus atomic & idempotent |
| 9 | GET | `/health` | System | Cek kesehatan sistem | \- | status\_server, db | ❌ Tidak ada | Untuk monitoring |

`openapi: 3.0.0`  
`info:`  
  `title: RPC Regtix API`  
  `description: API untuk sistem Race Pack Collection Regtix`  
  `version: 1.0.0`

`servers:`  
  `- url: https://rpc.regtix.id/api/v1`

`security:`  
  `- BearerAuth: []`

`paths:`

  `/auth/login:`  
    `post:`  
      `summary: Login operator`  
      `tags: [Auth]`  
      `requestBody:`  
        `required: true`  
      `responses:`  
        `'200':`  
          `description: Login berhasil`  
        `'401':`  
          `description: Login gagal`

  `/tickets/scan:`  
    `post:`  
      `summary: Scan dan verifikasi tiket`  
      `tags: [POS2]`  
      `requestBody:`  
        `required: true`  
      `responses:`  
        `'200':`  
          `description: Data peserta dikirim`  
        `'404':`  
          `description: Tiket tidak ditemukan`  
        `'409':`  
          `description: Tiket sudah divalidasi`

  `/prints/payload:`  
    `post:`  
      `summary: Ambil payload data cetak untuk XML`  
      `tags: [Printing]`  
      `requestBody:`  
        `required: true`  
      `responses:`  
        `'200':`  
          `description: Payload cetak berhasil dikirim`  
        `'400':`  
          `description: Parameter tidak lengkap`  
        `'404':`  
          `description: Data tidak ditemukan`

  `/representatives:`  
    `post:`  
      `summary: Simpan data perwakilan`  
      `tags: [POS2]`  
      `requestBody:`  
        `required: true`  
      `responses:`  
        `'201':`  
          `description: Perwakilan berhasil dibuat`  
        `'400':`  
          `description: Data tidak valid`

  `/representatives/{id}/assign:`  
    `post:`  
      `summary: Assign perwakilan ke peserta`  
      `tags: [POS2]`  
      `parameters:`  
        `- name: id`  
          `in: path`  
          `required: true`  
      `requestBody:`  
        `required: true`  
      `responses:`  
        `'200':`  
          `description: Assign berhasil`  
        `'400':`  
          `description: Data tidak valid`

  `/participants/search:`  
    `get:`  
      `summary: Cari peserta`  
      `tags: [POS2, POS4]`  
      `parameters:`  
        `- name: keyword`  
          `in: query`  
          `required: true`  
        `- name: status`  
          `in: query`  
          `required: false`  
        `- name: event_id`  
          `in: query`  
          `required: true`  
      `responses:`  
        `'200':`  
          `description: Daftar peserta dikirim`

  `/jerseys/stock:`  
    `get:`  
      `summary: Informasi stok jersey`  
      `tags: [Logistik]`  
      `responses:`  
        `'200':`  
          `description: Data stok jersey`

  `/validate:`  
    `post:`  
      `summary: Validasi pengambilan RPC`  
      `tags: [POS4]`  
      `requestBody:`  
        `required: true`  
      `responses:`  
        `'200':`  
          `description: Validasi berhasil`  
        `'404':`  
          `description: Peserta tidak ditemukan`  
        `'409':`  
          `description: Sudah divalidasi`

  `/health:`  
    `get:`  
      `summary: Cek kesehatan sistem`  
      `tags: [System]`  
      `responses:`  
        `'200':`  
          `description: Sistem normal`

`components:`  
  `securitySchemes:`  
    `BearerAuth:`  
      `type: http`  
      `scheme: bearer`  
      `bearerFormat: JWT`

## **Ringkasan singkat bagian FE**

* Domain: `rpc.regtix.id`  
* Role: `operator` (satu role)  
* Status peserta: `NOT_VALIDATED` → `VALIDATED` (hanya POS 4 yang mengubah)  
* POS yang menggunakan FE: **POS 2 (dua perangkat)** dan **POS 4**  
* POS 2 ada dua perangkat fisik terpisah:  
  * **Perangkat A — Jalur Mandiri** (untuk peserta yang ambil sendiri)  
  * **Perangkat B — Jalur Perwakilan** (untuk perwakilan yang ambil banyak)

* Printing: BE → `POST /prints/payload` (mengirim payload data lengkap). FE punya template **XML**; FE mengikat payload ke XML, render preview, lakukan `window.print()` atau print helper lokal.

---

## **1\. Halaman & Perangkat (overview)**

1. **Login Page**  
   * Semua perangkat pakai ini. Memanggil `POST /auth/login`.  
2. **POS 2 — Perangkat A (Mandiri)**  
   * Fungsi: scan 1 tiket → tampil singkat → ambil payload cetak → isi XML → print.  
   * Hardware: laptop \+ webcam/scanner \+ printer.  
3. **POS 2 — Perangkat B (Perwakilan)**  
   * Fungsi: input data perwakilan → scan banyak tiket → kumpulkan daftar → ambil payload cetak gabungan → isi XML → print surat kuasa \+ daftar.  
   * Hardware: laptop \+ webcam/scanner \+ printer.  
4. **POS 4 — Perangkat Validasi**  
   * Fungsi: scan atau cari peserta → tampil data → tekan VALIDATE → panggil `POST /validate`.  
   * Hardware: laptop \+ webcam/scanner.

---

## **2\. Komponen UI inti (ketersediaan di tiap halaman)**

### **Umum (semua halaman)**

* Header: nama event, operator (dari token), waktu server (opsional)  
* Toast/Alert untuk pesan sukses & error  
* Spinner/Loader saat menunggu response API  
* Mekanisme disable button saat request in-flight  
* Mode offline warning (tampil jika token expire / network down)

### **POS 2 Mandiri**

* Area Scan (kamera focus / input manual)  
* Preview Card peserta (nama, ticket code, ticket type, bib, jersey size, status)  
* Countdown display (tampilkan card \~3 detik; configurable)  
* Tombol Print (otomatis atau manual)  
* Indicator hasil scan (valid / already validated / not found)

### **POS 2 Perwakilan**

* Form Data Perwakilan (nama, no KTP, ttl, alamat, no telp, hubungan)  
* Daftar Scanned Participants (tabel ringkas)  
* Tombol: \[Tambah Scan\], \[Reset Daftar\], \[Cetak Perwakilan\]  
* Preview surat kuasa (opsional) sebelum print

### **POS 4 Validasi**

* Mode Toggle: \[SCAN\] atau \[CARI MANUAL\]  
* Scan area & hasil tampil (mirip POS2)  
* Jika hasil `NOT_VALIDATED` → tombol \[VALIDASI SEKARANG\] (aktif)  
* Jika `VALIDATED` → tampilan status “SUDAH VALIDATED”, tombol disabled  
* Konfirmasi modal sebelum submit (simpan catatan bahwa kertas TTD ada)

---

## **3\. Alur terperinci — step by step**

### **A. POS 2 — Perangkat A (Mandiri)**

1. Operator login.  
2. Operator pilih **Mode Mandiri** (default).  
3. Operator men-scan QR / masukkan kode tiket.  
4. FE memanggil: `POST /tickets/scan` (payload: qr string).  
   * Jika `404` → tampilkan “Tiket tidak valid”.  
   * If `409` → tampilkan “Tiket sudah divalidasi”.  
   * If `200` → terima `participant_summary`.  
5. FE menampilkan participant card selama 3 detik (show big).  
6. FE memanggil: `POST /prints/payload` (type=`pickup_sheet`, participant\_id).  
7. Terima payload cetak → lakukan binding ke **XML template** → render preview (opsional).  
8. Trigger print (`window.print()` atau local helper).  
9. Selesai; tidak ada perubahan status di BE.

### **B. POS 2 — Perangkat B (Perwakilan)**

1. Operator login.  
2. Operator buka halaman Perwakilan → isi form data perwakilan. (Tidak disimpan permanent oleh FE — boleh disimpan session)  
3. FE memanggil `POST /representatives` → dapat `rep_id`.  
4. Operator mulai scan beberapa tiket:  
   * Untuk setiap scan: `POST /tickets/scan` → tampil data peserta → push ke `scanned_list`.  
   * Jika tiket punya status `VALIDATED` → ditolak, tampil alasan, skip.  
5. Setelah selesai, operator klik \[CETAK PERWAKILAN\].  
6. FE memanggil `POST /prints/payload` (type=`power_of_attorney`, rep\_id, participant\_ids\[\]).  
7. Terima payload gabungan → bind ke XML surat kuasa \+ daftar peserta → preview → print.  
8. Selesai; BE tidak ubah status.

### **C. POS 4 — Validasi (Scan mode utama)**

1. Operator login.  
2. Operator pilih mode SCAN (atau manual).  
3. Scan tiket → FE memanggil `POST /tickets/scan`.  
4. Jika `200` dan `status == NOT_VALIDATED` → tampil tombol \[VALIDASI SEKARANG\].  
5. Operator konfirmasi (pastikan TTD di kertas ada).  
6. FE memanggil `POST /validate` dengan `participant_id` (opsional idempotency key).  
7. Jika `200` → tampil sukses & blokir aksi selanjutnya (kunci UI untuk peserta ini).  
8. Jika `409` → tampil "sudah divalidasi".  
9. Jika `404` → tampil "peserta tidak ditemukan".

---

## **4\. Mapping FE → BE (ringkas dan eksplisit)**

| Action FE | Endpoint BE | Purpose |
| ----- | ----- | ----- |
| Login | `POST /auth/login` | Ambil token operator |
| Scan ticket (show) | `POST /tickets/scan` | Dapatkan ringkasan peserta (READ ONLY) |
| Print pickup | `POST /prints/payload` | Dapatkan payload data lengkap untuk XML |
| Create representative | `POST /representatives` | Simpan rep session → dapat rep\_id |
| Assign rep → participants | `POST /representatives/{id}/assign` | Kaitkan peserta (BE hanya menyimpan relasi) |
| Search participant (backup) | `GET /participants/search` | Cari peserta untuk POS4 |
| Validate participant | `POST /validate` | Ubah status menjadi `VALIDATED` |

Catatan: FE harus membawa `Authorization: Bearer <token>` di header untuk semua call selain login.

---

## **5\. Spesifikasi Template XML** 

Frontend wajib menyediakan dua template XML (tata nama dan field harus konsisten dengan payload BE):

### **A. Template `pickup_sheet.xml` — fields (masih perlu disesuaikan):**

* `participant.id`  
* `participant.name`  
* `participant.ticket_code`  
* `participant.ticket_type`  
* `participant.bib_number`  
* `participant.jersey_size`  
* `participant.gender`  
* `participant.phone` (jika tersedia)  
* `event.name`  
* `event.date`  
* `generated_at`  
* `operator.name`

### **B. Template `power_of_attorney.xml` — fields:**

* `representative.name`  
* `representative.ktp_number`  
* `representative.dob`  
* `representative.address`  
* `representative.phone`  
* `representative.relationship`  
* `event.name`  
* `generated_at`  
* `operator.name`  
* `participants[]` where each participant entry has:  
  * `id`, `name`, `ticket_code`, `ticket_type`, `bib_number`, `jersey_size`

FE hanya melakukan string substitution / XML binding. Jangan lakukan kalkulasi logika di template.

---

## **6\. UX / Behaviour rules (penting untuk developer)**

* **Debounce scan input**: setelah satu scan sukses, ignore scan berikutnya untuk 00–1000 ms untuk mencegah double reads.  
* **Disable tombol saat request in-flight**: mencegah double-click validate/print.  
* **Visual feedback**: gunakan warna & ikon: hijau \= sukses, merah \= error, kuning \= peringatan.  
* **Timeouts**: tampilkan pesan jika API tidak respon dalam 6s; beri tombol Retry.  
* **Idempotency**: saat memanggil `POST /validate`, FE dapat menyertakan `Idempotency-Key` header (UUID) agar retry aman.  
* **Error handling mapping**:  
  * `404` → "Data tidak ditemukan" (tampilkan modal)  
  * `409` → "Sudah divalidasi" (tampilkan info, jangan panggil validate lagi)  
  * `400` → "Input tidak lengkap" (highlight field)

* **Preview before print**: optional tapi direkomendasikan untuk perwakilan (surat kuasa).  
* **Session storage**: simpan `rep_id` dan scanned\_list di session storage agar page reload tidak hilang selama sesi.  
* **Accessibility**: keyboard focus ke scan input; layar besar (font besar) untuk jarak pandang lapangan.

