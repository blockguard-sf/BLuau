---
outline: deep
---

# BLuau - Référence de l'API

Ce manuel de référence de l'API de BLuau décrit sa bibliothèque et son utilisation. Il décrit également certains des composants facultatifs couramment inclus.

L'API de BLuau contient des modules qui donnent accès à des fonctionnalités très généralistes, permettant aux développeurs d'intégrer cette bibliothèque dans l'ensemble de leur projet et expérience. Ainsi que des modules qui apportent des solutions à de nombreux problèmes rencontrés dans la programmation quotidienne. Certains de ces modules sont explicitement conçus pour encourager les développeurs à mieux tester et optimiser leur code, afin de garantir une meilleure expérience de jeu aux joueurs de Roblox.

En plus de l'API standard, vous pourrez créer et installer des modules créés par la communauté (des programmes et modules individuels aux paquets et des frameworks complets), actuellement indisponibles, à voir dans les prochaines mises à jour.

## Introduction

La "Bibliothèque de BLuau" contient plusieurs types de composants différents.

La majeure partie de l'API est constituée d'une collection de modules. Il existe de nombreuses façons de décortiquer cette collection. Certains modules fournissents des inferfaces très spécifique à Luau, comme l'impressions d'une trace de pile; certains fournissent des interfaces spécifiques à Roblox ; d'autres fournissent des interfaces spécifiques à Bluau.

## Utilisation

---

### Importation

L'importation de BLuau dans votre code a été désignée pour qu'elle soit simple, intuitive et compréhensible pour tous.
Ainsi, n'importe quel développeur, qu'il soit avancé ou non, peut normalement utiliser l'API de BLuau sans aucun problème.
Si vous avez des suggestions pour l'améliorer, n'hésitez pas à nous le faire savoir.

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = require(ReplicatedStorage:WaitForChild("BLuau_Rojo").BLibrary)
```

:::details Importation en une seul ligne

Si vous voulez que l'importation ne prenne pas trop de place (même si c'est déjà le cas), vous pouvez opter pour compresser le code de cette façon :

```luau
local BLuau = require(game:GetService("ReplicatedStorage"):WaitForChild("BLuau_Rojo").BLibrary)
```

> [!WARNING]
> Réduire encore plus le code peut vous faire perdre en optimisation et en fiabilité.
> Le code que vous voyez ci-dessus est la manière la plus fiable de le faire.

:::

Pour pouvoir importer un module, il suffit d'appeler la variable qui interagit avec l'API dans votre code et de mettre le nom du module souhaité.

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BLuau = require(ReplicatedStorage:WaitForChild("BLuau_Rojo").BLibrary)

local logging = BLuau.logging -- Importation de logging
local unittest = BLuau.unittest -- Importation de unittest
```

---

### Bibliothèque standard

- [1. Persistance des Données](data-persistence/index.md)
   - [1.1. rbxdss — Gestion des Magasins de Données](data-persistence/rbxdss.md)
   - [1.2. authz — Gestion des Autorisations Clients](data-persistence/authz.md)
- [2. Services Génériques de Système D'Exploitation](allos/index.md)
   - [2.1. logging — Journalisation Avancés](allos/logging.md)
- [3. Outils de Développement]()
   - [3.1. unittest — Framework de Test Unitaire]()
   - [3.2. unittest.loader — Chargement Dynamique des cas de Test]()
   - [3.3. unittest.case — Définition et Exécution des cas de Test Individuels]()
   - [3.4. unittest.suite — Regroupement de Plusieurs cas de Test]()
   - [3.5. unittest.runner — Automatisation de l'Exécution des Suites de Tests]()
   - [3.6. profiler — Mesurer les Performances des Fonctions]()
