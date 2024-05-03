import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';
import 'package:real_estaye_app/features/favorites/domain/usecases/get_all_favorites_usecase.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
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
        failureOrPost.fold((failure) => emit(ErrorFavoritesState(message: "errir")),
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
       }
    });
  }
  FavoritesState _mapfilureorPostToState(
      Either<Failure, List<Favorites>> either) {
    final result = either.fold(
      (l) => const ErrorFavoritesState(
          message:
              "Error Please Check your internet connection and try again later"),
      (r) => LoadedFavoritesState(data: r),
    );
    return result;
  }

void emitLoadedTodos(todos) => emit(LoadedFavoritesState(data: todos));
}