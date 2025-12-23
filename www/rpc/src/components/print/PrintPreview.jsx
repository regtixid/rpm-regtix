import { useState, useEffect } from 'react';
import { generateHTMLFromTemplate, generatePickupSheetHTML, generatePowerOfAttorneyHTML, printDocument } from './PrintService';
import LoadingSpinner from '../common/LoadingSpinner';

const PrintPreview = ({ printType, data, onClose }) => {
  const [htmlContent, setHtmlContent] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadTemplate = async () => {
      try {
        // Try to use XML template first
        const content = await generateHTMLFromTemplate(printType, data);
        setHtmlContent(content);
      } catch (error) {
        // Fallback to simple HTML generator
        console.warn('Template not available, using fallback:', error);
        let content = '';
        if (printType === 'pickup_sheet') {
          content = generatePickupSheetHTML(
            data.participants[0],
            data.metadata?.event_name ? { name: data.metadata.event_name } : null
          );
        } else if (printType === 'power_of_attorney') {
          content = generatePowerOfAttorneyHTML(
            data.representative,
            data.participants,
            data.metadata?.event_name ? { name: data.metadata.event_name } : null
          );
        }
        setHtmlContent(content);
      } finally {
        setLoading(false);
      }
    };

    loadTemplate();
  }, [printType, data]);

  const handlePrint = () => {
    printDocument(htmlContent);
  };

  if (loading) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
        <div className="bg-white rounded-lg shadow-xl p-8">
          <LoadingSpinner />
          <p className="mt-4 text-center text-gray-600">Memuat template...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg shadow-xl max-w-4xl w-full max-h-[90vh] overflow-y-auto">
        <div className="p-6">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-2xl font-bold">Print Preview</h2>
            <div className="flex gap-2">
              <button onClick={handlePrint} className="btn-primary">
                Print
              </button>
              <button onClick={onClose} className="btn-secondary">
                Tutup
              </button>
            </div>
          </div>

          <div className="border border-gray-300 p-6 bg-white">
            <div dangerouslySetInnerHTML={{ __html: htmlContent }} />
          </div>
        </div>
      </div>
    </div>
  );
};

export default PrintPreview;

