import 'package:effective_app/domain/usecases/get_favorites_usecase.dart';
import 'package:effective_app/favotites_page.dart';
import 'package:effective_app/home_page.dart';
import 'package:effective_app/prsentation/bloc/characters_list_bloc/characters_list_bloc.dart';
import 'package:effective_app/prsentation/bloc/characters_list_bloc/characters_list_event.dart';
import 'package:effective_app/prsentation/bloc/theme_bloc/theme_cubit.dart';
import 'package:effective_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/datasources/favorites_local_datasource.dart';
import 'data/repositories_impl/favorites_repository_impl.dart';
import 'domain/usecases/toggle_favorite_use_case.dart';
import 'prsentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'prsentation/bloc/favorites_bloc/favorites_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('characters_cache');

  //  SQLite / DB
  final favoritesLocalDataSource = FavoritesLocalDataSource();

  //  Repository
  final favoritesRepository = FavoritesRepositoryImpl(favoritesLocalDataSource);

  //  UseCase
  final toggleFavoriteUseCase = ToggleFavoriteUseCase(favoritesRepository);
  final getFavoritesUseCase = GetFavoritesUseCase(favoritesRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) =>
              CharactersListBloc()..add(const FetchCharactersListEvent()),
        ),
        BlocProvider(
          create: (_) =>
              FavoritesBloc(toggleFavoriteUseCase, getFavoritesUseCase),
        ),
      ],
      child: const MainPage(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) =>
              CharactersListBloc()..add(const FetchCharactersListEvent()),
        ),
      ],
      child: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List<Widget> pages = [HomePage(), FavoritesPage()];

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
            title: 'Exclusive app',
            debugShowCheckedModeBanner: false,
            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),
            themeMode: themeMode,
            home: Scaffold(
              bottomNavigationBar: Container(
                height: 70,
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.85),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    iconSize: 20.0,
                    selectedFontSize: 16.0,
                    unselectedFontSize: 12,
                    currentIndex: currentIndex,
                    onTap: onTapped,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: "Favorites",
                      )
                    ]),
              ),
              body: pages[currentIndex],
            ));
      },
    );
  }
}
