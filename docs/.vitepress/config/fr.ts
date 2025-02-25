import { DefaultTheme, defineConfig } from 'vitepress'

export const fr = defineConfig({
    lang: 'fr',
    description: 'Une Bibliothèque Open Source Pour Roblox.',

    themeConfig: {
        nav: nav(),

        sidebar: {
            'BLuau/fr/whatsnew/': { base: 'BLuau/fr/whatsnew/', items: sidebarWhatsNew() },
            'BLuau/fr/api-reference/': { base: 'BLuau/fr/api-reference/', items: sidebarAPIReference() }
        },

        editLink: {
            pattern: 'https://github.com/blockguard-sf/bluau/edit/main/Docs/:path',
            text: 'Modifier cette page sur GitHub'
        },

        footer: {
            message: 'Publié sous Apache-2.0 License.',
            copyright: 'Copyright © 2025 BlockGuard SF. Tous droits réservés.'
        },

        docFooter: {
            prev: 'Précédent',
            next: 'Suivant'
        },

        outline: {
            label: 'Sur cette page'
        },

        lastUpdated: {
            text: 'Mise à jour dans',
            formatOptions: {
                dateStyle: 'short',
                timeStyle: 'medium'
            }
        },

        langMenuLabel: 'Changer de langue',
        returnToTopLabel: 'Retour en haut',
        sidebarMenuLabel: 'Menu Latéral',
        darkModeSwitchLabel: 'Mode Sombre',
        lightModeSwitchTitle: 'Passer en mode clair',
        darkModeSwitchTitle: 'Passer en mode sombre',
        skipToContentLabel: 'Passer au contenu'
    },
})

function nav() {
    return [
        {
            text: 'Nouveautés?',
            link: 'BLuau/fr/whatsnew/index',
            activeMarch: 'BLuau/whatsnew/'
        },
        {
            text: 'Référence API',
            link: 'BLuau/fr/api-reference/index',
            activeMarch: 'BLuau//api-reference/'
        },
        {
            text: 'v1.0',
            items: [
                {
                    text: 'Changelog',
                    link: 'https://github.com/blockguard-sf/BLuau/blob/master/CHANGELOG/1.0.md'
                },
                {
                    text: 'Contribuer',
                    link: '#'
                }
            ]
        }
    ]
}

function sidebarWhatsNew() {
    return [
        {
            text: 'Docs Par Versions',
            collapsed: false,
            items: [
                { text: 'BLuau 1.1 (en développement)', link: '1.1' },
                { text: 'BLuau 1.0 (stable)', link: '1.0' }
            ]
        }
    ]
} 

function sidebarAPIReference() {
    return [
        {
            text: 'Référence de l\'API',
            collapsed: false,
            items: [
                { 
                    text: '1. Persistance des Données', 
                    link: 'data-persistence/index',
                    items: [
                        { text: '1.1. rbxdss', link: 'data-persistence/rbxdss' },
                        { text: '1.2. authz', link: 'data-persistence/authz' },
                    ]
                },
                { 
                    text: '2. Services Génériques de Système D\'Exploitation', 
                    link: 'allos/index',
                    items: [
                        { text: '2.1. logging', link: 'allos/logging' },
                    ]
                },
                { 
                    text: '3. Outils de Développement', 
                    link: '',
                    items: [
                        { text: '3.1. unittest', link: '' },
                        { text: '3.2. unittest.loader', link: '' },
                        { text: '3.3. unittest.case', link: '' },
                        { text: '3.4. unittest.suite', link: '' },
                        { text: '3.5. unittest.runner', link: '' },
                        { text: '3.6. profiler', link: '' },
                    ]
                }
            ]
        }
    ]
} 

export const search: DefaultTheme.AlgoliaSearchOptions['locales'] = {
    fr: {
        placeholder: 'Rechercher des documents',
        translations: {
            button: {
                buttonText: 'Rechercher',
                buttonAriaLabel: 'Rechercher'
            },
            modal: {
                searchBox: {
                    resetButtonTitle: 'Effacer la recherche',
                    resetButtonAriaLabel: 'Effacer la recherche',
                    cancelButtonText: 'Annuler',
                    cancelButtonAriaLabel: 'Annuler'
                },
                startScreen: {
                    recentSearchesTitle: 'Historique de recherche',
                    noRecentSearchesText: 'Aucune recherche récente',
                    saveRecentSearchButtonTitle: 'Enregistrer dans l\'historique de recherche',
                    removeRecentSearchButtonTitle: 'Supprimer de l\'historique de recherche',
                    favoriteSearchesTitle: 'Favoris',
                    removeFavoriteSearchButtonTitle: 'Supprimer des favoris'
                },
                errorScreen: {
                    titleText: 'Il n\'a pas été possible d\'obtenir des résultats',
                    helpText: 'Vérifiez votre connexion réseau'
                },
                footer: {
                    selectText: 'Sélectionner',
                    navigateText: 'Parcourir',
                    closeText: 'Fermer',
                    searchByText: 'Rechercher par'
                },
                noResultsScreen: {
                    noResultsText: 'Impossible de trouver des résultats',
                    suggestedQueryText: 'Vous pouvez essayer une nouvelle recherche',
                    reportMissingResultsText: 'Devrait-il y avoir des résultats pour cette requête?',
                    reportMissingResultsLinkText: 'Cliquez pour envoyer des commentaires'
                }
            }
        }
    }
}