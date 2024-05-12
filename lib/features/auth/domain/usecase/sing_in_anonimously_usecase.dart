import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';
import 'package:real_estaye_app/features/auth/domain/repositroy/repositroy.dart';

class SignInAnonimosulyUseCase {
  final AuthRepository repository;

  SignInAnonimosulyUseCase(this.repository);

  Future<Either<Failure, UserModel>> call() async {
    return await repository.signInAnonimsly();
  }
}
