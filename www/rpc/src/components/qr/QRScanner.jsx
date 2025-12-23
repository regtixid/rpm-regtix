import { useState, useEffect, useRef } from 'react';
import { Html5Qrcode } from 'html5-qrcode';
import LoadingSpinner from '../common/LoadingSpinner';

const QRScanner = ({ onScanSuccess, manualInput = true, onError, scannerMode = 'auto' }) => {
  // #region agent log
  fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:5',message:'Component initialized',data:{scannerMode,hasOnScanSuccess:!!onScanSuccess,hasOnError:!!onError,manualInput},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'D'})}).catch(()=>{});
  // #endregion
  const [scanning, setScanning] = useState(false);
  const [manualCode, setManualCode] = useState('');
  const [cameraError, setCameraError] = useState(null);
  // Initialize activeMode: if scannerMode is 'auto', default to 'webcam' (more user-friendly)
  // If scannerMode is 'webcam' or 'hardware', use that directly
  const [activeMode, setActiveMode] = useState(
    scannerMode === 'auto' ? 'webcam' : scannerMode
  );
  // #region agent log
  fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:13',message:'Initial state set',data:{initialActiveMode:scannerMode === 'auto' ? 'hardware' : scannerMode},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'D'})}).catch(()=>{});
  // #endregion
  const html5QrCodeRef = useRef(null);
  const hardwareInputRef = useRef(null);
  const hardwareInputTimeoutRef = useRef(null);
  const lastKeyTimeRef = useRef(0);
  const hardwareBufferRef = useRef('');

  // Check if secure context (HTTPS or localhost)
  const isSecureContext = () => {
    return window.isSecureContext || 
           window.location.protocol === 'https:' || 
           window.location.hostname === 'localhost' || 
           window.location.hostname === '127.0.0.1';
  };

  // Check camera permission
  const checkCameraPermission = async () => {
    try {
      if (navigator.permissions && navigator.permissions.query) {
        const result = await navigator.permissions.query({ name: 'camera' });
        return result.state;
      }
      return 'prompt'; // Default to prompt if API not available
    } catch (err) {
      console.warn('Permission API not supported:', err);
      return 'prompt';
    }
  };

  // Cleanup scanner on unmount
  useEffect(() => {
    return () => {
      if (html5QrCodeRef.current && scanning) {
        html5QrCodeRef.current.stop().catch(() => {});
        html5QrCodeRef.current.clear().catch(() => {});
      }
      if (hardwareInputTimeoutRef.current) {
        clearTimeout(hardwareInputTimeoutRef.current);
      }
    };
  }, [scanning]);

  // Update activeMode when scannerMode prop changes
  useEffect(() => {
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:56',message:'Mode effect triggered',data:{scannerMode,scanning,currentActiveMode:activeMode},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'D'})}).catch(()=>{});
    // #endregion
    if (scannerMode === 'auto') {
      // In auto mode, default to webcam if not scanning
      if (!scanning) {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:60',message:'Setting activeMode to webcam',data:{reason:'auto mode, not scanning'},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'D'})}).catch(()=>{});
        // #endregion
        setActiveMode('webcam');
      }
    } else {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:63',message:'Setting activeMode from prop',data:{newMode:scannerMode},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'D'})}).catch(()=>{});
      // #endregion
      setActiveMode(scannerMode);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [scannerMode, scanning]);

  // Auto-focus hardware input when mode is hardware
  useEffect(() => {
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:68',message:'Focus effect triggered',data:{activeMode,scanning,hasInputRef:!!hardwareInputRef.current},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'B'})}).catch(()=>{});
    // #endregion
    if (activeMode === 'hardware' && hardwareInputRef.current && !scanning) {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:70',message:'Attempting focus',data:{documentActiveElement:document.activeElement?.tagName},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'B'})}).catch(()=>{});
      // #endregion
      hardwareInputRef.current.focus();
      // #region agent log
      setTimeout(()=>{fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:71',message:'Focus completed',data:{focusedElement:document.activeElement===hardwareInputRef.current},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'B'})}).catch(()=>{});},100);
      // #endregion
    }
  }, [activeMode, scanning]);

  const handleError = (error, userMessage) => {
    const errorMessage = error?.message || error?.toString() || userMessage;
    console.error('QR Scanner Error:', error);
    setCameraError(userMessage || errorMessage);
    if (onError) {
      onError(error || new Error(errorMessage));
    }
  };

  const startScanning = async () => {
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:107',message:'startScanning called',data:{activeMode},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB1'})}).catch(()=>{});
    // #endregion
    try {
      setCameraError(null);

      // Check secure context
      const isSecure = isSecureContext();
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:112',message:'Secure context check',data:{isSecure,protocol:window.location.protocol,hostname:window.location.hostname,isSecureContext:window.isSecureContext},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB2'})}).catch(()=>{});
      // #endregion
      if (!isSecure) {
        const errorMsg = 'Kamera memerlukan HTTPS atau localhost. Gunakan hardware scanner atau akses via HTTPS.';
        handleError(new Error('Not secure context'), errorMsg);
        return;
      }

      // Check camera permission
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:119',message:'Checking camera permission',data:{hasPermissionsAPI:!!(navigator.permissions && navigator.permissions.query)},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB3'})}).catch(()=>{});
      // #endregion
      const permissionState = await checkCameraPermission();
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:120',message:'Camera permission result',data:{permissionState},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB3'})}).catch(()=>{});
      // #endregion
      if (permissionState === 'denied') {
        const errorMsg = 'Izin kamera ditolak. Silakan aktifkan izin kamera di pengaturan browser atau gunakan hardware scanner.';
        handleError(new Error('Camera permission denied'), errorMsg);
        return;
      }

      // Check if camera is available
      const hasMediaDevices = !!(navigator.mediaDevices && navigator.mediaDevices.getUserMedia);
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:127',message:'Camera API availability check',data:{hasMediaDevices,hasNavigatorMediaDevices:!!navigator.mediaDevices,hasGetUserMedia:!!navigator.mediaDevices?.getUserMedia},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB4'})}).catch(()=>{});
      // #endregion
      if (!hasMediaDevices) {
        const errorMsg = 'Browser tidak mendukung akses kamera. Gunakan hardware scanner atau browser yang lebih baru.';
        handleError(new Error('Camera API not available'), errorMsg);
        return;
      }

      // Set scanning state and activeMode BEFORE starting camera to ensure element is visible
      setScanning(true);
      setActiveMode('webcam');
      
      // Small delay to ensure React has rendered the visible element
      await new Promise(resolve => setTimeout(resolve, 50));

      // Ensure qr-reader element exists and is visible before creating Html5Qrcode instance
      let qrReaderElement = document.getElementById('qr-reader');
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:150',message:'Checking for qr-reader element',data:{hasQrReaderElement:!!qrReaderElement,qrReaderElementId:qrReaderElement?.id,elementClassName:qrReaderElement?.className},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB5'})}).catch(()=>{});
      // #endregion
      if (!qrReaderElement) {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:155',message:'qr-reader element not found, creating it',data:{},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB5'})}).catch(()=>{});
        // #endregion
        // Create element if it doesn't exist (shouldn't happen with our fix, but safety check)
        qrReaderElement = document.createElement('div');
        qrReaderElement.id = 'qr-reader';
        qrReaderElement.className = 'w-full max-w-md mx-auto min-h-[300px]';
        qrReaderElement.style.minHeight = '300px';
        document.body.appendChild(qrReaderElement);
      } else {
        // Make sure element is visible (remove 'hidden' class if present)
        qrReaderElement.className = 'w-full max-w-md mx-auto min-h-[300px]';
        qrReaderElement.style.minHeight = '300px';
        qrReaderElement.style.display = '';
      }
      
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:164',message:'Element visibility set',data:{elementClassName:qrReaderElement.className,isVisible:!qrReaderElement.className.includes('hidden')},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB5'})}).catch(()=>{});
      // #endregion
      
      const html5QrCode = new Html5Qrcode('qr-reader');
      html5QrCodeRef.current = html5QrCode;
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:168',message:'Html5Qrcode instance created',data:{hasQrReaderElement:!!document.getElementById('qr-reader')},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB5'})}).catch(()=>{});
      // #endregion

      // Try back camera first, then front camera
      let cameraStarted = false;
      const cameraConfigs = [
        { facingMode: 'environment' }, // Back camera
        { facingMode: 'user' }, // Front camera
      ];

      for (let i = 0; i < cameraConfigs.length; i++) {
        const config = cameraConfigs[i];
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:165',message:'Attempting camera start',data:{configIndex:i,config},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB6'})}).catch(()=>{});
        // #endregion
        try {
          // Improved configuration for better QR detection
          // Try with larger fixed size first for better detection
          await html5QrCode.start(
            config,
            {
              fps: 30, // Increased FPS for better detection (was 10)
              qrbox: { width: 400, height: 400 }, // Larger fixed size for better detection
              aspectRatio: 1.0, // Square aspect ratio
              disableFlip: false // Allow flipping
            },
            (decodedText) => {
              // #region agent log
              fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:226',message:'QR code detected - SUCCESS',data:{decodedText,codeLength:decodedText?.length,timestamp:new Date().toISOString()},timestamp:Date.now(),sessionId:'debug-session',runId:'qr-detection-debug',hypothesisId:'QR2'})}).catch(()=>{});
              // #endregion
              console.log('QR Code detected:', decodedText);
              handleScanSuccess(decodedText);
            },
            (errorMessage) => {
              // Log first few errors to understand what's happening
              // #region agent log
              fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:232',message:'QR scan error',data:{errorMessage,errorType:typeof errorMessage},timestamp:Date.now(),sessionId:'debug-session',runId:'qr-detection-debug',hypothesisId:'QR3'})}).catch(()=>{});
              // #endregion
              // Ignore scanning errors (they're frequent during scanning, but log for debugging)
            }
          );
          // #region agent log
          fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:218',message:'Camera started successfully',data:{configIndex:i,config,fps:30,qrboxSize:'400x400'},timestamp:Date.now(),sessionId:'debug-session',runId:'qr-detection-debug',hypothesisId:'QR4'})}).catch(()=>{});
          // #endregion
          cameraStarted = true;
          // #region agent log
          fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:221',message:'QR scanner ready - waiting for QR code',data:{elementVisible:!!document.getElementById('qr-reader'),elementClassName:document.getElementById('qr-reader')?.className},timestamp:Date.now(),sessionId:'debug-session',runId:'qr-detection-debug',hypothesisId:'QR4'})}).catch(()=>{});
          // #endregion
          break;
        } catch (err) {
          // #region agent log
          fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:191',message:'Camera start failed',data:{configIndex:i,config,error:err?.message,errorName:err?.name,errorStack:err?.stack},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB6'})}).catch(()=>{});
          // #endregion
          console.warn(`Failed to start camera with config ${JSON.stringify(config)}:`, err);
          // Try next config
        }
      }

      if (!cameraStarted) {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:197',message:'Trying device list fallback',data:{},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB9'})}).catch(()=>{});
        // #endregion
        // Try to get device list and use first available camera
        try {
          const devices = await Html5Qrcode.getCameras();
          // #region agent log
          fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:199',message:'Camera devices retrieved',data:{deviceCount:devices?.length,devices:devices?.map(d=>({id:d.id,label:d.label}))},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB9'})}).catch(()=>{});
          // #endregion
          if (devices && devices.length > 0) {
            // #region agent log
            fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:201',message:'Starting camera with device ID',data:{deviceId:devices[0].id,deviceLabel:devices[0].label},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB9'})}).catch(()=>{});
            // #endregion
            await html5QrCode.start(
              devices[0].id,
              {
                fps: 30, // Increased FPS for better detection
                qrbox: { width: 400, height: 400 }, // Larger fixed size for better detection
                aspectRatio: 1.0,
                disableFlip: false
              },
              (decodedText) => {
                // #region agent log
                fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:263',message:'QR code detected (device fallback)',data:{decodedText,codeLength:decodedText?.length},timestamp:Date.now(),sessionId:'debug-session',runId:'qr-detection-debug',hypothesisId:'QR2'})}).catch(()=>{});
                // #endregion
                handleScanSuccess(decodedText);
              },
              (errorMessage) => {
                // Log errors but don't spam
                if (Math.random() < 0.01) {
                  // #region agent log
                  fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:270',message:'QR scan error sample (device fallback)',data:{errorMessage},timestamp:Date.now(),sessionId:'debug-session',runId:'qr-detection-debug',hypothesisId:'QR3'})}).catch(()=>{});
                  // #endregion
                }
              }
            );
            // #region agent log
            fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:212',message:'Camera started with device fallback',data:{deviceId:devices[0].id},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB9'})}).catch(()=>{});
            // #endregion
            cameraStarted = true;
          }
        } catch (deviceErr) {
          // #region agent log
          fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:215',message:'Device list fallback failed',data:{error:deviceErr?.message,errorName:deviceErr?.name},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB9'})}).catch(()=>{});
          // #endregion
          console.warn('Failed to get camera devices:', deviceErr);
        }
      }

      if (!cameraStarted) {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:218',message:'All camera start attempts failed',data:{},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB10'})}).catch(()=>{});
        // #endregion
        throw new Error('Tidak dapat mengakses kamera. Pastikan kamera tersedia dan izin sudah diberikan.');
      }

      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:241',message:'Camera started successfully, states already set',data:{cameraStarted,scanning,activeMode},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB11'})}).catch(()=>{});
      // #endregion
      // States (scanning and activeMode) were already set before camera start
      // Element visibility was already set before camera start
    } catch (error) {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:254',message:'startScanning error caught',data:{error:error?.message,errorName:error?.name,errorStack:error?.stack},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB12'})}).catch(()=>{});
      // #endregion
      const errorMessage = error?.message || 'Tidak dapat mengakses kamera. Pastikan izin kamera sudah diberikan.';
      handleError(error, errorMessage);
      
      // Hide qr-reader element on error
      const qrReaderElement = document.getElementById('qr-reader');
      if (qrReaderElement) {
        qrReaderElement.className = 'hidden';
      }
      
      setScanning(false);
      
      // If webcam fails and mode is auto, keep webcam mode (user can switch to hardware)
      if (scannerMode !== 'auto') {
        setActiveMode(scannerMode);
      }
    }
  };

  const stopScanning = async () => {
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:243',message:'stopScanning called',data:{hasScannerRef:!!html5QrCodeRef.current,scanning},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB13'})}).catch(()=>{});
    // #endregion
    if (html5QrCodeRef.current) {
      try {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:246',message:'Stopping scanner',data:{},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB13'})}).catch(()=>{});
        // #endregion
        await html5QrCodeRef.current.stop();
        await html5QrCodeRef.current.clear();
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:249',message:'Scanner stopped successfully',data:{},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB13'})}).catch(()=>{});
        // #endregion
      } catch (err) {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:252',message:'Error stopping scanner',data:{error:err?.message,errorName:err?.name},timestamp:Date.now(),sessionId:'debug-session',runId:'webcam-debug',hypothesisId:'WEB13'})}).catch(()=>{});
        // #endregion
        console.warn('Error stopping scanner:', err);
      }
      html5QrCodeRef.current = null;
    }
    // Hide qr-reader element
    const qrReaderElement = document.getElementById('qr-reader');
    if (qrReaderElement) {
      qrReaderElement.className = 'hidden';
    }
    setScanning(false);
  };

  const handleScanSuccess = (code) => {
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:196',message:'handleScanSuccess called',data:{code,codeLength:code?.length,hasOnScanSuccess:!!onScanSuccess,bufferBeforeReset:hardwareBufferRef.current},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'C'})}).catch(()=>{});
    // #endregion
    stopScanning();
    if (onScanSuccess) {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:199',message:'Calling onScanSuccess callback',data:{code},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'C'})}).catch(()=>{});
      // #endregion
      try {
        onScanSuccess(code);
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:202',message:'onScanSuccess completed successfully',data:{},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'C'})}).catch(()=>{});
        // #endregion
      } catch (err) {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:205',message:'onScanSuccess threw error',data:{error:err?.message,errorStack:err?.stack},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'C'})}).catch(()=>{});
        // #endregion
      }
    }
    // Reset hardware buffer
    hardwareBufferRef.current = '';
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:210',message:'Buffer reset',data:{bufferAfterReset:hardwareBufferRef.current},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'E'})}).catch(()=>{});
    // #endregion
  };

  const handleManualSubmit = (e) => {
    e.preventDefault();
    if (manualCode.trim()) {
      handleScanSuccess(manualCode.trim());
      setManualCode('');
    }
  };

  // Handle hardware scanner input
  const handleHardwareInput = (e) => {
    const value = e.target.value;
    const now = Date.now();
    const timeSinceLastKey = lastKeyTimeRef.current > 0 ? now - lastKeyTimeRef.current : 0;
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:256',message:'handleHardwareInput called',data:{value,valueLength:value.length,timeSinceLastKey,previousBuffer:hardwareBufferRef.current},timestamp:Date.now(),sessionId:'debug-session',runId:'post-fix',hypothesisId:'A'})}).catch(()=>{});
    // #endregion

    // Update buffer with current value
    hardwareBufferRef.current = value;
    lastKeyTimeRef.current = now;

    // Clear existing timeout
    if (hardwareInputTimeoutRef.current) {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:267',message:'Clearing existing timeout',data:{},timestamp:Date.now(),sessionId:'debug-session',runId:'post-fix',hypothesisId:'A'})}).catch(()=>{});
      // #endregion
      clearTimeout(hardwareInputTimeoutRef.current);
    }

    // Auto-submit after delay
    // Hardware scanners typically send characters quickly (< 50ms between chars)
    // Use shorter delay if input is fast (likely scanner), longer if slow (manual typing)
    // For fast input (< 150ms between chars), use 100ms delay
    // For slow input (manual typing), use 300ms delay to avoid false positives
    const isFastInput = timeSinceLastKey > 0 && timeSinceLastKey < 150;
    const delay = isFastInput ? 100 : 300;
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:275',message:'Setting timeout for auto-submit',data:{delay,timeSinceLastKey,isFastInput,currentValueLength:value.length},timestamp:Date.now(),sessionId:'debug-session',runId:'post-fix',hypothesisId:'A'})}).catch(()=>{});
    // #endregion
    hardwareInputTimeoutRef.current = setTimeout(() => {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:276',message:'Timeout callback executed',data:{bufferValue:hardwareBufferRef.current,bufferTrimmed:hardwareBufferRef.current.trim(),bufferLength:hardwareBufferRef.current.trim().length},timestamp:Date.now(),sessionId:'debug-session',runId:'post-fix',hypothesisId:'A'})}).catch(()=>{});
      // #endregion
      const trimmedValue = hardwareBufferRef.current.trim();
      // Only auto-submit if buffer has minimum length (2+ chars) to avoid false positives from single keystrokes
      // Hardware scanners typically send codes with at least 2 characters
      if (trimmedValue && trimmedValue.length >= 2) {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:279',message:'Calling handleScanSuccess from timeout',data:{code:trimmedValue,meetsMinLength:true},timestamp:Date.now(),sessionId:'debug-session',runId:'post-fix',hypothesisId:'A'})}).catch(()=>{});
        // #endregion
        handleScanSuccess(trimmedValue);
        hardwareBufferRef.current = '';
        if (hardwareInputRef.current) {
          hardwareInputRef.current.value = '';
        }
      } else {
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:287',message:'Timeout skipped - buffer too short or empty',data:{bufferValue:hardwareBufferRef.current,bufferLength:trimmedValue?.length || 0,minLength:2},timestamp:Date.now(),sessionId:'debug-session',runId:'post-fix',hypothesisId:'A'})}).catch(()=>{});
        // #endregion
      }
    }, delay);
  };

  const handleHardwareKeyDown = (e) => {
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:293',message:'handleHardwareKeyDown called',data:{key:e.key,bufferValue:hardwareBufferRef.current,bufferTrimmed:hardwareBufferRef.current.trim()},timestamp:Date.now(),sessionId:'debug-session',runId:'post-fix',hypothesisId:'A'})}).catch(()=>{});
    // #endregion
    // Submit on Enter key (Enter key always submits, regardless of length)
    if (e.key === 'Enter' && hardwareBufferRef.current.trim()) {
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/04535daa-5ccc-4727-873b-41e0e48716d4',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'QRScanner.jsx:296',message:'Enter key detected, submitting',data:{code:hardwareBufferRef.current.trim()},timestamp:Date.now(),sessionId:'debug-session',runId:'post-fix',hypothesisId:'A'})}).catch(()=>{});
      // #endregion
      e.preventDefault();
      // Clear timeout since we're submitting manually
      if (hardwareInputTimeoutRef.current) {
        clearTimeout(hardwareInputTimeoutRef.current);
        hardwareInputTimeoutRef.current = null;
      }
      handleScanSuccess(hardwareBufferRef.current.trim());
      hardwareBufferRef.current = '';
      e.target.value = '';
    }
  };

  // Handle mode switching between webcam and hardware scanner
  const handleModeSwitch = (newMode) => {
    // Prevent switching to unavailable modes
    if (newMode === 'webcam' && scannerMode === 'hardware') return;
    if (newMode === 'hardware' && scannerMode === 'webcam') return;
    
    // If switching from webcam to hardware, stop webcam scanning
    if (activeMode === 'webcam' && scanning) {
      stopScanning();
    }
    // Reset hardware buffer when switching to webcam
    if (newMode === 'webcam') {
      hardwareBufferRef.current = '';
      if (hardwareInputTimeoutRef.current) {
        clearTimeout(hardwareInputTimeoutRef.current);
        hardwareInputTimeoutRef.current = null;
      }
      if (hardwareInputRef.current) {
        hardwareInputRef.current.value = '';
      }
    }
    setActiveMode(newMode);
  };


  // Determine which modes to show
  const showWebcam = scannerMode === 'webcam' || scannerMode === 'auto';
  const showHardware = scannerMode === 'hardware' || scannerMode === 'auto';
  const showTabs = showWebcam && showHardware; // Only show tabs if both modes are available

  return (
    <div className="space-y-4">
      {/* Combined Scanner Card with Tabs */}
      {(showWebcam || showHardware) && (
        <div className="card">
          {/* Tab Navigation */}
          {showTabs && (
            <div className="flex border-b border-gray-200 mb-4">
              <button
                onClick={() => handleModeSwitch('webcam')}
                className={`flex-1 px-4 py-2 text-sm font-medium transition-colors ${
                  activeMode === 'webcam'
                    ? 'bg-blue-500 text-white border-b-2 border-blue-500'
                    : 'text-gray-600 hover:text-gray-900 hover:bg-gray-50'
                }`}
              >
                Webcam
              </button>
              <button
                onClick={() => handleModeSwitch('hardware')}
                className={`flex-1 px-4 py-2 text-sm font-medium transition-colors ${
                  activeMode === 'hardware'
                    ? 'bg-blue-500 text-white border-b-2 border-blue-500'
                    : 'text-gray-600 hover:text-gray-900 hover:bg-gray-50'
                }`}
              >
                Hardware Scanner
              </button>
            </div>
          )}

          {/* Webcam Content */}
          {activeMode === 'webcam' && showWebcam && (
            <div>
              <div className="flex items-center justify-between mb-2">
                <h3 className="text-lg font-semibold">Scan QR Code (Webcam)</h3>
                {scanning && (
                  <span className="text-xs px-2 py-1 bg-blue-100 text-blue-800 rounded">
                    Aktif
                  </span>
                )}
              </div>
              {!scanning ? (
                <button onClick={startScanning} className="btn-primary mb-4">
                  Mulai Scan Webcam
                </button>
              ) : (
                <div className="space-y-2 mb-4">
                  <button onClick={stopScanning} className="btn-secondary">
                    Stop Scan
                  </button>
                </div>
              )}
              {/* Always render qr-reader element (hidden when not scanning) for Html5Qrcode initialization */}
              <div 
                id="qr-reader" 
                className={scanning ? 'w-full max-w-md mx-auto min-h-[300px]' : 'hidden'}
                style={scanning ? { minHeight: '300px' } : {}}
              ></div>
              {cameraError && (
                <div className="mt-4 bg-yellow-50 border border-yellow-200 text-yellow-800 px-4 py-2 rounded-lg text-sm">
                  {cameraError}
                </div>
              )}
            </div>
          )}

          {/* Hardware Scanner Content */}
          {activeMode === 'hardware' && showHardware && (
            <div>
              <div className="flex items-center justify-between mb-2">
                <h3 className="text-lg font-semibold">Hardware Scanner</h3>
                {!scanning && (
                  <span className="text-xs px-2 py-1 bg-green-100 text-green-800 rounded">
                    Siap
                  </span>
                )}
              </div>
              <p className="text-sm text-gray-600 mb-2">
                Hubungkan hardware scanner dan scan QR code di sini
              </p>
              <input
                ref={hardwareInputRef}
                type="text"
                onChange={handleHardwareInput}
                onKeyDown={handleHardwareKeyDown}
                placeholder="Scan QR code dengan hardware scanner..."
                className="input-field w-full"
                autoFocus={!scanning}
                disabled={scanning}
              />
            </div>
          )}
        </div>
      )}

      {/* Manual Input */}
      {manualInput && (
        <div className="card">
          <h3 className="text-lg font-semibold mb-2">Atau Input Manual</h3>
          <form onSubmit={handleManualSubmit} className="flex gap-2">
            <input
              type="text"
              value={manualCode}
              onChange={(e) => setManualCode(e.target.value)}
              placeholder="Masukkan kode tiket"
              className="input-field flex-1"
              disabled={scanning}
            />
            <button type="submit" className="btn-primary" disabled={scanning || !manualCode.trim()}>
              Cari
            </button>
          </form>
        </div>
      )}
    </div>
  );
};

export default QRScanner;
