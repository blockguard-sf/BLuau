import { defineConfig } from 'vitepress'
import {
    groupIconMdPlugin,
    groupIconVitePlugin,
    localIconLoader
} from 'vitepress-plugin-group-icons'
import { search as frSearch } from './fr'

//C:/RobloxProjects/BlockGuard Software Foundation/BLuau/BLuau/docs/.vitepress/dist/
const basePath = 'https://blockguard-sf.github.io/BLuau/'

export const shared = defineConfig({
    title: 'BLuau',
    base: '/BLuau/',
    rewrites: {
        'en/:rest*': ':rest*'
    },

    lastUpdated: true,
    cleanUrls: true,
    metaChunk: true,

    markdown: {
        math: true,
        codeTransformers: [
            // We use [`!!code` in demo to prevent transformation, here we revert it back. 
            {
                postprocess(code) {
                    return code.replace(/\[\!\!code/g, '[!code')
                }
            }
        ],
        config(md) {
            // TODO: remove when https://github.com/vuejs/vitepress/issues/4431 is fixed
            const fence = md.renderer.rules.fence!
            md.renderer.rules.fence = function (token, idx, options, env, self) {
                const { localeIndex = 'root' } = env
                const codeCopyButtonTitle = (() => {
                    switch (localeIndex) {
                        case 'fr':
                            return 'Copier le code'
                        default:
                            return 'Copy code'
                    }
                })()
                return fence(token, idx, options, env, self).replace(
                    '<button title="Copy Code" class="copy"></button>',
                    `<button title="${codeCopyButtonTitle}" class="copy"></button>`
                )
            }
            md.use(groupIconMdPlugin)
        }
    },

    sitemap: {
        hostname: 'https://blockguard-sf.github.io/BLuau/',
        transformItems(items) {
            return items.filter((item) => !item.url.includes('migration'))
        }
    },

    themeConfig: {
        logo: { src: `${basePath}blockguard-logo-mini.png`, width: 24, height: 24 },

        socialLinks: [
            { icon: 'github', link: 'https://github.com/blockguard-sf/bluau' }
        ],

        search: {
            provider: 'algolia',
            options: {
                appId: 'JASV1T571E',
                apiKey: '3529d3f8b831d0c73f39074727ad80cf',
                indexName: 'bluau',
                locales: {
                    ...frSearch
                }
            }
        }
    },
    vite: {
      plugins: [
        groupIconVitePlugin({
          customIcon: {
            vitepress: 'blockguard-logo-mini.png)',
            firebase: 'logos:firebase'
          }
        })
      ]
    }
})