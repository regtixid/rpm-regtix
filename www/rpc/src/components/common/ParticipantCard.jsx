import { getStatusBadgeClass } from '../../utils/helpers';

const ParticipantCard = ({ participant }) => {
  if (!participant) {
    return (
      <div className="card text-center text-gray-500 py-8">
        <p>Belum ada data peserta</p>
      </div>
    );
  }

  return (
    <div className="card">
      <div className="flex justify-between items-start mb-4">
        <h3 className="text-xl font-bold text-gray-900">{participant.name}</h3>
        <span className={`status-badge ${getStatusBadgeClass(participant.status)}`}>
          {participant.status === 'VALIDATED' ? '✓ Validated' : '○ Not Validated'}
        </span>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label className="text-sm font-medium text-gray-500">Registration Code</label>
          <p className="text-gray-900 font-mono">{participant.registration_code || '-'}</p>
        </div>

        <div>
          <label className="text-sm font-medium text-gray-500">BIB Number</label>
          <p className="text-gray-900 font-mono text-lg font-bold">{participant.bib_number || '-'}</p>
        </div>

        <div>
          <label className="text-sm font-medium text-gray-500">Kategori</label>
          <p className="text-gray-900">{participant.ticket_category || '-'}</p>
        </div>

        <div>
          <label className="text-sm font-medium text-gray-500">Jenis Tiket</label>
          <p className="text-gray-900">{participant.ticket_type || '-'}</p>
        </div>

        <div>
          <label className="text-sm font-medium text-gray-500">Ukuran Jersey</label>
          <p className="text-gray-900 font-semibold">{participant.jersey_size || '-'}</p>
        </div>

        {participant.event && (
          <div>
            <label className="text-sm font-medium text-gray-500">Event</label>
            <p className="text-gray-900">{participant.event.name || '-'}</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default ParticipantCard;





















