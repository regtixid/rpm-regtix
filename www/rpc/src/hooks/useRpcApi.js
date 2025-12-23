import { useState, useCallback } from 'react';
import api from '../services/api';
import { getErrorMessage } from '../utils/helpers';
import { useEvent } from '../contexts/EventContext';

/**
 * Custom hook for RPC API calls
 */
export const useRpcApi = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const { selectedEventId, authorizedEvents } = useEvent();

  const login = useCallback(async (email, password) => {
    setLoading(true);
    setError(null);
    try {
      const response = await api.post('/auth/login', { email, password });
      if (response.data.success) {
        return response.data.data;
      } else {
        throw new Error(response.data.message || 'Login gagal');
      }
    } catch (err) {
      const errorMsg = getErrorMessage(err);
      setError(errorMsg);
      throw new Error(errorMsg);
    } finally {
      setLoading(false);
    }
  }, []);

  const scanTicket = useCallback(async (ticketCode) => {
    setLoading(true);
    setError(null);
    try {
      const response = await api.post('/tickets/scan', { ticket_code: ticketCode });
      if (response.data.success) {
        return response.data.data;
      } else {
        throw new Error(response.data.message || 'Scan tiket gagal');
      }
    } catch (err) {
      const errorMsg = getErrorMessage(err);
      setError(errorMsg);
      throw new Error(errorMsg);
    } finally {
      setLoading(false);
    }
  }, []);

  const getPrintPayload = useCallback(async (printType, participantIds, eventId = null, representativeData = null) => {
    setLoading(true);
    setError(null);
    try {
      // Use selectedEventId from context if eventId not provided
      let finalEventId = eventId;
      if (!finalEventId) {
        if (selectedEventId) {
          finalEventId = selectedEventId;
        } else if (authorizedEvents && authorizedEvents.length > 0) {
          finalEventId = authorizedEvents[0].id;
        } else {
          throw new Error('Event tidak tersedia. Pastikan Anda memiliki akses ke event.');
        }
      }
      
      const payload = {
        print_type: printType,
        participant_ids: participantIds,
        event_id: finalEventId,
      };
      
      if (printType === 'power_of_attorney' && representativeData) {
        payload.representative_data = representativeData;
      }

      const response = await api.post('/prints/payload', payload);
      if (response.data.success) {
        return response.data.data;
      } else {
        throw new Error(response.data.message || 'Gagal mengambil payload cetak');
      }
    } catch (err) {
      const errorMsg = getErrorMessage(err);
      setError(errorMsg);
      throw new Error(errorMsg);
    } finally {
      setLoading(false);
    }
  }, [selectedEventId, authorizedEvents]);

  const searchParticipants = useCallback(async (keyword, eventId = null, status = null) => {
    setLoading(true);
    setError(null);
    
    // Use selectedEventId from context if eventId not provided
    let finalEventId = eventId;
    if (!finalEventId) {
      if (selectedEventId) {
        finalEventId = selectedEventId;
      } else if (authorizedEvents && authorizedEvents.length > 0) {
        finalEventId = authorizedEvents[0].id;
      } else {
        // Try to get from localStorage as fallback
        const user = JSON.parse(localStorage.getItem('rpc_user') || '{}');
        if (user.events && user.events.length > 0) {
          finalEventId = user.events[0].id;
        } else {
          setLoading(false);
          throw new Error('Event tidak tersedia. Pastikan Anda memiliki akses ke event.');
        }
      }
    }
    
    // Debug logging (remove in production)
    console.log('🔍 Search Participants:', {
      keyword,
      eventId,
      selectedEventId,
      finalEventId,
      authorizedEventsCount: authorizedEvents?.length || 0
    });
    
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'useRpcApi.js:79',message:'searchParticipants called',data:{keyword,eventId:finalEventId,status,keywordLength:keyword?.length},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'H1'})}).catch(()=>{});
    // #endregion
    try {
      // Build URL - only include event_id if it's provided and valid
      let url = `/participants/search?keyword=${encodeURIComponent(keyword)}`;
      if (finalEventId && finalEventId > 0) {
        url += `&event_id=${finalEventId}`;
      }
      if (status) {
        url += `&status=${status}`;
      }
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'useRpcApi.js:85',message:'Request URL built',data:{url,encodedKeyword:encodeURIComponent(keyword)},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'H1'})}).catch(()=>{});
      // #endregion

      const response = await api.get(url);
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'useRpcApi.js:90',message:'Response received',data:{success:response.data.success,dataCount:response.data.data?.length,hasData:!!response.data.data,firstItem:response.data.data?.[0]},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'H5'})}).catch(()=>{});
      // #endregion
      if (response.data.success) {
        return response.data.data;
      } else {
        throw new Error(response.data.message || 'Pencarian gagal');
      }
    } catch (err) {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'useRpcApi.js:96',message:'Error in searchParticipants',data:{errorMessage:err?.message,errorName:err?.name,hasResponse:!!err?.response,responseStatus:err?.response?.status,responseData:err?.response?.data},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'H5'})}).catch(()=>{});
      // #endregion
      const errorMsg = getErrorMessage(err);
      setError(errorMsg);
      throw new Error(errorMsg);
    } finally {
      setLoading(false);
    }
  }, [selectedEventId, authorizedEvents]);

  const validateParticipant = useCallback(async (participantId, note = null) => {
    setLoading(true);
    setError(null);
    try {
      const payload = { participant_id: participantId };
      if (note) {
        payload.note = note;
      }

      const response = await api.post('/validate', payload);
      if (response.data.success) {
        return response.data.data;
      } else {
        throw new Error(response.data.message || 'Validasi gagal');
      }
    } catch (err) {
      const errorMsg = getErrorMessage(err);
      setError(errorMsg);
      throw new Error(errorMsg);
    } finally {
      setLoading(false);
    }
  }, []);

  return {
    loading,
    error,
    login,
    scanTicket,
    getPrintPayload,
    searchParticipants,
    validateParticipant,
  };
};

