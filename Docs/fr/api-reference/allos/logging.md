---
outline: deep
---

# logging — Journalisation Avancés

> **Code source:** [BLuau/Libraries/logging/__init.luau](https://github.com/blockguard-sf/BLuau/blob/master/BLuau/Libraries/logging/__init.luau)

## Informations

Ce module définit des fonctions qui implémentent un système de journalisation d'événement flexible pour les bibliothèques et pour votre code.

Le principale avantage de disposer de l'API de journalisation fournie par un module de la bibliothèque standard est que tous les modules de BLuau peuvent utiliser la journalisation, de sorte que votre journal peut inclure vos propres messages intégrés aux messages de modules tiers.

La seule partie de BLuau qui n'utilise pas la journalisation sont les fichiers internes pour pouvoir éviter les problèmes de conflit et de boucle dans certains cas.

Le système de journalisation contient différents niveaux de priorité que vous pouvez vous-mêmes créer. Il est possible de configurer le comportement de l'enregistreur et de valider certains niveaux de journalisation dans l'environnement Roblox.

## Configuration

|Paramètres|Descriptions|
|-|-|
|`Module.__levels`|Niveau de priorité de la journalisation.|
|`Module.__logger`|Activer ou désactiver l'enregistrement des logs.|

Ces paramètres peuvent être modifié via la fonction [`logging.config()`](#configurer-le-module) qui permet de configurer le module.

## Fonctions

---

### Configurer le module

logging.**config**(_logger, levelName_)

> Configure le module de journalisation.

Cette fonction doit être appelé au lancement du serveur et ne doit pas être appelé plusieurs fois pour éviter tout conflit entre différente requête.

```luau
logging.config(true, "INFO")
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|logger: [Boolean?](https://create.roblox.com/docs/luau/booleans)|Activer ou désactiver l'enregistrement des logs.|
|levelName: [String?](https://create.roblox.com/docs/luau/strings)|Niveau de priorité de la journalisation.|

#### Retours

|Valeurs|Descriptions|
|-|-|
|[Table](https://create.roblox.com/docs/luau/tables)|Contient la dernière configuration valide du module.|
|[Boolean?](https://create.roblox.com/docs/luau/booleans)|Renvoie `false` si des valeurs non valides sont fournies.|

### Envoyer un log

logging.**log**(_message, levelName_)

> Enregistre un message avec le niveau de journalisation spécifié.

```luau
logging.log("YOUR_MESSAGE", "LEVEL_NAME")
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|message: [String?](https://create.roblox.com/docs/luau/strings)|Le message à enregistrer.|
|levelName: [String?](https://create.roblox.com/docs/luau/strings)|Niveau de priorité de la journalisation.|

#### Retours

|Valeurs|Descriptions|
|-|-|
|[Table](https://create.roblox.com/docs/luau/tables)|Contient les informations du journal.|

### Lire les logs

logging.**getLog**()

> Récupère les entrées du journal stockées dans le module Logger.

### Effacer les logs


logging.**clear**()

> Efface toutes les entrées du journal enregistrées.