import 'package:equatable/equatable.dart';

import '../../../domain/entities/favorite_character.dart';

sealed class FavoritesEvent extends Equatable {
  
  @override
  List<Object?> get props => [];
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final FavoriteCharacter entity;

  ToggleFavoriteEvent(this.entity);
}

class LoadFavoritesEvent extends FavoritesEvent {}
