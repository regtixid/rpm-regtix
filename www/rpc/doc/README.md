# RPC REGTIX SYSTEM - Frontend Web Application

Frontend web application untuk sistem Race Pack Collection (RPC) pada platform Regtix.

## Deskripsi

Aplikasi web ini digunakan untuk:
- **POS 2 Mandiri**: Pengambilan race pack untuk peserta mandiri
- **POS 2 Perwakilan**: Pengambilan race pack untuk peserta yang diwakili
- **POS 4 Validasi**: Validasi final pengambilan race pack

## Teknologi

- **React** 19.2.0
- **Vite** 7.2.4
- **Tailwind CSS** 4.1.18
- **React Router DOM** 7.10.1
- **Axios** 1.13.2
- **html5-qrcode** 2.3.8

## Instalasi

```bash
cd www/rpc
npm install
```

## Development

```bash
npm run dev
```

Aplikasi akan berjalan di `http://localhost:5173`

## Build untuk Production

```bash
npm run build
```

File hasil build akan berada di folder `dist/`

## Deployment

### Via WinSCP

1. **Build project**:
   ```bash
   npm run build
   ```

2. **Upload ke server**:
   - Buka WinSCP dan connect ke server
   - Navigate ke folder `dist/` di komputer lokal
   - Drag & drop semua file di dalam `dist/` ke folder server (contoh: `/var/www/rpc/`)
   - Pastikan file `index.html` dan folder `assets/` ter-upload

3. **Struktur di Server**:
   ```
   /var/www/rpc/
   ├── index.html
   ├── assets/
   │   ├── index-[hash].js
   │   ├── index-[hash].css
   │   └── ...
   └── favicon.ico
   ```

4. **Konfigurasi Nginx**:
   ```nginx
   server {
       listen 80;
       server_name rpc.regtix.id;
       
       root /var/www/rpc;
       index index.html;
       
       location / {
           try_files $uri $uri/ /index.html;
       }
       
       location /assets/ {
           expires 1y;
           add_header Cache-Control "public, immutable";
       }
   }
   ```

## API Endpoints

Aplikasi ini menggunakan API backend di:
- **Base URL**: `https://rpm.regtix.id/api/rpc/v1`

Lihat `dokumentasi_API_RPC.md` untuk dokumentasi lengkap API.

## Struktur Project

```
www/rpc/
├── public/
│   └── index.html
├── src/
│   ├── components/
│   │   ├── auth/
│   │   ├── common/
│   │   ├── pos/
│   │   ├── print/
│   │   └── qr/
│   ├── hooks/
│   ├── pages/
│   ├── services/
│   ├── styles/
│   ├── utils/
│   ├── App.jsx
│   └── main.jsx
├── package.json
├── vite.config.js
├── tailwind.config.js
└── README.md
```

## Fitur

### Authentication
- Login dengan email/password
- Token management (localStorage)
- Auto logout jika token expired
- Protected routes

### POS 2 Mandiri
- Scan QR code atau input manual
- Display data peserta
- Print pickup sheet

### POS 2 Perwakilan
- Wizard 3 step:
  1. Input data perwakilan
  2. Scan multiple tickets
  3. Preview & print surat kuasa

### POS 4 Validasi
- Mode SCAN atau SEARCH
- Display data peserta
- Validasi final dengan konfirmasi

### QR Scanner
- Webcam scanning
- Manual input fallback
- Visual feedback

### Print Functionality
- Print preview
- Template rendering
- Print ke printer atau PDF

## Troubleshooting

### QR Scanner tidak bekerja
- Pastikan browser support camera API
- Check permission kamera di browser
- Gunakan HTTPS (camera API memerlukan secure context)

### API Error
- Check koneksi internet
- Verify API Base URL
- Check token masih valid (logout dan login kembali)

### Build Error
- Pastikan semua dependencies terinstall: `npm install`
- Clear cache: `rm -rf node_modules package-lock.json && npm install`

## License

© 2025 Regtix
