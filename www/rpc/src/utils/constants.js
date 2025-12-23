// API Configuration
export const API_BASE_URL = 'https://rpm.regtix.id/api/rpc/v1';

// Routes
export const ROUTES = {
  LOGIN: '/',
  MAIN_MENU: '/',
  POS2_MANDIRI: '/pos2-mandiri',
  POS2_PERWAKILAN: '/pos2-perwakilan',
  POS4_VALIDASI: '/pos4-validasi',
};

// Status Colors
export const STATUS_COLORS = {
  NOT_VALIDATED: 'text-yellow-600 bg-yellow-50',
  VALIDATED: 'text-green-600 bg-green-50',
  PENDING: 'text-blue-600 bg-blue-50',
};

// Error Messages Mapping
export const ERROR_MESSAGES = {
  NETWORK_ERROR: 'Koneksi jaringan bermasalah. Silakan coba lagi.',
  TIMEOUT_ERROR: 'Request timeout. Silakan coba lagi.',
  UNAUTHORIZED: 'Session telah berakhir. Silakan login kembali.',
  NOT_FOUND: 'Data tidak ditemukan.',
  CONFLICT: 'Data sudah pernah diproses sebelumnya.',
  VALIDATION_ERROR: 'Data yang dimasukkan tidak valid.',
  UNKNOWN_ERROR: 'Terjadi kesalahan. Silakan coba lagi.',
};

// Local Storage Keys
export const STORAGE_KEYS = {
  TOKEN: 'rpc_token',
  USER: 'rpc_user',
};

// Request Timeout (seconds)
export const REQUEST_TIMEOUT = 10;

// Debounce Delay (milliseconds)
export const DEBOUNCE_DELAY = 500;





















