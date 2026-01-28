import 'package:effective_app/data/models/characters_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CharactersListState extends Equatable {
  const CharactersListState();

  @override
  List<Object?> get props => [];
}

class CharactersListInitial extends CharactersListState {
  const CharactersListInitial();
}

class CharactersListLoading extends CharactersListState {
  const CharactersListLoading();
}

class CharactersListSuccess extends CharactersListState {
  final CharactersModel model;
  final int currentPage;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const CharactersListSuccess({
    required this.model,
    required this.currentPage,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  CharactersListSuccess copyWith({
    CharactersModel? model,
    int? currentPage,
    bool? isLoadingMore,
    bool? hasReachedMax,
  }) {
    return CharactersListSuccess(
      model: model ?? this.model,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        model,
        currentPage,
        isLoadingMore,
        hasReachedMax,
      ];
}

class CharactersListError extends CharactersListState {
  final String message;

  const CharactersListError(this.message);

  @override
  List<Object?> get props => [message];
}
