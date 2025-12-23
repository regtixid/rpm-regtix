import { createContext, useContext, useState, useEffect } from 'react';
import { getUser } from '../services/auth';

const EventContext = createContext(null);

const STORAGE_KEY = 'rpc_selected_event_id';

export const EventProvider = ({ children }) => {
  const [selectedEventId, setSelectedEventIdState] = useState(null);
  const [authorizedEvents, setAuthorizedEvents] = useState([]);
  const [loading, setLoading] = useState(true);

  // Initialize from user data and localStorage
  useEffect(() => {
    const initializeEvents = () => {
      const user = getUser();
      
      if (!user) {
        setAuthorizedEvents([]);
        setSelectedEventIdState(null);
        setLoading(false);
        return;
      }

      // Get authorized events from user object
      const events = user.events || [];
      setAuthorizedEvents(events);

      // Validasi penting: Jika authorized events kosong atau null, set null dan prevent akses
      if (!events || events.length === 0) {
        setSelectedEventIdState(null);
        setLoading(false);
        return;
      }

      // Try to get selected event from localStorage
      const storedEventId = localStorage.getItem(STORAGE_KEY);
      
      // Validate stored event ID is in authorized events
      if (storedEventId && events.some(e => e.id === parseInt(storedEventId))) {
        setSelectedEventIdState(parseInt(storedEventId));
      } else {
        // Default to first event
        const firstEventId = events[0]?.id;
        if (firstEventId) {
          setSelectedEventIdState(firstEventId);
          localStorage.setItem(STORAGE_KEY, firstEventId.toString());
        }
      }

      setLoading(false);
    };

    initializeEvents();
    
    // Listen for storage changes (when user logs in/out from other tabs)
    const handleStorageChange = () => {
      initializeEvents();
    };
    
    // Listen for custom login event (same tab)
    const handleLogin = () => {
      initializeEvents();
    };
    
    window.addEventListener('storage', handleStorageChange);
    window.addEventListener('rpc:user-logged-in', handleLogin);
    
    // Also check periodically (for same-tab updates)
    const interval = setInterval(initializeEvents, 500);
    
    return () => {
      window.removeEventListener('storage', handleStorageChange);
      window.removeEventListener('rpc:user-logged-in', handleLogin);
      clearInterval(interval);
    };
  }, []);

  const setSelectedEvent = (eventId) => {
    // Validate eventId is in authorized events
    if (!authorizedEvents.some(e => e.id === eventId)) {
      console.error('Event ID tidak valid atau tidak diotorisasi');
      return;
    }

    setSelectedEventIdState(eventId);
    localStorage.setItem(STORAGE_KEY, eventId.toString());
  };

  const getSelectedEvent = () => {
    if (!selectedEventId) return null;
    return authorizedEvents.find(e => e.id === selectedEventId) || null;
  };

  const hasMultipleEvents = () => {
    return authorizedEvents.length > 1;
  };

  const value = {
    selectedEventId,
    authorizedEvents,
    setSelectedEvent,
    getSelectedEvent,
    hasMultipleEvents,
    loading,
  };

  return <EventContext.Provider value={value}>{children}</EventContext.Provider>;
};

export const useEvent = () => {
  const context = useContext(EventContext);
  if (!context) {
    throw new Error('useEvent must be used within EventProvider');
  }
  return context;
};

















