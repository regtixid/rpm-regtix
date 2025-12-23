import { useState } from 'react';
import { useRpcApi } from '../../hooks/useRpcApi';
import { useAuth } from '../../hooks/useAuth';
import { useEvent } from '../../contexts/EventContext';
import { useDebounce } from '../../hooks/useDebounce';
import QRScanner from '../qr/QRScanner';
import ParticipantCard from '../common/ParticipantCard';
import LoadingSpinner from '../common/LoadingSpinner';
import ErrorMessage from '../common/ErrorMessage';
import PrintPreview from '../print/PrintPreview';
import Header from '../common/Header';
import { generatePickupSheetHTML, printDocument } from '../print/PrintService';

const Pos2Mandiri = () => {
  const [mode, setMode] = useState('SCAN'); // 'SCAN' or 'SEARCH'
  const [participant, setParticipant] = useState(null);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [showPrintPreview, setShowPrintPreview] = useState(false);
  const { scanTicket, searchParticipants, getPrintPayload, loading, error } = useRpcApi();
  const { user } = useAuth();
  const { selectedEventId, authorizedEvents } = useEvent();

  const handleScanSuccess = async (code) => {
    setParticipant(null);
    setSearchResults([]);
    try {
      const data = await scanTicket(code);
      // Scan result uses 'participant_id', normalize to 'id' for consistency
      if (data.participant_id && !data.id) {
        data.id = data.participant_id;
      }
      setParticipant(data);
    } catch (err) {
      // Error is handled by useRpcApi hook
    }
  };

  const handleSearch = async (e) => {
    e.preventDefault();
    if (!searchKeyword.trim()) return;

    // Error handling: Jika selectedEventId null dan authorizedEvents kosong, tampilkan error
    if (!selectedEventId && (!authorizedEvents || authorizedEvents.length === 0)) {
      return;
    }

    setParticipant(null);
    setSearchResults([]);
    
    try {
      // Use selectedEventId from context (useRpcApi will handle fallback)
      const results = await searchParticipants(searchKeyword.trim(), null);
      setSearchResults(results);
      
      if (results.length === 1) {
        // Auto-select if only one result
        setParticipant(results[0]);
      }
    } catch {
      // Error is handled by useRpcApi hook
    }
  };

  const handleSelectParticipant = (selectedParticipant) => {
    setParticipant(selectedParticipant);
    setSearchResults([]);
  };

  const handlePrint = async () => {
    if (!participant) return;

    // Error handling: Jika selectedEventId null dan authorizedEvents kosong, tampilkan error
    if (!selectedEventId && (!authorizedEvents || authorizedEvents.length === 0)) {
      return;
    }

    try {
      // Use selectedEventId from context (useRpcApi will handle fallback)
      // Note: Search results use 'id', scan results use 'participant_id'
      // Normalize: ensure we have the correct ID field
      const participantId = participant.id || participant.participant_id;
      
      if (!participantId) {
        console.error('Participant data:', participant);
        throw new Error('Participant ID tidak ditemukan. Pastikan peserta sudah dipilih dengan benar.');
      }
      
      console.log('Printing participant:', { participantId, participant });
      
      const payload = await getPrintPayload(
        'pickup_sheet',
        [participantId],
        null
      );

      // Try to use XML template first, fallback to HTML generator
      try {
        const { generateHTMLFromTemplate } = await import('../print/PrintService');
        const htmlContent = await generateHTMLFromTemplate('pickup_sheet', payload);
        printDocument(htmlContent);
      } catch (templateError) {
        // Fallback to simple HTML generator
        console.warn('Template not available, using fallback:', templateError);
        const htmlContent = generatePickupSheetHTML(
          payload.participants[0],
          payload.metadata?.event_name ? { name: payload.metadata.event_name } : null
        );
        printDocument(htmlContent);
      }
    } catch (err) {
      // Error is handled by useRpcApi hook
    }
  };

  const handleReset = () => {
    setParticipant(null);
    setSearchKeyword('');
    setSearchResults([]);
  };

  return (
    <div className="min-h-screen bg-background">
      <Header title="POS 2 - MANDIRI" subtitle="Pengambilan Race Pack - Peserta Mandiri" showBackButton={true} />
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">

        <ErrorMessage message={error} />

        {/* Mode Toggle */}
        <div className="card mb-6">
          <div className="flex items-center gap-4">
            <span className="text-sm font-medium">Mode:</span>
            <label className="flex items-center cursor-pointer">
              <input
                type="radio"
                name="mode"
                value="SCAN"
                checked={mode === 'SCAN'}
                onChange={(e) => {
                  setMode(e.target.value);
                  handleReset();
                }}
                className="mr-2"
              />
              <span>SCAN</span>
            </label>
            <label className="flex items-center cursor-pointer">
              <input
                type="radio"
                name="mode"
                value="SEARCH"
                checked={mode === 'SEARCH'}
                onChange={(e) => {
                  setMode(e.target.value);
                  handleReset();
                }}
                className="mr-2"
              />
              <span>SEARCH MANUAL</span>
            </label>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Left Column - Scanner or Search */}
          <div className="space-y-6">
            {mode === 'SCAN' ? (
              <QRScanner
                onScanSuccess={handleScanSuccess}
                onError={(err) => console.error(err)}
                manualInput={true}
              />
            ) : (
              <div className="card">
                <h3 className="text-lg font-semibold mb-4">Cari Peserta</h3>
                <form onSubmit={handleSearch} className="space-y-4">
                  <div>
                    <input
                      type="text"
                      value={searchKeyword}
                      onChange={(e) => setSearchKeyword(e.target.value)}
                      placeholder="No Tiket, Nama Peserta, No Telp, atau Email"
                      className="input-field"
                      disabled={loading}
                    />
                  </div>
                  <button
                    type="submit"
                    className="btn-primary w-full"
                    disabled={loading || !searchKeyword.trim()}
                  >
                    {loading ? <LoadingSpinner size="sm" /> : 'Cari'}
                  </button>
                </form>

                {/* Search Results Table */}
                {searchResults.length > 0 && (
                  <div className="mt-4">
                    <h4 className="font-semibold mb-3">Hasil Pencarian ({searchResults.length})</h4>
                    <div className="overflow-x-auto max-h-96 overflow-y-auto border rounded-lg">
                      <table className="min-w-full divide-y divide-gray-200">
                        <thead className="bg-gray-50 sticky top-0">
                          <tr>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                              Nama
                            </th>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                              Reg Code
                            </th>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                              BIB
                            </th>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                              Alamat
                            </th>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                              Phone
                            </th>
                          </tr>
                        </thead>
                        <tbody className="bg-white divide-y divide-gray-200">
                          {searchResults.map((result) => (
                            <tr
                              key={result.id}
                              onClick={() => handleSelectParticipant(result)}
                              className={`cursor-pointer transition-colors ${
                                participant?.id === result.id
                                  ? 'bg-blue-50 hover:bg-blue-100'
                                  : 'hover:bg-gray-50'
                              }`}
                            >
                              <td className="px-4 py-3 whitespace-nowrap">
                                <div className="text-sm font-medium text-gray-900">{result.name || '-'}</div>
                              </td>
                              <td className="px-4 py-3 whitespace-nowrap">
                                <div className="text-sm text-gray-900">{result.registration_code || '-'}</div>
                              </td>
                              <td className="px-4 py-3 whitespace-nowrap">
                                <div className="text-sm text-gray-900">{result.bib_number || '-'}</div>
                              </td>
                              <td className="px-4 py-3">
                                <div className="text-sm text-gray-900 max-w-xs truncate" title={result.address || ''}>
                                  {result.address || '-'}
                                </div>
                              </td>
                              <td className="px-4 py-3 whitespace-nowrap">
                                <div className="text-sm text-gray-900">{result.phone || '-'}</div>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Right Column - Participant Card */}
          <div className="space-y-6">
            {loading && !participant && (
              <div className="card text-center py-8">
                <LoadingSpinner />
                <p className="mt-4 text-gray-600">Memproses...</p>
              </div>
            )}

            {participant && (
              <>
                <ParticipantCard participant={participant} />

                <div className="card">
                  <div className="flex gap-4">
                    <button
                      onClick={handlePrint}
                      className="btn-success flex-1"
                      disabled={loading}
                    >
                      Print Pickup Sheet
                    </button>
                    <button
                      onClick={handleReset}
                      className="btn-secondary"
                      disabled={loading}
                    >
                      Reset
                    </button>
                  </div>
                </div>
              </>
            )}

            {!participant && !loading && (
              <div className="card text-center py-8 text-gray-500">
                <p>
                  {mode === 'SCAN'
                    ? 'Scan atau input kode tiket untuk melihat data peserta'
                    : 'Cari peserta untuk melihat data dan melakukan print'}
                </p>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Pos2Mandiri;

