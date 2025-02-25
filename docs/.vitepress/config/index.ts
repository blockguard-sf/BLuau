import { defineConfig } from 'vitepress'
import { shared } from './shared'
import { en } from './en'
import { fr } from './fr'

export default defineConfig({
    ...shared,
    locales: {
        root: { label: 'English', ...en },
        fr: { label: 'Français', ...fr }
    }
})