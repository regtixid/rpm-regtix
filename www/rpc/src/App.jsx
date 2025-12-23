import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { useAuth } from './hooks/useAuth';
import LoginPage from './pages/LoginPage';
import MainMenuPage from './pages/MainMenuPage';
import Pos2Mandiri from './components/pos/Pos2Mandiri';
import Pos2Perwakilan from './components/pos/Pos2Perwakilan';
import Pos4Validasi from './components/pos/Pos4Validasi';
import NotFoundPage from './pages/NotFoundPage';
import Header from './components/common/Header';
import { ROUTES } from './utils/constants';

// Protected Route Component
const ProtectedRoute = ({ children }) => {
  const { isAuthenticated, loading } = useAuth();

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Memuat...</p>
        </div>
      </div>
    );
  }

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  return (
    <>
      {children}
    </>
  );
};

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<LoginPage />} />
        <Route
          path="/"
          element={
            <ProtectedRoute>
              <MainMenuPage />
            </ProtectedRoute>
          }
        />
        <Route
          path={ROUTES.POS2_MANDIRI}
          element={
            <ProtectedRoute>
              <Pos2Mandiri />
            </ProtectedRoute>
          }
        />
        <Route
          path={ROUTES.POS2_PERWAKILAN}
          element={
            <ProtectedRoute>
              <Pos2Perwakilan />
            </ProtectedRoute>
          }
        />
        <Route
          path={ROUTES.POS4_VALIDASI}
          element={
            <ProtectedRoute>
              <Pos4Validasi />
            </ProtectedRoute>
          }
        />
        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
