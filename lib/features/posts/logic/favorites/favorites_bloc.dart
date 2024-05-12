import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';
import 'package:real_estaye_app/features/favorites/domain/usecases/delete_favoritre_usecase.dart';
import 'package:real_estaye_app/features/favorites/domain/usecases/get_all_favorites_usecase.dart';
import 'package:real_estaye_app/injection.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  StreamSubscription? todosStreamSubscription;

  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is GetAllFavoritesEvent) {
        emit(LoadingFavoritesState());
        final failureOrPost = await GetAllFavoritesUsecases(getIt()).call();
        failureOrPost.fold(
            (failure) => emit(const ErrorFavoritesState(message: "errir")),
            (todos) {
          try {
            todosStreamSubscription!.cancel();
          } catch (e) {}
          todosStreamSubscription = todos.listen((todosList) {
            emitLoadedTodos(todosList);
          });
        });
        // } else if (event is RefreshAllFavoritesEvent) {
        //   emit(LoadingFavoritesState());

        //   final failureOrPost = await GetAllFavoritesUsecases(getIt()).call();
        //   emit(_mapfilureorPostToState(failureOrPost));
        // }
      } else if (event is RefreshAllFavoritesEvent) {
        emit(LoadingFavoritesState());
        final failureOrPost = await GetAllFavoritesUsecases(getIt()).call();
        failureOrPost.fold(
            (failure) => emit(const ErrorFavoritesState(message: "errir")),
            (todos) {
          try {
            todosStreamSubscription!.cancel();
          } catch (e) {}
          todosStreamSubscription = todos.listen((todosList) {
            emitLoadedTodos(todosList);
          });
        });}
      
       else if (event is DeleteFavoritesEvent) {
        emit(LoadingFavoritesState());
        try {
          await DeleteFavoritesUsecases(getIt()).call(event.id);
          emit(const MessageFavoritesState(
              message: "Favorite deleted successfully"));
        } catch (e) {
          emit(ErrorFavoritesState(message: "Failed to delete favorite: $e"));
        }
      }
    });
  }
  FavoritesState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => const ErrorFavoritesState(message: ""),
      (_) => MessageFavoritesState(message: message),
    );
  }

  void emitLoadedTodos(todos) => emit(LoadedFavoritesState(data: todos));
}
