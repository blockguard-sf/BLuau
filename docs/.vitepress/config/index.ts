import { defineConfig } from 'vitepress'
import { shared } from './shared'
import { en } from '../config/en'
import { fr } from '../config/fr'

export default defineConfig({
    ...shared,
    locales: {
        root: { label: 'English', ...en },
        fr: { label: 'Français', ...fr }
    }
})