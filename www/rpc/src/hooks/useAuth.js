import { useState, useEffect } from 'react';
import { isAuthenticated, getUser, logout as authLogout } from '../services/auth';

/**
 * Custom hook for authentication state management
 */
export const useAuth = () => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Check if user is authenticated on mount
    const checkAuth = () => {
      if (isAuthenticated()) {
        const userData = getUser();
        setUser(userData);
      }
      setLoading(false);
    };
    checkAuth();
  }, []);

  const login = (userData, token) => {
    localStorage.setItem('rpc_token', token);
    localStorage.setItem('rpc_user', JSON.stringify(userData));
    setUser(userData);
  };

  const logout = () => {
    authLogout();
    setUser(null);
  };

  return {
    user,
    isAuthenticated: isAuthenticated(),
    loading,
    login,
    logout,
  };
};

