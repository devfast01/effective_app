# Rick and Morty Mobile App
The app fetches a list of characters from the server and displays them on the home screen.
To improve user experience, the character list is cached using Hive, allowing the app to work in offline mode when there is no internet connection.
Users can mark characters as favorites, which are stored locally using SQLite and shown on a dedicated Favorites screen.
The app includes pagination for loading characters efficiently, supports dark mode, and uses a bottom navigation bar to switch between the Home and Favorites screens.

## Features
- Clean architechture.
- BloC state management.
- Displays a list of characters from [Rick and Morty Api](https://rickandmortyapi.com/documentation/).
- Pagging to load more items.
- Caching  items to load in offline mode.
- Bottom Nav bar.
- Favorite items save to SQLite database.
- Dark and Ligth mode.

  
## Tech-stack  
This project uses the popular packages:
- [Flutter](https://flutter.dev/) version: 3.22.3.
- [Dart](https://docs.flutter.dev/install/archive) sdk version: >=3.4.4 <4.0.0.
- [Cached network image](https://pub.dev/packages/cached_network_image) version: 3.4.0
- [http](https://pub.dev/packages/http) version: 1.6.0
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) version: 9.1.1
- [equatable](https://pub.dev/packages/equatable) version: 2.0.8
- [hive](https://pub.dev/packages/hive) version: 2.2.3
- [hive_flutter](https://pub.dev/packages/hive_flutter) version: 1.1.0
- [sqflite](https://pub.dev/packages/sqflite) version: 2.3.0
- [path](https://pub.dev/packages/path) version: 1.9.0


