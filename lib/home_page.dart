import 'package:effective_app/character_card_item.dart';
import 'package:effective_app/print_helper.dart';
import 'package:effective_app/prsentation/bloc/characters_list_bloc.dart';
import 'package:effective_app/prsentation/bloc/characters_list_event.dart';
import 'package:effective_app/prsentation/bloc/characters_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<CharactersListBloc>().add(
          const FetchCharactersListEvent(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CharactersListBloc, CharactersListState>(
      builder: (context, state) {
        if (state is CharactersListLoading) {
          printGreen("Characters List Loading --> ");
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CharactersListError) {
          printGreen("Characters List Error --> ${state.message}");
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
          final model = state.characters;
          final characters = model.results;
          printGreen("Response --> ${model.info}");

          return Expanded(
            child: ListView.builder(
              itemCount: characters?.length,
              itemBuilder: (context, index) {
                final char = characters?[index];
                return CharacterCardItem(
                  avatarUrl: char!.image.toString(),
                  name: char.name.toString(),
                  timeAgo:
                      char.created.toString(), // or format from char.created
                  description: char.gender.toString(),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    ));
  }
}
