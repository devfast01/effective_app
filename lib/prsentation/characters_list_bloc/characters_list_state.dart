import 'package:effective_app/data/models/characters_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class CharactersListState extends Equatable {
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
  final CharactersModel characters;

  const CharactersListSuccess(this.characters);

  @override
  List<Object?> get props => [characters];
}


class CharactersListError extends CharactersListState {
  final String message;

  const CharactersListError(this.message);

  @override
  List<Object?> get props => [message];
}


