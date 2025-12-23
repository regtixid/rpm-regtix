import axios from 'axios';
import { API_BASE_URL, REQUEST_TIMEOUT, STORAGE_KEYS, ERROR_MESSAGES } from '../utils/constants';

// Create axios instance
const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: REQUEST_TIMEOUT * 1000,
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
});

// Request interceptor - Add token to headers
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem(STORAGE_KEYS.TOKEN);
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor - Handle errors
api.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    // Handle 401 Unauthorized - Auto logout
    if (error.response?.status === 401) {
      localStorage.removeItem(STORAGE_KEYS.TOKEN);
      localStorage.removeItem(STORAGE_KEYS.USER);
      // Redirect to login if not already there
      if (window.location.pathname !== '/') {
        window.location.href = '/';
      }
    }
    
    // Handle network errors
    if (!error.response) {
      if (error.code === 'ECONNABORTED') {
        error.message = ERROR_MESSAGES.TIMEOUT_ERROR;
      } else {
        error.message = ERROR_MESSAGES.NETWORK_ERROR;
      }
    }
    
    return Promise.reject(error);
  }
);

export default api;





















