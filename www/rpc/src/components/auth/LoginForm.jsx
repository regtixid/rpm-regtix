import { useState } from 'react';
import { useRpcApi } from '../../hooks/useRpcApi';
import { useAuth } from '../../hooks/useAuth';
import { validateEmail } from '../../utils/validators';
import LoadingSpinner from '../common/LoadingSpinner';
import ErrorMessage from '../common/ErrorMessage';

const LoginForm = ({ onLoginSuccess }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errors, setErrors] = useState({});
  const { login: apiLogin } = useRpcApi();
  const { login: authLogin } = useAuth();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);
    setErrors({});

    // Validation
    const emailError = validateEmail(email);
    if (emailError) {
      setErrors({ email: emailError });
      return;
    }

    if (!password) {
      setErrors({ password: 'Password wajib diisi' });
      return;
    }

    setLoading(true);
    try {
      const response = await apiLogin(email, password);
      
      // Validasi penting: Jika events array kosong atau tidak ada, prevent login
      const events = response.user?.events || [];
      if (!events || events.length === 0) {
        setError('Akun Anda tidak memiliki akses ke event manapun. Silakan hubungi administrator.');
        setLoading(false);
        return;
      }
      
      // Update user object dengan events array
      const userWithEvents = {
        ...response.user,
        events: events,
      };
      
      authLogin(userWithEvents, response.token);
      
      // Trigger custom event untuk refresh EventContext
      window.dispatchEvent(new Event('rpc:user-logged-in'));
      
      if (onLoginSuccess) {
        onLoginSuccess(response);
      }
    } catch (err) {
      setError(err.message || 'Login gagal. Silakan coba lagi.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            RPC REGTIX SYSTEM
          </h2>
          <p className="mt-2 text-center text-sm text-gray-600">
            Login untuk mengakses sistem Race Pack Collection
          </p>
        </div>
        
        <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
          <div className="card space-y-4">
            <ErrorMessage message={error} />
            
            <div>
              <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                Email
              </label>
              <input
                id="email"
                name="email"
                type="email"
                autoComplete="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className={`input-field mt-1 ${errors.email ? 'border-red-500' : ''}`}
                placeholder="operator@example.com"
                disabled={loading}
              />
              {errors.email && (
                <p className="mt-1 text-sm text-red-600">{errors.email}</p>
              )}
            </div>

            <div>
              <label htmlFor="password" className="block text-sm font-medium text-gray-700">
                Password
              </label>
              <input
                id="password"
                name="password"
                type="password"
                autoComplete="current-password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className={`input-field mt-1 ${errors.password ? 'border-red-500' : ''}`}
                placeholder="Masukkan password"
                disabled={loading}
              />
              {errors.password && (
                <p className="mt-1 text-sm text-red-600">{errors.password}</p>
              )}
            </div>

            <div>
              <button
                type="submit"
                className="btn-primary w-full"
                disabled={loading}
              >
                {loading ? (
                  <span className="flex items-center justify-center">
                    <LoadingSpinner size="sm" />
                    <span className="ml-2">Memproses...</span>
                  </span>
                ) : (
                  'Login'
                )}
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default LoginForm;





















