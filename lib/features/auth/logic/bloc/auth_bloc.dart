import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/logout_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/read_from_local_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/signin_signup_google_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/sing_in_anonimously_usecase.dart';
import 'package:real_estaye_app/injection.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(AuthLoadingState());
        final failureOrUser =
            await LoginUserUseCase(getIt()).call(authData: event.authData);
        emit(_eitherFailureOrUser(failureOrUser));
      } else if (event is SignUpUserEvent) {
        emit(AuthLoadingState());
        final failureOrUser =
            await SignUpUserUseCase(getIt()).call(authData: event.authData);
        if (failureOrUser.isRight()) {
          final user = (failureOrUser as Right).value;
          await _storeUserInFirestore(user);
        }
        emit(_eitherFailureOrUser(failureOrUser));
      } else if (event is GoogleSignInSignUpEvent) {
        emit(AuthLoadingState());
        final failureOrUser = await SinginSignUpGoogleUseCase(getIt()).call();
        emit(_eitherFailureOrUser(failureOrUser));
      } else if (event is LogoutEvent) {
        emit(AuthLoadingState());
        final failureOrDone = await LogoutUserUseCase(getIt()).call();
        emit(failureOrDone.fold(
          (failure) => AuthErrorState(message: _mapFailureToMessage(failure)),
          (isDone) => const MessageState(message: " Logout Succesfuly"),
        ));
      } else if (event is GetCurrentUserEvent) {
        emit(AuthLoadingState());
        final failureOrUser = await LocalUseCases(getIt()).call();
        emit(failureOrUser.fold(
          (_) => AuthInitial(),
          (user) => LoadedUserState(user: user),
        ));
      } else if (event is SignInAnonymouslyEvent) {
        final failureOrUser = await SignInAnonimosulyUseCase(getIt()).call();
        emit(_eitherFailureOrUser(failureOrUser));
      }
    });
  }

  AuthState _eitherFailureOrUser(Either<Failure, UserModel> either) {
    return either.fold(
      (failure) {
        return AuthErrorState(message: failure.message);
      },
      (user) => LoadedUserState(user: user),
    );
  }

  Future<void> _storeUserInFirestore(UserModel user) async {
    final firestore = FirebaseFirestore.instance;
    try {
      DocumentReference userDocRef =
          firestore.collection('users').doc(user.uid);
      DocumentSnapshot userDocSnapshot = await userDocRef.get();

      Map<String, dynamic> userData = {
        'email': user.email,
        'uid': user.uid,
      };

      if (!userDocSnapshot.exists ||
          (userDocSnapshot.data() as Map<String, dynamic>?)
                  ?.containsKey('type') !=
              true) {
        userData['type'] = 'user';
      }

      await userDocRef.set(userData, SetOptions(merge: true));

      print('User information successfully saved to Firestore.');
    } catch (e) {
      print("Error storing user in Firestore: $e");
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Error";

      case OfflineFailure:
        return "Error";

      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
