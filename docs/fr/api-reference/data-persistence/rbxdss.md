---
outline: deep
---

# rbxdss — Gestion des Magasins de Données

> **Code source:** [BLuau/Libraries/rbxdss.luau](https://github.com/blockguard-sf/BLuau/blob/master/BLuau/Libraries/rbxdss.luau)

## Informations

[rbxdss](#rbxdss--datastore-package-for-luau) est une interface simple et sécurisée pour utiliser le `DataStoreService` de Luau.

Si le paramètre [d'accès aux services API](https://create.roblox.com/docs/cloud-services/data-stores#enable-studio-access) n'est pas activé, le module ne fonctionnera pas, tout comme le `DataStoreService`. Il sera donc inutile d'appeler une fonction ou le module en lui-même et renverra un message d'erreur si c'est le cas.

> [!WARNING]
> Le serveur ne peut accéder aux magasins de données que via des `Scripts`. 
> La tentative d'accès côté client dans un `LocalScript` provoquera une erreur.
> 
> Cela vaut aussi pour le module, qui utilise lui aussi les magasins de données pour pouvoir accéder aux données persistantes.

## Fonctions

Les fonctions énumérées dans cette section ont été nommées de façon à rendre plus simple la compréhension des développeurs qui ont l'habitude de manipuler les `DataStores`.

> [!Note]
> Des similitudes peuvent être constatées entre cette documentation et celle de Roblox.
> Cela est parfaitement normal, [rbxdss](#rbxdss--module-de-base-de-donnée-pour-luau) a été créé dans le but d'éviter aux développeurs de réinventer la roue et de devoir réécrire les mêmes lignes de code en boucle.

---

### Créer des Données

rbxdss:**SetAsync**(_player, datastore, objectValue_)

> Enregistre les données d'un joueur spécifique dans le DataStore donné.

Cette fonction définit la dernière valeur des métadonnées pour la clé donnée.

Les erreurs réseau sont nativement gérées et encapsulées dans [`pcall()`](https://create.roblox.com/docs/reference/engine/globals/LuaGlobals#pcall), il est donc inutile de gérer vous-mêmes ce type d'erreur. Toutefois, il est recommandé de se documenter sur la fonction [`SetAsync()`](https://create.roblox.com/docs/reference/engine/classes/GlobalDataStore#SetAsync) native de Roblox pour que vous puissiez mieux comprendre son utilisation.

```luau
Players.PlayerAdded:Connect(function(player)
   -- Sauvegarde des données du joueur à partir de `YOUR_DATASTORE`
   rbxdss:SetAsync(player, "YOUR_DATASTORE", "YOUR_DATA")
end)
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player)|Le joueur dont les données seront sauvegardées vers la clé du magasin de données.|
|dataStore: [string](https://create.roblox.com/docs/luau/strings)|Clée d'accès vers les données que vous souhaitez sauvegarder.|
|objectValue: [any]()|Valeur à laquelle la clé du magasin de données sera définie.|

#### Retours

|Valeurs|Descriptions|
|-|-|
|[Boolean](https://create.roblox.com/docs/luau/booleans)|La valeur correspond au résultat de l'exécution de la fonction. Elle renvoie `true` si la fonction a été exécutée avec succès et `false` si un problème est survenu.|
|[String?](https://create.roblox.com/docs/luau/strings)|Si une erreur est survenue lors de la tentative d'exécution de la fonction, alors le message d'erreur sera envoyé comme deuxième valeur.|

---

### Lire les Données

rbxdss:**GetAsync**(_player, datastore_)

> Récupération des données d'un joueur spécifique à partir du DataStore donnée.

Cette fonction permet de lire la valeur d'une entrée de magasin de données.

Vous pouvez rencontrer certains problème de synchronisation avec le backend en raison du comportement [de mise en cache](https://create.roblox.com/docs/cloud-services/data-stores/manage-data-stores#caching). Ces problèmes ne sont pas géré par la fonction mais peuvent être réglé en [désactivant la mise en cache](https://create.roblox.com/docs/cloud-services/data-stores/manage-data-stores#disable-caching). Nous vous conseillons de le faire à partir du moment où plusieurs serveurs écrivent sur une clé avec une fréquence élevée et doivent obtenir la dernière valeur des serveurs.

> [!WARNING]
> Attention, désactiver la mise en cache peut vous amener à consommer davantage de [limites et de quotas de vos magasins de données](https://create.roblox.com/docs/cloud-services/data-stores/error-codes-and-limits#limits). 
>
> Si vous dépassez cette limite, alors les requêtes seront placées dans une file d'attente.
> À savoir que les files d'attente sont limitées à 30 requêtes, si elles sont dépassées alors les nouvelles requêtes échouent.

```luau
Players.PlayerAdded:Connect(function(player)
   -- Récupération des données du joueur à partir de `YOUR_DATASTORE`
   local data = rbxdss:GetAsync(player, "YOUR_DATASTORE", "YOUR_DATA")
   print(data)
end)
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player)|Le joueur dont les données seront récupérées à partir de la clé du magasin de données.|
|dataStore: [string](https://create.roblox.com/docs/luau/strings)|Clée d'accès vers les données que vous souhaitez récupérer.|

#### Retours

|Valeurs|Descriptions|
|-|-|
|[Tuple](https://create.roblox.com/docs/luau/tuples)|La valeur de l'entrée dans le magasin de données avec la clé donnée et une instance [`DataStoreKeyInfo`](https://create.roblox.com/docs/reference/engine/classes/DataStoreKeyInfo) qui inclut le numéro de version, la date et l'heure de création de la version, ainsi que des fonctions permettant de récupérer [les identifiants utilisateur](https://create.roblox.com/docs/reference/engine/classes/Player#UserId) et les métadonnées.|
