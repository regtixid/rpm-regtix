/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        success: '#28a745',
        error: '#dc3545',
        warning: '#ffc107',
        info: '#17a2b8',
        background: '#f8f9fa',
        card: '#ffffff',
        border: '#dee2e6',
      },
    },
  },
  plugins: [],
}





















