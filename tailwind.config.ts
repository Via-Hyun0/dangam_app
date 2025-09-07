import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './index.html',
    './src/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#2d5a27', // A nice, dark green
          foreground: '#ffffff',
        },
      },
    },
  },
  plugins: [],
}
export default config
