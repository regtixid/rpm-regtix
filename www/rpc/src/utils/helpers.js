/**
 * Helper functions
 */

/**
 * Format date to Indonesian format
 */
export const formatDate = (dateString) => {
  if (!dateString) return '-';
  const date = new Date(dateString);
  const options = { year: 'numeric', month: 'long', day: 'numeric' };
  return date.toLocaleDateString('id-ID', options);
};

/**
 * Format currency to Indonesian Rupiah
 */
export const formatCurrency = (amount) => {
  if (!amount && amount !== 0) return '-';
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    minimumFractionDigits: 0,
  }).format(amount);
};

/**
 * Get user-friendly error message
 */
export const getErrorMessage = (error) => {
  if (typeof error === 'string') return error;
  
  if (error?.response?.data?.message) {
    return error.response.data.message;
  }
  
  if (error?.message) {
    return error.message;
  }
  
  return 'Terjadi kesalahan. Silakan coba lagi.';
};

/**
 * Debounce function
 */
export const debounce = (func, wait) => {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
};

/**
 * Format registration code for display
 */
export const formatRegistrationCode = (code) => {
  if (!code) return '-';
  return code.toUpperCase();
};

/**
 * Get status badge class
 */
export const getStatusBadgeClass = (status) => {
  const statusMap = {
    NOT_VALIDATED: 'bg-yellow-100 text-yellow-800',
    VALIDATED: 'bg-green-100 text-green-800',
    PENDING: 'bg-blue-100 text-blue-800',
  };
  return statusMap[status] || 'bg-gray-100 text-gray-800';
};





















