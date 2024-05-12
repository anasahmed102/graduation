// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetAllFavoritesEvent extends FavoritesEvent {}

class DeleteFavoritesEvent extends FavoritesEvent {
  final int id;
  const DeleteFavoritesEvent({
    required this.id,
  });
}

class RefreshAllFavoritesEvent extends FavoritesEvent {}
