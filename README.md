# Application Météo iOS

## Développeurs
- GRAINCA Albi
- GOKER Batuhan

## Version d'Xcode
- Utilisée : Xcode 15

## Architecture du Logiciel

Notre application utilise l'architecture **Model-View-ViewModel (MVVM)** pour séparer la logique métier de l'interface utilisateur.

### Packages

L'application est structurée en plusieurs packages que nous détaillons ci-dessous.

#### Package Service
**Services** : Contient les services de réseau `GeocodingService` et `WeatherService` qui gèrent les appels API pour la récupération des coordonnées géographiques et des données météorologiques : 

##### GeocodingService

- **Rôle** : Convertit les noms de ville en coordonnées géographiques (latitude et longitude) en utilisant l'API de géocodage.
- **Fonctionnement** : En recevant un nom de ville en entrée, le service construit une URL de requête contenant le nom de la ville. Il utilise `URLSession` pour effectuer un appel réseau asynchrone vers l'API de géocodage. Une fois les données reçues, elles sont décodées du format JSON en un modèle de données `SearchResults` contenant les résultats de la recherche, y compris les coordonnées.

##### WeatherService

- **Rôle** : Récupère les données météorologiques actuelles et les prévisions pour une localisation spécifiée par sa latitude et sa longitude. Les données météorologique sont par jour, par heure ainsi que courant.
- **Fonctionnement** : Ce service prend en entrée les coordonnées géographiques d'une ville et construit une URL pour interroger l'API météorologique. L'appel réseau est réalisé de manière asynchrone avec `URLSession`. Les données JSON reçues en réponse sont ensuite décodées en un modèle de données `WeatherData`, qui contient les informations météorologiques détaillées, telles que la température actuelle, les conditions météorologiques, et les prévisions horaires et quotidiennes.

#### Package ViewModels
**ViewModels** : Comprend la ViewModel `CityViewModel` qui interagit avec les services pour récupérer les données, les traiter et préparer les informations à afficher.
#### Package View
**View** : Contient les vues SwiftUI qui affichent l'interface utilisateur, telles que `CitiesView`, `SearchView`, et `WeatherView`, en utilisant les données fournies par les ViewModels:

- **CitiesView** : Affiche une liste des villes enregistrées par l'utilisateur. Chaque ville peut être sélectionnée pour afficher des détails météorologiques spécifiques. Cette vue utilise un `NavigationView` pour faciliter la navigation vers les détails de chaque ville et inclut un bouton pour accéder à la `SearchView` afin d'ajouter de nouvelles villes. Nous pouvons aussi supprimer une ville présente de la liste.

- **SearchView** : Permet à l'utilisateur de rechercher des villes par nom. Les résultats de recherche sont affichés dans une liste où chaque ville peut être ajoutée à la liste des villes enregistrées. La recherche est déclenchée par une saisie de texte suivie d'une action de soumission, et les résultats sont affichés dynamiquement.

- **WeatherView** : Présente les détails météorologiques de la ville sélectionnée, y compris la température actuelle, les conditions météorologiques, et des prévisions horaires et quotidiennes. Les données météorologiques sont affichées à l'aide de composants visuels personnalisés pour une meilleure lisibilité et une expérience utilisateur améliorée. La vue affiche également des informations comme les températures maximales et minimales et utilise des icônes (grâce au weathercode) pour illustrer les conditions météorologiques actuelles.

#### Package Models
**Models** : Définit les modèles de données comme `City` et `WeatherData` qui représentent les structures des données manipulées par l'application.

#### Package Components
**Components** : Regroupe les composants réutilisables de l'interface utilisateur, par exemple `DailyForecastView` et `HourlyWeatherView`, qui aident à construire les écrans de l'application de manière modulaire.

### Fonctionnement

- **Récupération des données** : Les services effectuent des requêtes asynchrones pour récupérer les données géographiques et météorologiques à partir des API externes.
- **Traitement des données** : Les ViewModels traitent ces données, notamment en filtrant et en préparant les informations météorologiques pour leur affichage.
- **Affichage des données** : Les vues utilisent les données préparées par les ViewModels pour présenter les informations météorologiques à l'utilisateur de manière interactive et engageante.

Nous nous sommes dirigé vers cette architecture afin de favoriser une séparation claire des responsabilités. Pour le design, nous avons pris exemple sur l'application météo d'Apple.
