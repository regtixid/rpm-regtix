import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../hooks/useAuth';
import { useEvent } from '../../contexts/EventContext';

const Header = ({ title, subtitle, showBackButton = false }) => {
  const { user, logout } = useAuth();
  const { selectedEventId, authorizedEvents, setSelectedEvent, hasMultipleEvents, getSelectedEvent } = useEvent();
  const navigate = useNavigate();

  const handleEventChange = (e) => {
    const eventId = parseInt(e.target.value);
    if (eventId) {
      setSelectedEvent(eventId);
    }
  };

  return (
    <header className="bg-white shadow-sm border-b border-border">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center py-4">
          <div className="flex items-center gap-4">
            <img src="/images/color.png" alt="Regtix Logo" className="h-10 w-auto" />
            {showBackButton && (
              <button
                onClick={() => navigate('/')}
                className="btn-secondary text-sm flex items-center gap-2"
                title="Kembali ke Menu Utama"
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                <span>Kembali</span>
              </button>
            )}
            <div>
              <h1 className="text-2xl font-bold text-gray-900">{title}</h1>
              {subtitle && <p className="text-sm text-gray-600 mt-1">{subtitle}</p>}
            </div>
          </div>
          {user && (
            <div className="flex items-center space-x-4">
              {hasMultipleEvents() && (
                <div className="flex items-center gap-2">
                  <label htmlFor="event-selector" className="text-sm font-medium text-gray-700">
                    Event:
                  </label>
                  <select
                    id="event-selector"
                    value={selectedEventId || ''}
                    onChange={handleEventChange}
                    className="input-field text-sm py-1 px-2"
                  >
                    {authorizedEvents.map((event) => (
                      <option key={event.id} value={event.id}>
                        {event.name}
                      </option>
                    ))}
                  </select>
                </div>
              )}
              <div className="text-right">
                <p className="text-sm font-medium text-gray-900">{user.name}</p>
                <p className="text-xs text-gray-500">{user.email}</p>
              </div>
              <button
                onClick={logout}
                className="btn-secondary text-sm"
              >
                Logout
              </button>
            </div>
          )}
        </div>
      </div>
    </header>
  );
};

export default Header;

