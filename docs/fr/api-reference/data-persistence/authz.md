---
outline: deep
---

# authz — Gestion des Autorisations Clients

> **Code source:** [BLuau/Libraries/authz/__init.luau](https://github.com/blockguard-sf/BLuau/blob/master/BLuau/Libraries/authz/__init.luau)

## Informations

[authz](#authz--gestion-des-autorisations-clients) fournit un système de gestion d'autorisation pour Luau, permettant un contrôle d'accès basé sur les rôles (RBAC).
Il attribue et gère les autorisations en fonction des rôles des clients.

> [!Note]
> [Authz](#authz--gestion-des-autorisations-clients) ne s'occupe que de gérer l'attribution des permissions et non de gérer les permissions.

Pour pouvoir fonctionner, [authz](#authz--gestion-des-autorisations-clients) utilise le module [rbxdss](rbxdss). Cela veut dire que les [conditions d'utilisation](rbxdss#informations) de rbxdss s'appliquent aussi à ce module.

## Configuration

Par défaut, authz n'assigne pas des permissions aux joueurs en fonction de leur rôle dans un groupe mais d'une assignation manuelle.
Mais il est tout à fait possible de changer cela en configurant authz.

|Paramètres|Descriptions|
|-|-|
|`Module.__groupId`|Identifiant du groupe de référence pour les autorisations basées sur les rôles.|
|`Module.__groupPermissions`|Une [table](https://create.roblox.com/docs/luau/tables) définissant les autorisations par défaut pour chaque rôle.|

Ces paramètres peuvent être modifié via la fonction [`authz.config()`](#configurer-le-module) qui permet de configurer le module.

## Fonctions

---

### Configurer le module

authz.**config**(_groupId, groupPermissions_)

> Configure le module avec le groupe de référence et les autorisations.

Cette fonction doit être appelé au lancement du serveur et ne doit pas être appelé plusieurs fois pour éviter tout conflit ou problème de synchronisation avec les magasins de données.

> [!CAUTION]
> Modifier les autorisations alors que des joueurs ont déjà rejoint le jeu peut entraîner une désynchronisation des permissions, entre les nouvelles permissions attribuées aux joueurs et celles des anciens joueurs.

```luau
PERMISSIONS = {
    ["Admin"] = { "ban_player", "kick_players", "manage_game" },
	["Moderator"] = { "kick_players", "mute_players" },
	["Player"] = { "play_game" },
}

-- Assigne le groupe `123456789` et donne des permissions
authz.config(123456789, PERMISSIONS)
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|groupId: [Number?](https://create.roblox.com/docs/luau/numbers)|Identifiant du groupe à utiliser pour les autorisations basées sur les rôles.|
|groupPermissions: [Table?](https://create.roblox.com/docs/luau/tables)|Définit les autorisations pour chaque rôle.|

#### Retours

|Valeurs|Descriptions|
|-|-|
|[Table](https://create.roblox.com/docs/luau/tables)|Contient la dernière configuration valide du module.|
|[Boolean?](https://create.roblox.com/docs/luau/booleans)|Renvoie `false` si des valeurs non valides sont fournies.|

---

### Assigner des permissions depuis un groupe

authz:**assignPermissionsFromGroup**(_player_)

> Attribue des autorisations à un joueur en fonction de son rôle dans le groupe spécifié.

Permet d'affecter des permissions prédéfinies à un joueur en fonction de son rôle dans un groupe. 
Cette fonction permet de gérer les permissions de tous les joueurs sans avoir à attribuer quelconque autorisation manuellement.

```luau
Players.PlayerAdded:Connect(function(player)
    -- Assigne les permissions aux joueurs dès qu'ils rejoignent le serveur
    authz:assignPermissionsFromGroup(player)
end)
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player)|Le joueur à qui les permissions seront attribuées.|

---

### Assigner des permissions 

authz:**addPermission**(_player, permission_)

> Ajoute une autorisation spécifique à un joueur.

Permet d'ajouter une autorisation spécifique à un joueur sans avoir besoin de créer un groupe. La fonction est nottament utilisé par [`authz:assignPermissionsFromGroup()`](#assigner-des-permissions-depuis-un-groupe) pour ajouter des permissions.

> [!WARNING]
> Il est déconseillé d'utiliser cette commande si vous gérez déjà les permissions via un groupe.
> Cela peut engendrer des problèmes de synchronisation entre les clients et les magasins de données, voire même entre les permissions supposées du client et ses vraies permissions.

```luau
authz:addPermission(player, "manage_server")
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player)|Le joueur à qui la permission sera attribuée.|
|permission: [String](https://create.roblox.com/docs/luau/strings)|Permission que l'on veut donner.|

#### Retours

|Valeurs|Descriptions|
|-|-|
|[Boolean](https://create.roblox.com/docs/luau/booleans)|Renvoie `true` si l'opération a réussis ou `false` si l'opération a raté.|

---

### Retirer des permissions

authz:**removePermission**(_player, permission_)

> Retire une autorisation spécifique à un joueur.

Permet de retirer une autorisation spécifique à un joueur. 
Cette fonction ne sert à rien si vous gérez déjà vos autorisations via un groupe.

```luau
authz:removePermission(player, "manage_server")
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player)|Le joueur à qui la permission sera retirée.|
|permission: [String](https://create.roblox.com/docs/luau/strings)|Permission que l'on veut retirer.|

#### Retours

|Valeurs|Descriptions|
|-|-|
|[Boolean](https://create.roblox.com/docs/luau/booleans)|Renvoie `true` si l'opération a réussis ou `false` si l'opération a raté.|

---

### Lire les permissions du joueurs

authz:**getPermission**(_player_)

> Récupère la liste des autorisations attribuées à un joueur.

```luau
local player_data = authz:getPermission(player, "manage_server")
print(player_data)
```

#### Paramètres

|Arguments|Descriptions|
|-|-|
|player: [Player](https://create.roblox.com/docs/reference/engine/classes/Player)|Le joueur à qui on veut lire les permissions.|

#### Retours

|Valeurs|Descriptions|
|-|-|
|[Table](https://create.roblox.com/docs/luau/tables)|Contient les permissions actuelles assignées au joueur.|