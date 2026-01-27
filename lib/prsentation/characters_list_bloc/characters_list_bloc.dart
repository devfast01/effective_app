import 'dart:async';
import 'package:effective_app/utils/print_helper.dart';
import 'package:effective_app/prsentation/characters_list_bloc/characters_list_event.dart';
import 'package:effective_app/prsentation/characters_list_bloc/characters_list_state.dart';
import 'package:effective_app/prsentation/repository/characters_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersListBloc
    extends Bloc<CharactersListEvent, CharactersListState> {
  CharactersListBloc() : super(const CharactersListInitial()) {
    on<FetchCharactersListEvent>(_onFetchCharacters);
  }

  Future<void> _onFetchCharacters(
    FetchCharactersListEvent event,
    Emitter<CharactersListState> emit,
  ) async {
    emit(const CharactersListLoading());

    try {
      final model = await CharactersListRepository.getCharactersList(page: 1);
      emit(CharactersListSuccess(model));
    } catch (e, stack) {
      printGreen(stack.toString());
      emit(CharactersListError(e.toString()));
    }
  }
}
