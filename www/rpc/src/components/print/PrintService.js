/**
 * Print service for handling print operations
 */

import { parseTemplate, formatDate } from '../../utils/templateParser';

/**
 * Load template XML and generate HTML for printing
 */
export const loadTemplate = async (templateType) => {
  const templatePath = `/Templates/${templateType}_default.xml`;
  return templatePath;
};

/**
 * Generate HTML from template XML with data
 */
export const generateHTMLFromTemplate = async (templateType, data) => {
  const templatePath = await loadTemplate(templateType);
  
  // Prepare data dengan format yang sesuai untuk template
  const templateData = prepareTemplateData(templateType, data);
  
  // Parse template
  const html = await parseTemplate(templatePath, templateData);
  
  return html;
};

/**
 * Prepare data untuk template sesuai dengan struktur yang diharapkan
 */
const prepareTemplateData = (templateType, data) => {
  if (templateType === 'pickup_sheet') {
    const participant = data.participants?.[0] || {};
    return {
      participant: {
        name: participant.name || '',
        ktp_number: participant.ktp_number || '',
        dob: formatDate(participant.dob),
        gender: participant.gender || '',
        address: participant.address || '',
        phone: participant.phone || '',
        emergency_contact_name: participant.emergency_contact_name || '',
        emergency_contact_phone: participant.emergency_contact_phone || '',
        registration_code: participant.registration_code || '',
        ticket_category: participant.ticket_category || '',
        ticket_type: participant.ticket_type || '',
        jersey_size: participant.jersey_size || '',
        bib_number: participant.bib_number || '',
      },
      metadata: {
        event_name: data.metadata?.event_name || '',
        operator_name: data.metadata?.operator_name || '',
        generated_at: data.metadata?.generated_at ? formatDate(data.metadata.generated_at) : formatDate(new Date().toISOString()),
      },
    };
  } else if (templateType === 'power_of_attorney') {
    return {
      representative: {
        name: data.representative?.name || '',
        ktp_number: data.representative?.ktp_number || '',
        address: data.representative?.address || '',
        phone: data.representative?.phone || '',
        relationship: data.representative?.relationship || '',
      },
      participants: data.participants || [],
      metadata: {
        event_name: data.metadata?.event_name || '',
        operator_name: data.metadata?.operator_name || '',
        generated_at: data.metadata?.generated_at ? formatDate(data.metadata.generated_at) : formatDate(new Date().toISOString()),
      },
    };
  }
  
  return data;
};

/**
 * Print document using template
 */
export const printDocument = (content) => {
  const printWindow = window.open('', '_blank');
  printWindow.document.write(`
    <!DOCTYPE html>
    <html>
      <head>
        <title>Print</title>
        <style>
          @media print {
            @page {
              margin: 1cm;
            }
            body {
              font-family: Arial, sans-serif;
            }
            .no-print {
              display: none;
            }
          }
          body {
            font-family: Arial, sans-serif;
            padding: 20px;
          }
        </style>
      </head>
      <body>
        ${content}
      </body>
    </html>
  `);
  printWindow.document.close();
  printWindow.focus();
  
  // Wait for content to load, then print
  setTimeout(() => {
    printWindow.print();
  }, 250);
};

/**
 * Generate pickup sheet HTML (fallback jika template tidak tersedia)
 */
export const generatePickupSheetHTML = (participant, event) => {
  return `
    <div class="print-avoid-break">
      <h2 style="text-align: center; margin-bottom: 20px;">LEMBAR PENGAMBILAN RACE PACK</h2>
      
      <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
        <tr>
          <td style="padding: 8px; border: 1px solid #ddd; width: 30%;"><strong>Nama Peserta</strong></td>
          <td style="padding: 8px; border: 1px solid #ddd;">${participant.name || '-'}</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ddd;"><strong>Registration Code</strong></td>
          <td style="padding: 8px; border: 1px solid #ddd;">${participant.registration_code || '-'}</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ddd;"><strong>BIB Number</strong></td>
          <td style="padding: 8px; border: 1px solid #ddd; font-size: 18px; font-weight: bold;">${participant.bib_number || '-'}</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ddd;"><strong>Kategori</strong></td>
          <td style="padding: 8px; border: 1px solid #ddd;">${participant.ticket_category || '-'}</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ddd;"><strong>Jenis Tiket</strong></td>
          <td style="padding: 8px; border: 1px solid #ddd;">${participant.ticket_type || '-'}</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ddd;"><strong>Ukuran Jersey</strong></td>
          <td style="padding: 8px; border: 1px solid #ddd; font-weight: bold;">${participant.jersey_size || '-'}</td>
        </tr>
        ${event ? `
        <tr>
          <td style="padding: 8px; border: 1px solid #ddd;"><strong>Event</strong></td>
          <td style="padding: 8px; border: 1px solid #ddd;">${event.name || '-'}</td>
        </tr>
        ` : ''}
      </table>
      
      <div style="margin-top: 30px; padding-top: 20px; border-top: 2px solid #000;">
        <p><strong>Catatan:</strong> Harap periksa kelengkapan paket sebelum meninggalkan lokasi.</p>
        <p style="margin-top: 40px;">Tanda Tangan Peserta: _________________________</p>
      </div>
    </div>
  `;
};

