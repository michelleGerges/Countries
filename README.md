
## Architecture Layers

**Application** - App setup, coordination, dependencies  
**Data** - Infrastructure (Location, Network, Repositories)
**Domain** - Business logic, entities, use cases  
**Presentation** - UI layer (MVVM + Views)
**Resources** - Assets, localization

## Data Flow

View → ViewModel → UseCase → Repository → Data Sources (Locale | Remote)

## Features

- Search countries
- Location-based detection

## Patterns

MVVM + Coordinator + Repository + Dependency Injection
