import 'dart:async';
import 'package:effective_app/prsentation/bloc/characters_list_bloc/characters_list_event.dart';
import 'package:effective_app/prsentation/bloc/characters_list_bloc/characters_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_characters_list_usecase.dart';

class CharactersListBloc
    extends Bloc<CharactersListEvent, CharactersListState> {
  final GetCharactersListUseCase getCharactersListUseCase;

  CharactersListBloc(this.getCharactersListUseCase)
      : super(const CharactersListInitial()) {
    on<FetchCharactersListEvent>(_onFetchCharacters);
    on<LoadMoreCharactersEvent>(_onLoadMoreCharacters);
    on<RefreshCharactersEvent>(_onRefreshCharacters);
  }

  Future<void> _onFetchCharacters(
    FetchCharactersListEvent event,
    Emitter<CharactersListState> emit,
  ) async {
    emit(const CharactersListLoading());

    try {
      final model = await getCharactersListUseCase(page: 1);

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
      final newModel = await getCharactersListUseCase(page: nextPage);

      emit(
        state.copyWith(
          model: state.model.copyWith(
            results: [...state.model.results!, ...newModel.results!],
            info: newModel.info,
          ),
          currentPage: nextPage,
          hasReachedMax: newModel.info?.next == null,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onRefreshCharacters(
    RefreshCharactersEvent event,
    Emitter<CharactersListState> emit,
  ) async {
    try {
      final model = await getCharactersListUseCase(page: 1);

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
}
