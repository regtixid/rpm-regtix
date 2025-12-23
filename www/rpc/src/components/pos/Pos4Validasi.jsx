import { useState } from 'react';
import { useRpcApi } from '../../hooks/useRpcApi';
import { useAuth } from '../../hooks/useAuth';
import { useEvent } from '../../contexts/EventContext';
import QRScanner from '../qr/QRScanner';
import ParticipantCard from '../common/ParticipantCard';
import LoadingSpinner from '../common/LoadingSpinner';
import ErrorMessage from '../common/ErrorMessage';
import Header from '../common/Header';

const Pos4Validasi = () => {
  const [mode, setMode] = useState('SCAN'); // 'SCAN' or 'SEARCH'
  const [participant, setParticipant] = useState(null);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [showConfirmModal, setShowConfirmModal] = useState(false);
  const [note, setNote] = useState('');
  const { scanTicket, searchParticipants, validateParticipant, loading, error } = useRpcApi();
  const { user } = useAuth();
  const { selectedEventId, authorizedEvents } = useEvent();

  const handleScanSuccess = async (code) => {
    setParticipant(null);
    setSearchResults([]);
    try {
      const data = await scanTicket(code);
      setParticipant(data);
    } catch {
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
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'Pos4Validasi.jsx:31',message:'handleSearch called',data:{searchKeyword,trimmedKeyword:searchKeyword.trim(),selectedEventId},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'H1'})}).catch(()=>{});
    // #endregion
    
    try {
      // Use selectedEventId from context (useRpcApi will handle fallback)
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'Pos4Validasi.jsx:40',message:'Calling searchParticipants',data:{keyword:searchKeyword.trim(),selectedEventId,status:'NOT_VALIDATED'},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'H1'})}).catch(()=>{});
      // #endregion
      const results = await searchParticipants(searchKeyword.trim(), null, 'NOT_VALIDATED');
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'Pos4Validasi.jsx:42',message:'Search results received',data:{resultsCount:results?.length,resultsIsArray:Array.isArray(results),firstResult:results?.[0]},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'H5'})}).catch(()=>{});
      // #endregion
      setSearchResults(results);
      
      if (results.length === 1) {
        // Auto-select if only one result
        setParticipant(results[0]);
      }
    } catch (err) {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'Pos4Validasi.jsx:49',message:'Error in handleSearch',data:{errorMessage:err?.message},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'H5'})}).catch(()=>{});
      // #endregion
      // Error is handled by useRpcApi hook
    }
  };

  const handleSelectParticipant = (selectedParticipant) => {
    setParticipant(selectedParticipant);
    setSearchResults([]);
  };

  const handleValidate = async () => {
    if (!participant) return;

    try {
      await validateParticipant(participant.participant_id || participant.id, note);
      
      // Update participant status
      setParticipant((prev) => ({
        ...prev,
        status: 'VALIDATED',
      }));
      
      setShowConfirmModal(false);
      setNote('');
      
      // Show success message (you can use a toast library here)
      alert('Validasi berhasil!');
    } catch {
      // Error is handled by useRpcApi hook
    }
  };

  const handleReset = () => {
    setParticipant(null);
    setSearchKeyword('');
    setSearchResults([]);
    setNote('');
    setShowConfirmModal(false);
  };

  return (
    <div className="min-h-screen bg-background">
      <Header title="POS 4 - VALIDASI" subtitle="Validasi Final - Pengambilan Race Pack" showBackButton={true} />
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
          {/* Left Column - Input */}
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

          {/* Right Column - Participant Card & Actions */}
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
                  {participant.status === 'VALIDATED' ? (
                    <div className="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg">
                      <p className="font-semibold">✓ Peserta sudah divalidasi</p>
                      <p className="text-sm mt-1">
                        Tidak dapat divalidasi ulang
                      </p>
                    </div>
                  ) : (
                    <div className="space-y-4">
                      <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">
                          Catatan (Opsional)
                        </label>
                        <textarea
                          value={note}
                          onChange={(e) => setNote(e.target.value)}
                          className="input-field"
                          rows={3}
                          placeholder="Catatan tambahan..."
                          maxLength={500}
                          disabled={loading}
                        />
                        <p className="text-xs text-gray-500 mt-1">
                          {note.length}/500 karakter
                        </p>
                      </div>

                      <button
                        onClick={() => setShowConfirmModal(true)}
                        className="btn-success w-full"
                        disabled={loading}
                      >
                        VALIDASI SEKARANG
                      </button>
                    </div>
                  )}
                </div>

                <div className="card">
                  <button
                    onClick={handleReset}
                    className="btn-secondary w-full"
                    disabled={loading}
                  >
                    Reset
                  </button>
                </div>
              </>
            )}

            {!participant && !loading && (
              <div className="card text-center py-8 text-gray-500">
                <p>
                  {mode === 'SCAN'
                    ? 'Scan atau input kode tiket untuk melihat data peserta'
                    : 'Cari peserta untuk melihat data dan melakukan validasi'}
                </p>
              </div>
            )}
          </div>
        </div>

        {/* Confirmation Modal */}
        {showConfirmModal && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
              <h3 className="text-xl font-bold mb-4">Konfirmasi Validasi</h3>
              <p className="text-gray-700 mb-4">
                Apakah Anda yakin ingin memvalidasi pengambilan RPC untuk peserta ini?
              </p>
              {participant && (
                <div className="bg-gray-50 p-3 rounded-lg mb-4">
                  <p><strong>Nama:</strong> {participant.name}</p>
                  <p><strong>Registration Code:</strong> {participant.registration_code}</p>
                  <p><strong>BIB:</strong> {participant.bib_number}</p>
                </div>
              )}
              {note && (
                <div className="mb-4">
                  <p className="text-sm text-gray-600"><strong>Catatan:</strong> {note}</p>
                </div>
              )}
              <div className="flex gap-3">
                <button
                  onClick={() => setShowConfirmModal(false)}
                  className="btn-secondary flex-1"
                  disabled={loading}
                >
                  Batal
                </button>
                <button
                  onClick={handleValidate}
                  className="btn-success flex-1"
                  disabled={loading}
                >
                  {loading ? <LoadingSpinner size="sm" /> : 'Ya, Validasi'}
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default Pos4Validasi;

