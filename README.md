Patrones usados:
* MVVM (Model-View-ViewModel) + Coordinators
* Combine para comunicación reactiva
* Dependency Injection en repositorios
* SOLID & Clean Architecture principles

Arquitectura del Proyecto

  RickAndMorty/
│
├── Domain/                     # Modelos de dominio y protocolos
│   ├── CharacterModel.swift
│   ├── CharacterRepository.swift
│   ├── EpisodesRepository.swift
│   └── FavoritesRepository.swift
│
├── Modules/                    # Módulos funcionales de la app (MVVM + Coordinator)
│   ├── characterDetail/
│   │   ├── coordinator/
│   │   ├── view/
│   │   │   └── cell/
│   │   ├── characterDetail/
│   │   └── viewModel/
│   ├── characterMap/
│   ├── dashboard/
│   ├── favoritesList/
│   └── listCharacters/
│
├── Persistence/                # Core Data stack y almacenamiento persistente
│   └── PersistenceController.swift
│
├── Resources/                  # Recursos gráficos y modelos de Core Data
│   ├── Assets.xcassets
│   ├── Base.lproj
│   └── FavoriteCharacter.xcdatamodeld/
│
├── Utils/                      # Utilidades y helpers
│   ├── CharacterAnnotation.swift
│   ├── EpisodeSeenStore.swift
│   ├── ImageCache.swift
│   ├── ImageLoader.swift
│   ├── AppDelegate.swift
│   └── Info.plist
│
├── RickAndMortyTests/          # Pruebas unitarias
│
└── RickAndMortyUITests/        # Pruebas UI

Cómo ejecutar el proyecto

Clonar el repositorio
  git clone https://github.com/tuUsuario/rickandmorty-ios.git
  cd rickandmorty-ios

Abrir el proyecto en Xcode
  open RickAndMorty.xcodeproj

Seleccionar un simulador
  Ejemplo:
  iPhone 15

Ejecutar la app
  Presiona:
    ⌘ + R
    
Unit Tests
Los tests unitarios se encuentran en:
  RickAndMortyTests/
  
Para ejecutarlos:
  Desde Xcode
    Presiona:
      ⌘ + U
