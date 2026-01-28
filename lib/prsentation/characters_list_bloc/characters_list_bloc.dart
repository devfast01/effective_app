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
    on<LoadMoreCharactersEvent>(_onLoadMoreCharacters);
  }

  Future<void> _onFetchCharacters(
    FetchCharactersListEvent event,
    Emitter<CharactersListState> emit,
  ) async {
    emit(const CharactersListLoading());

    try {
      final model = await CharactersListRepository.getCharactersList(page: 1);

      emit(
        CharactersListSuccess(
          model: model,
          currentPage: 1,
          hasReachedMax: model.info?.next == null,
        ),
      );
    } catch (e) {
      emit(CharactersListError(e.toString()));
    }
  }

  Future<void> _onLoadMoreCharacters(
    LoadMoreCharactersEvent event,
    Emitter<CharactersListState> emit,
  ) async {
    final state = this.state;

    if (state is! CharactersListSuccess) return;
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;

    try {
      final newModel =
          await CharactersListRepository.getCharactersList(page: nextPage);

      final updatedModel = state.model.copyWith(
        results: [
          ...state.model.results!,
          ...newModel.results!,
        ],
        info: newModel.info,
      );

      emit(
        state.copyWith(
          model: updatedModel,
          currentPage: nextPage,
          hasReachedMax: newModel.info?.next == null,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }
}
