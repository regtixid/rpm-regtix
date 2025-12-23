import { useState } from 'react';
import { useRpcApi } from '../../hooks/useRpcApi';
import { useAuth } from '../../hooks/useAuth';
import { useEvent } from '../../contexts/EventContext';
import QRScanner from '../qr/QRScanner';
import ParticipantCard from '../common/ParticipantCard';
import LoadingSpinner from '../common/LoadingSpinner';
import ErrorMessage from '../common/ErrorMessage';
import PrintPreview from '../print/PrintPreview';
import Header from '../common/Header';
import { validateRequired, validateKTP, validatePhone, validateDate } from '../../utils/validators';

const Pos2Perwakilan = () => {
  const [currentStep, setCurrentStep] = useState(1);
  const [representativeData, setRepresentativeData] = useState({
    name: '',
    ktp_number: '',
    dob: '',
    address: '',
    phone: '',
    relationship: '',
  });
  const [participants, setParticipants] = useState([]);
  const [errors, setErrors] = useState({});
  const [printData, setPrintData] = useState(null);
  const [showPrintPreview, setShowPrintPreview] = useState(false);
  const { scanTicket, getPrintPayload, loading, error } = useRpcApi();
  const { user } = useAuth();
  const { selectedEventId, authorizedEvents } = useEvent();

  const handleRepresentativeChange = (field, value) => {
    setRepresentativeData((prev) => ({ ...prev, [field]: value }));
    // Clear error for this field
    if (errors[field]) {
      setErrors((prev) => {
        const newErrors = { ...prev };
        delete newErrors[field];
        return newErrors;
      });
    }
  };

  const validateStep1 = () => {
    const newErrors = {};
    
    const nameError = validateRequired(representativeData.name, 'Nama');
    if (nameError) newErrors.name = nameError;
    
    const ktpError = validateKTP(representativeData.ktp_number);
    if (ktpError) newErrors.ktp_number = ktpError;
    
    const dobError = validateDate(representativeData.dob);
    if (dobError) newErrors.dob = dobError;
    
    const addressError = validateRequired(representativeData.address, 'Alamat');
    if (addressError) newErrors.address = addressError;
    
    const phoneError = validatePhone(representativeData.phone);
    if (phoneError) newErrors.phone = phoneError;
    
    const relationshipError = validateRequired(representativeData.relationship, 'Hubungan');
    if (relationshipError) newErrors.relationship = relationshipError;

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleNext = () => {
    if (currentStep === 1) {
      if (validateStep1()) {
        setCurrentStep(2);
      }
    } else if (currentStep === 2) {
      if (participants.length > 0) {
        setCurrentStep(3);
      } else {
        setErrors({ participants: 'Minimal harus ada 1 peserta' });
      }
    }
  };

  const handlePrevious = () => {
    if (currentStep > 1) {
      setCurrentStep(currentStep - 1);
    }
  };

  const handleScanSuccess = async (code) => {
    try {
      const data = await scanTicket(code);
      
      // Scan result uses 'participant_id', normalize to 'id' for consistency
      if (data.participant_id && !data.id) {
        data.id = data.participant_id;
      }
      
      // Check if participant already exists (handle both id and participant_id)
      const participantId = data.id || data.participant_id;
      if (participants.some((p) => (p.id || p.participant_id) === participantId)) {
        setErrors({ participants: 'Peserta ini sudah ditambahkan' });
        return;
      }

      setParticipants((prev) => [...prev, data]);
      setErrors({});
    } catch {
      // Error is handled by useRpcApi hook
    }
  };

  const removeParticipant = (participantId) => {
    setParticipants((prev) => prev.filter((p) => (p.id || p.participant_id) !== participantId));
  };

  const handlePrint = async () => {
    // Error handling: Jika selectedEventId null dan authorizedEvents kosong, tampilkan error
    if (!selectedEventId && (!authorizedEvents || authorizedEvents.length === 0)) {
      return;
    }

    try {
      // Use selectedEventId from context (useRpcApi will handle fallback)
      // Note: Scan results use 'participant_id', normalize if needed
      const participantIds = participants.map((p) => p.id || p.participant_id).filter(id => id);
      
      if (participantIds.length === 0) {
        throw new Error('Tidak ada peserta yang valid untuk dicetak');
      }
      
      const payload = await getPrintPayload(
        'power_of_attorney',
        participantIds,
        null,
        representativeData
      );

      // Try to use XML template first, fallback to preview
      try {
        const { generateHTMLFromTemplate, printDocument } = await import('../print/PrintService');
        const htmlContent = await generateHTMLFromTemplate('power_of_attorney', payload);
        printDocument(htmlContent);
      } catch (templateError) {
        // Fallback to preview modal
        console.warn('Template not available, using preview:', templateError);
        setPrintData(payload);
        setShowPrintPreview(true);
      }
    } catch {
      // Error is handled by useRpcApi hook
    }
  };

  const handleReset = () => {
    setCurrentStep(1);
    setRepresentativeData({
      name: '',
      ktp_number: '',
      dob: '',
      address: '',
      phone: '',
      relationship: '',
    });
    setParticipants([]);
    setErrors({});
    setPrintData(null);
    setShowPrintPreview(false);
  };

  return (
    <div className="min-h-screen bg-background">
      <Header title="POS 2 - PERWAKILAN" subtitle="Pengambilan Race Pack - Perwakilan" showBackButton={true} />
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-6">
          <div className="mt-4">
            <div className="flex items-center justify-between">
              <span className="text-sm font-medium text-blue-600">
                Step {currentStep} of 3
              </span>
              <div className="flex-1 mx-4">
                <div className="w-full bg-gray-200 rounded-full h-2">
                  <div
                    className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                    style={{ width: `${(currentStep / 3) * 100}%` }}
                  ></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <ErrorMessage message={error} />

        {/* Step 1: Representative Data */}
        {currentStep === 1 && (
          <div className="card">
            <h2 className="text-xl font-semibold mb-4">Data Perwakilan</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Nama Lengkap <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  value={representativeData.name}
                  onChange={(e) => handleRepresentativeChange('name', e.target.value)}
                  className={`input-field ${errors.name ? 'border-red-500' : ''}`}
                  disabled={loading}
                />
                {errors.name && <p className="mt-1 text-sm text-red-600">{errors.name}</p>}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  No. KTP <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  value={representativeData.ktp_number}
                  onChange={(e) => handleRepresentativeChange('ktp_number', e.target.value)}
                  className={`input-field ${errors.ktp_number ? 'border-red-500' : ''}`}
                  maxLength={16}
                  disabled={loading}
                />
                {errors.ktp_number && <p className="mt-1 text-sm text-red-600">{errors.ktp_number}</p>}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Tanggal Lahir <span className="text-red-500">*</span>
                </label>
                <input
                  type="date"
                  value={representativeData.dob}
                  onChange={(e) => handleRepresentativeChange('dob', e.target.value)}
                  className={`input-field ${errors.dob ? 'border-red-500' : ''}`}
                  disabled={loading}
                />
                {errors.dob && <p className="mt-1 text-sm text-red-600">{errors.dob}</p>}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  No. Telepon <span className="text-red-500">*</span>
                </label>
                <input
                  type="tel"
                  value={representativeData.phone}
                  onChange={(e) => handleRepresentativeChange('phone', e.target.value)}
                  className={`input-field ${errors.phone ? 'border-red-500' : ''}`}
                  disabled={loading}
                />
                {errors.phone && <p className="mt-1 text-sm text-red-600">{errors.phone}</p>}
              </div>

              <div className="md:col-span-2">
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Alamat Lengkap <span className="text-red-500">*</span>
                </label>
                <textarea
                  value={representativeData.address}
                  onChange={(e) => handleRepresentativeChange('address', e.target.value)}
                  className={`input-field ${errors.address ? 'border-red-500' : ''}`}
                  rows={3}
                  disabled={loading}
                />
                {errors.address && <p className="mt-1 text-sm text-red-600">{errors.address}</p>}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Hubungan dengan Peserta <span className="text-red-500">*</span>
                </label>
                <select
                  value={representativeData.relationship}
                  onChange={(e) => handleRepresentativeChange('relationship', e.target.value)}
                  className={`input-field ${errors.relationship ? 'border-red-500' : ''}`}
                  disabled={loading}
                >
                  <option value="">Pilih Hubungan</option>
                  <option value="Teman">Teman</option>
                  <option value="Saudara">Saudara</option>
                  <option value="Rekan Kerja">Rekan Kerja</option>
                  <option value="Keluarga">Keluarga</option>
                  <option value="Lainnya">Lainnya</option>
                </select>
                {errors.relationship && <p className="mt-1 text-sm text-red-600">{errors.relationship}</p>}
              </div>
            </div>
          </div>
        )}

        {/* Step 2: Scan Participants */}
        {currentStep === 2 && (
          <div className="space-y-6">
            <div className="card">
              <h2 className="text-xl font-semibold mb-4">Scan Tiket Peserta</h2>
              <QRScanner
                onScanSuccess={handleScanSuccess}
                onError={(err) => console.error(err)}
                manualInput={true}
              />
              {errors.participants && (
                <p className="mt-2 text-sm text-red-600">{errors.participants}</p>
              )}
            </div>

            <div className="card">
              <h2 className="text-xl font-semibold mb-4">
                Daftar Peserta ({participants.length})
              </h2>
              {participants.length === 0 ? (
                <p className="text-gray-500 text-center py-4">Belum ada peserta ditambahkan</p>
              ) : (
                <div className="space-y-2">
                  {participants.map((participant) => {
                    const participantId = participant.id || participant.participant_id;
                    return (
                    <div
                      key={participantId}
                      className="flex items-center justify-between p-3 bg-gray-50 rounded-lg"
                    >
                      <div>
                        <p className="font-medium">{participant.name}</p>
                        <p className="text-sm text-gray-600">
                          {participant.registration_code} - BIB: {participant.bib_number}
                        </p>
                      </div>
                      <button
                        onClick={() => removeParticipant(participantId)}
                        className="text-red-600 hover:text-red-800"
                        disabled={loading}
                      >
                        <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                          <path
                            fillRule="evenodd"
                            d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                            clipRule="evenodd"
                          />
                        </svg>
                      </button>
                    </div>
                    );
                  })}
                </div>
              )}
            </div>
          </div>
        )}

        {/* Step 3: Preview & Print */}
        {currentStep === 3 && (
          <div className="space-y-6">
            <div className="card">
              <h2 className="text-xl font-semibold mb-4">Preview & Print</h2>
              <div className="space-y-4">
                <div>
                  <h3 className="font-semibold mb-2">Data Perwakilan</h3>
                  <div className="bg-gray-50 p-4 rounded-lg">
                    <p><strong>Nama:</strong> {representativeData.name}</p>
                    <p><strong>KTP:</strong> {representativeData.ktp_number}</p>
                    <p><strong>Telepon:</strong> {representativeData.phone}</p>
                    <p><strong>Hubungan:</strong> {representativeData.relationship}</p>
                  </div>
                </div>

                <div>
                  <h3 className="font-semibold mb-2">Daftar Peserta ({participants.length})</h3>
                  <div className="space-y-2">
                    {participants.map((p) => (
                      <div key={p.id || p.participant_id} className="bg-gray-50 p-3 rounded-lg flex items-center justify-between">
                        <div className="flex-1">
                          <p className="font-medium">{p.name}</p>
                          <p className="text-sm text-gray-600">
                            {p.registration_code} - BIB: {p.bib_number} - Jersey: {p.jersey_size}
                          </p>
                        </div>
                        <button
                          onClick={async () => {
                            try {
                              // Use selectedEventId from context (useRpcApi will handle fallback)
                              // Note: Scan results use 'participant_id', normalize if needed
                              const participantId = p.id || p.participant_id;
                              if (!participantId) {
                                throw new Error('Participant ID tidak ditemukan');
                              }
                              
                              const payload = await getPrintPayload(
                                'pickup_sheet',
                                [participantId],
                                null
                              );
                              
                              // Try to use XML template first, fallback to HTML generator
                              try {
                                const { generateHTMLFromTemplate, printDocument } = await import('../print/PrintService');
                                const htmlContent = await generateHTMLFromTemplate('pickup_sheet', payload);
                                printDocument(htmlContent);
                              } catch (templateError) {
                                console.warn('Template not available, using fallback:', templateError);
                                const { generatePickupSheetHTML, printDocument } = await import('../print/PrintService');
                                const htmlContent = generatePickupSheetHTML(
                                  payload.participants[0],
                                  payload.metadata?.event_name ? { name: payload.metadata.event_name } : null
                                );
                                printDocument(htmlContent);
                              }
                            } catch {
                              // Error is handled by useRpcApi hook
                            }
                          }}
                          className="btn-primary text-sm ml-3"
                          disabled={loading}
                          title="Print Lembar Pengambilan untuk peserta ini"
                        >
                          Print
                        </button>
                      </div>
                    ))}
                  </div>
                </div>

                <button
                  onClick={handlePrint}
                  className="btn-success w-full"
                  disabled={loading}
                >
                  {loading ? <LoadingSpinner size="sm" /> : 'Print Surat Kuasa'}
                </button>
              </div>
            </div>
          </div>
        )}

        {/* Navigation Buttons */}
        <div className="card">
          <div className="flex justify-between">
            <button
              onClick={handlePrevious}
              className="btn-secondary"
              disabled={currentStep === 1 || loading}
            >
              Previous
            </button>
            {currentStep < 3 ? (
              <button
                onClick={handleNext}
                className="btn-primary"
                disabled={loading}
              >
                Next
              </button>
            ) : (
              <button
                onClick={handleReset}
                className="btn-secondary"
                disabled={loading}
              >
                Reset
              </button>
            )}
          </div>
        </div>

        {/* Print Preview Modal */}
        {showPrintPreview && printData && (
          <PrintPreview
            printType="power_of_attorney"
            data={printData}
            onClose={() => setShowPrintPreview(false)}
          />
        )}
      </div>
    </div>
  );
};

export default Pos2Perwakilan;