/**
 * Generate power of attorney HTML (fallback jika template tidak tersedia)
 */
export const generatePowerOfAttorneyHTML = (representative, participants, event) => {
  const participantsList = participants.map((p, idx) => `
    <tr>
      <td style="padding: 8px; border: 1px solid #ddd; text-align: center;">${idx + 1}</td>
      <td style="padding: 8px; border: 1px solid #ddd;">${p.name || '-'}</td>
      <td style="padding: 8px; border: 1px solid #ddd;">${p.registration_code || '-'}</td>
      <td style="padding: 8px; border: 1px solid #ddd;">${p.bib_number || '-'}</td>
      <td style="padding: 8px; border: 1px solid #ddd;">${p.jersey_size || '-'}</td>
    </tr>
  `).join('');

  return `
    <div class="print-avoid-break">
      <h2 style="text-align: center; margin-bottom: 30px;">SURAT KUASA</h2>
      
      <div style="margin-bottom: 20px;">
        <p>Saya yang bertanda tangan di bawah ini:</p>
        <table style="width: 100%; border-collapse: collapse; margin: 10px 0;">
          <tr>
            <td style="padding: 8px; width: 30%;"><strong>Nama</strong></td>
            <td style="padding: 8px;">: ${representative.name || '-'}</td>
          </tr>
          <tr>
            <td style="padding: 8px;"><strong>No. KTP</strong></td>
            <td style="padding: 8px;">: ${representative.ktp_number || '-'}</td>
          </tr>
          <tr>
            <td style="padding: 8px;"><strong>Tanggal Lahir</strong></td>
            <td style="padding: 8px;">: ${representative.dob || '-'}</td>
          </tr>
          <tr>
            <td style="padding: 8px;"><strong>Alamat</strong></td>
            <td style="padding: 8px;">: ${representative.address || '-'}</td>
          </tr>
          <tr>
            <td style="padding: 8px;"><strong>No. Telepon</strong></td>
            <td style="padding: 8px;">: ${representative.phone || '-'}</td>
          </tr>
          <tr>
            <td style="padding: 8px;"><strong>Hubungan</strong></td>
            <td style="padding: 8px;">: ${representative.relationship || '-'}</td>
          </tr>
        </table>
      </div>
      
      <p style="margin: 20px 0;">Dengan ini memberikan kuasa kepada:</p>
      
      <div style="margin: 20px 0;">
        <p><strong>${representative.name || '-'}</strong></p>
        <p>Untuk mengambil Race Pack atas nama peserta berikut:</p>
      </div>
      
      <table style="width: 100%; border-collapse: collapse; margin: 20px 0;">
        <thead>
          <tr style="background-color: #f3f4f6;">
            <th style="padding: 8px; border: 1px solid #ddd; text-align: center;">No</th>
            <th style="padding: 8px; border: 1px solid #ddd;">Nama Peserta</th>
            <th style="padding: 8px; border: 1px solid #ddd;">Registration Code</th>
            <th style="padding: 8px; border: 1px solid #ddd;">BIB</th>
            <th style="padding: 8px; border: 1px solid #ddd;">Jersey Size</th>
          </tr>
        </thead>
        <tbody>
          ${participantsList}
        </tbody>
      </table>
      
      ${event ? `<p style="margin: 20px 0;"><strong>Event:</strong> ${event.name || '-'}</p>` : ''}
      
      <div style="margin-top: 40px;">
        <p>Demikian surat kuasa ini dibuat dengan sebenarnya untuk dipergunakan sebagaimana mestinya.</p>
        <p style="margin-top: 60px; text-align: right;">
          ${new Date().toLocaleDateString('id-ID', { year: 'numeric', month: 'long', day: 'numeric' })}
        </p>
        <p style="margin-top: 80px; text-align: right;">
          Yang Memberi Kuasa,<br/><br/><br/>
          _________________________<br/>
          (Tanda Tangan di atas kertas)
        </p>
      </div>
    </div>
  `;
};
