import { defineConfig } from 'vite';
import FullReload from 'vite-plugin-full-reload';

export default defineConfig({
  base: '/intro-wordpress/',
  plugins: [
    FullReload(['**/*.md', 'index.html'])
  ],
  server: {
    watch: {
      usePolling: true,
      interval: 100 // Check for changes every 100ms
    }
  }
});