part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class LoadingFavoritesState extends FavoritesState {}

class ErrorFavoritesState extends FavoritesState {
  final String message;
  const ErrorFavoritesState({
    required this.message,
  });
}

class NullUserFavoriteState extends FavoritesState {}

class MessageFavoritesState extends FavoritesState {
  final String message;
  const MessageFavoritesState({
    required this.message,
  });
}

class LoadedFavoritesState extends FavoritesState {
  final List<Favorites> data;

  const LoadedFavoritesState({required this.data});

  @override
  List<Object> get props => [data];
}
