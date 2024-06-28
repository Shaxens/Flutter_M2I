# Devoir Flutter M2I ![AppVersion](https://img.shields.io/badge/Version-1.0.0-green)

## Auteur
- Nom: Arthur VIETTI

# Tintin
## Description
Tintin est une application mobile Flutter permettant aux utilisateurs de rechercher d'intéragir avec une liste d'albums, il est possible d'en voir le détail et de les ajouter à la wishlist.

## Fonctionnalités
- Liste des BD Tintin.
- Détail d'une BD.
- Ajout ou suppression d'une BD à la wishlist.

## Installation
- Clonez le dépôt :

```sh
git clone git@github.com:Shaxens/Flutter_M2I.git
cd devoir/tintin
```

Installez les dépendances :
```sh
flutter pub get
```

Exécutez l'application :

```sh
flutter run
```

## Dépendances
- provider

# Meteo App
## Description
Meteo App est une application mobile Flutter permettant aux utilisateurs de rechercher des villes et d'afficher la météo pour chacune d'elles. Les utilisateurs peuvent sélectionner plusieurs villes, et l'application persiste ces villes localement afin de permettre leur affichage lors de la prochaine utilisation de l'application.


## Fonctionnalités
- Recherche de villes par nom.
- Affichage de la météo pour les villes sélectionnées.
- Persistance locale des villes sélectionnées à l'aide de shared_preferences.

## Installation
- Clonez le dépôt :

```sh
git clone git@github.com:Shaxens/Flutter_M2I.git
cd devoir/meteo
```

Installez les dépendances :
```sh
flutter pub get
```

Exécutez l'application :

```sh
flutter run
```

## Dépendances
- shared_preferences
- flutter_map
- latlong2

## Utilisation
Recherche de ville :

- Entrez le nom d'une ville dans le champ de recherche.
- Cliquez sur "Ajouter la ville" pour ajouter la ville à la liste des villes sélectionnées.

Affichage de la météo :

- Sélectionnez une ville dans la liste des villes ajoutées pour afficher la météo.
- Cliquez sur l'icône de suppression pour retirer une ville de la liste.

Persistance locale :

- Les villes ajoutées sont automatiquement sauvegardées et rechargées lors de la prochaine utilisation de l'application. (Le chargement fonctionne uniquement lors de la recherche d'une ville j'ai pas réussit à fix ce problème)
