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

