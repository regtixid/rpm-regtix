import { useNavigate } from 'react-router-dom';
import { useAuth } from '../hooks/useAuth';
import Header from '../components/common/Header';
import { ROUTES } from '../utils/constants';

const MainMenuPage = () => {
  const navigate = useNavigate();
  const { user } = useAuth();

  const menuItems = [
    {
      title: 'POS 2 - MANDIRI',
      description: 'Pengambilan Race Pack untuk peserta mandiri',
      route: ROUTES.POS2_MANDIRI,
      icon: '👤',
    },
    {
      title: 'POS 2 - PERWAKILAN',
      description: 'Pengambilan Race Pack untuk peserta yang diwakili',
      route: ROUTES.POS2_PERWAKILAN,
      icon: '👥',
    },
    {
      title: 'POS 4 - VALIDASI',
      description: 'Validasi final pengambilan Race Pack',
      route: ROUTES.POS4_VALIDASI,
      icon: '✓',
    },
  ];

  return (
    <div className="min-h-screen bg-background">
      <Header title="RPC REGTIX SYSTEM" subtitle="Race Pack Collection" />
      
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="text-center mb-12">
          <h2 className="text-3xl font-bold text-gray-900 mb-2">Selamat Datang</h2>
          {user && (
            <p className="text-gray-600">
              {user.name} - {user.email}
            </p>
          )}
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {menuItems.map((item) => (
            <div
              key={item.route}
              onClick={() => navigate(item.route)}
              className="card cursor-pointer hover:shadow-lg transition-shadow duration-200"
            >
              <div className="text-center">
                <div className="text-6xl mb-4">{item.icon}</div>
                <h3 className="text-xl font-bold text-gray-900 mb-2">{item.title}</h3>
                <p className="text-gray-600 mb-4">{item.description}</p>
                <button className="btn-primary w-full">Buka</button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default MainMenuPage;





















