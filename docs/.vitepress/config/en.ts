import { defineConfig } from 'vitepress'

export const en = defineConfig({
    lang: 'en-US',
    description: 'An Open Source Library For Roblox.',

    themeConfig: {
        nav: nav(),

        sidebar: {
            '/whatsnew/': { base: '/whatsnew/', items: sidebarWhatsNew() },
            '/api-reference/': { base: '/api-reference/', items: sidebarAPIReference() }
        },

        editLink: {
            pattern: 'https://github.com/blockguard-sf/bluau/edit/master/docs/:path',
            text: 'Edit this page on GitHub'
        },

        footer: {
            message: 'Released under the Apache-2.0 License.',
            copyright: 'Copyright © 2025 BlockGuard SF. All rights reserved.'
        }
    },
})

function nav() {
    return [
        {
            text: 'What\'s New?',
            link: '/whatsnew/index.html',
            activeMarch: '/whatsnew/'
        },
        {
            text: 'API Reference',
            link: '/api-reference/index.html',
            activeMarch: '/api-reference/'
        },
        {
            text: 'v1.0',
            items: [
                {
                    text: 'Changelog',
                    link: 'https://github.com/blockguard-sf/BLuau/blob/master/CHANGELOG/1.0.md'
                },
                {
                    text: 'Contributing',
                    link: '#'
                }
            ]
        }
    ]
}

function sidebarWhatsNew() {
    return [
        {
            text: 'Docs By Versions',
            collapsed: false,
            items: [
                { text: 'BLuau 1.1 (in development)', link: '1.1.html' },
                { text: 'BLuau 1.0 (stable)', link: '1.0.html' }
            ]
        }
    ]
} 

function sidebarAPIReference() {
    return [
        {
            text: 'API Reference',
            collapsed: false,
            items: [
                { 
                    text: '1. Data Persistence', 
                    link: 'data-persistence/index.html',
                    items: [
                        { text: '1.1. rbxdss', link: 'data-persistence/rbxdss.html' },
                        { text: '1.2. authz', link: 'data-persistence/authz.html' },
                    ]
                },
                { 
                    text: '2. Data Persistence', 
                    link: 'allos/index.html',
                    items: [
                        { text: '2.1. logging', link: 'allos/logging.html' },
                    ]
                },
                { 
                    text: '3. Development Tools', 
                    link: '',
                    items: [
                        { text: '3.1. unittest', link: '' },
                        { text: '3.2. unittest.loader', link: '' },
                        { text: '3.3. unittest.case', link: '' },
                        { text: '3.4. unittest.suite', link: '' },
                        { text: '3.5. unittest.runner', link: '' },
                        { text: '3.6. profiler', link: '' },
                    ]
                },
                
            ]
        }
    ]
} 