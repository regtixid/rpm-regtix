import { STORAGE_KEYS } from '../utils/constants';

/**
 * Auth service for token and user management
 */

export const getToken = () => {
  return localStorage.getItem(STORAGE_KEYS.TOKEN);
};

export const setToken = (token) => {
  localStorage.setItem(STORAGE_KEYS.TOKEN, token);
};

export const removeToken = () => {
  localStorage.removeItem(STORAGE_KEYS.TOKEN);
};

export const getUser = () => {
  const userStr = localStorage.getItem(STORAGE_KEYS.USER);
  if (!userStr) return null;
  try {
    return JSON.parse(userStr);
  } catch {
    return null;
  }
};

export const setUser = (user) => {
  localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(user));
};

export const removeUser = () => {
  localStorage.removeItem(STORAGE_KEYS.USER);
};

export const isAuthenticated = () => {
  return !!getToken();
};

export const logout = () => {
  removeToken();
  removeUser();
};





















