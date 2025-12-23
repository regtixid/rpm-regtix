/**
 * Validators for form inputs
 */

export const validateEmail = (email) => {
  if (!email) return 'Email wajib diisi';
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) return 'Format email tidak valid';
  return null;
};

export const validateKTP = (ktp) => {
  if (!ktp) return 'Nomor KTP wajib diisi';
  const ktpRegex = /^\d{16}$/;
  if (!ktpRegex.test(ktp)) return 'Nomor KTP harus 16 digit angka';
  return null;
};

export const validatePhone = (phone) => {
  if (!phone) return 'Nomor telepon wajib diisi';
  const phoneRegex = /^(\+62|62|0)[0-9]{9,12}$/;
  if (!phoneRegex.test(phone)) return 'Format nomor telepon tidak valid';
  return null;
};

export const validateTicketCode = (code) => {
  if (!code) return 'Kode tiket wajib diisi';
  if (code.length < 5) return 'Kode tiket terlalu pendek';
  return null;
};

export const validateRequired = (value, fieldName = 'Field') => {
  if (!value || value.trim() === '') {
    return `${fieldName} wajib diisi`;
  }
  return null;
};

export const validateDate = (date) => {
  if (!date) return 'Tanggal wajib diisi';
  const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
  if (!dateRegex.test(date)) return 'Format tanggal tidak valid (YYYY-MM-DD)';
  return null;
};





















