// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:real_estaye_app/injection.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
    StreamSubscription? todosStreamSubscription;
  PostsBloc() : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
     if (event is GetAllPostEvent) {
        emit(LoadingPostsState());
        final failureOrPost = await GetAllTodoUsecases(getIt()).call();
        failureOrPost.fold(
            (failure) =>
                emit(ErrorPostsState(message:"errir")),
            (todos) {
          try {
            todosStreamSubscription!.cancel();
          } catch (e) {}
          todosStreamSubscription = todos.listen((todosList) {
            emitLoadedTodos(todosList);
          });
        });
      }
    //  else if (event is GetAllPostEvent) {
    //     emit(LoadingPostsState());

    //     final failureOrPost = await GetAllTodoUsecases(getIt()).call();
    //     emit(_mapfilureorPostToState(failureOrPost));
    //   } else if (event is RefreshAllPostEvent) {
    //     emit(LoadingPostsState());

    //     final failureOrPost = await GetAllTodoUsecases(getIt()).call();
    //     emit(_mapfilureorPostToState(failureOrPost));
    //   } else if (event is GetMapEvent) {
    //     emit(LoadingPostsState());

    //     final failureOrPost = await GetAllTodoUsecases(getIt()).call();
    //     emit(_mapfilureorPostToState(failureOrPost));
    //   }
    });
  }
  void emitLoadedTodos(todos) => emit(LoadedPostsState(realEstate: todos));

//   PostsState _mapfilureorPostToState(
//       Either<Failure, List<RealEstateModel>> either) {
//     final result = either.fold(
//       (l) => const ErrorPostsState(
//           message:
//               "Error Please Check your internet connection and try again later"),
//       (r) =>       todosStreamSubscription = r.listen((todosList) {
//             emitLoadedTodos(todosList);
//           })
//     );
//     return result;
//   }
// }

// import '../../../../../core/error/failures.dart';
// import '../../../../../core/strings/failures.dart';
// import '../../../domain/entities/todo.dart';
// import '../../../domain/usecases/get_todos.dart';

// part 'todo_event.dart';
// part 'todo_state.dart';

// class TodoBloc extends Bloc<TodoEvent, TodoState> {
//   final GetTodosUsecase getTodos;
//   StreamSubscription? todosStreamSubscription;
//   TodoBloc({
//     required this.getTodos,
//   }) : super(TodosInitialState()) {
//     on<TodoEvent>((event, emit) async {
//       if (event is GetAllTodosEvent) {
//         emit(TodosLoadingState());
//         final failureOrDone = await getTodos();
//         failureOrDone.fold(
//             (failure) =>
//                 emit(TodosErrorState(message: _mapFailureToMessage(failure))),
//             (todos) {
//           try {
//             todosStreamSubscription!.cancel();
//           } catch (e) {}
//           todosStreamSubscription = todos.listen((todosList) {
//             emitLoadedTodos(todosList);
//           });
//         });
//       }
//     });
//   }
//   void emitLoadedTodos(todos) => emit(LoadedTodosState(todos: todos));

//   @override
//   Future<void> close() async {
//     todosStreamSubscription!.cancel();
//     return super.close();
//   }

//   String _mapFailureToMessage(Failure failure) {
//     switch (failure.runtimeType) {
//       case ServerFailure:
//         return SERVER_FAILURE_MESSAGE;
//       case CacheFailure:
//         return CACHE_FAILURE_MESSAGE;
//       case OfflineFailure:
//         return OFFLINE_FAILURE_MESSAGE;
//       case InvalidDataFailure:
//         return INVALID_DATA_FAILURE_MESSAGE;
//       case FirebaseDataFailure:
//         final FirebaseDataFailure _firebaseFailure =
//             failure as FirebaseDataFailure;
//         return _firebaseFailure.message;
//       default:
//         return 'Unexpected Error, Please try again later .';
//     }
//   }
// }
}