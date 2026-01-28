import 'package:effective_app/prsentation/components/character_card_item.dart';
import 'package:effective_app/prsentation/theme_bloc/theme_cubit.dart';
import 'package:effective_app/utils/print_helper.dart';
import 'package:effective_app/prsentation/characters_list_bloc/characters_list_bloc.dart';
import 'package:effective_app/prsentation/characters_list_bloc/characters_list_event.dart';
import 'package:effective_app/prsentation/characters_list_bloc/characters_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<CharactersListBloc>().add(
          const FetchCharactersListEvent(),
        );

    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      printGreen("Load New Page -->      ");
      context.read<CharactersListBloc>().add(
            const LoadMoreCharactersEvent(),
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            BlocListener<CharactersListBloc, CharactersListState>(
              listener: (context, state) {
                if (state is CharactersListSuccess && state.isLoadingMore) {
                  //  Auto scroll to bottom when loading starts
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent + 80,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                }
              },
              child: BlocBuilder<CharactersListBloc, CharactersListState>(
                builder: (context, state) {
                  if (state is CharactersListLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (state is CharactersListError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${state.message}'),
                          ElevatedButton(
                            onPressed: () => context
                                .read<CharactersListBloc>()
                                .add(FetchCharactersListEvent()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is CharactersListSuccess) {
                    final characters = state.model.results ?? [];
                    printGreen('UI rebuild → items: ${characters.length}');
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<CharactersListBloc>()
                              .add(const RefreshCharactersEvent());
                        },  
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: characters.length + 1,
                          itemBuilder: (context, index) {
                            if (index == characters.length) {
                              return state.isLoadingMore
                                  ? const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    )
                                  : const SizedBox.shrink();
                            }

                            final char = characters[index];
                            return CharacterCardItem(
                              avatarUrl: char.image.toString(),
                              name: char.name.toString(),
                              timeAgo: char.created.toString(),
                              description: char.gender.toString(),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ));
  }
}
