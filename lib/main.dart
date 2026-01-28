import 'package:effective_app/favotites_page.dart';
import 'package:effective_app/home_page.dart';
import 'package:effective_app/prsentation/characters_list_bloc/characters_list_bloc.dart';
import 'package:effective_app/prsentation/characters_list_bloc/characters_list_event.dart';
import 'package:effective_app/prsentation/theme_bloc/theme_cubit.dart';
import 'package:effective_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('characters_cache');

  runApp(const MyApp());
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
        // other blocs...
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
  final List<Widget> pages = [HomePage(), FavoritePage()];

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
                        label: "Favorite",
                      )
                    ]),
              ),
              body: pages[currentIndex],
            ));
      },
    );
  }
}
