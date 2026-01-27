import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CharactersListEvent extends Equatable {
  const CharactersListEvent();

  @override
  List<Object?> get props => [];
}

class FetchCharactersListEvent extends CharactersListEvent {
  const FetchCharactersListEvent();
}
