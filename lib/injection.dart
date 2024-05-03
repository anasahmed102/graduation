import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:real_estaye_app/core/netwrok/network.dart';
import 'package:real_estaye_app/features/auth/data/datasource/local_datasource.dart';
import 'package:real_estaye_app/features/auth/data/datasource/remote_datasource.dart';
import 'package:real_estaye_app/features/auth/data/repositores/impl_repositores.dart';
import 'package:real_estaye_app/features/auth/domain/repositroy/repositroy.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/features/favorites/data/datasource/favorites_remote_datasource.dart';
import 'package:real_estaye_app/features/favorites/data/repository/impl_favorite_repositoy.dart';
import 'package:real_estaye_app/features/favorites/domain/repository/favorites_repositroy.dart';
import 'package:real_estaye_app/features/favorites/domain/usecases/get_all_favorites_usecase.dart';
import 'package:real_estaye_app/features/posts/data/datasource/local_datasource.dart';
import 'package:real_estaye_app/features/posts/data/datasource/remote_datasource.dart';
import 'package:real_estaye_app/features/posts/data/repositroy/impl_repository.dart';
import 'package:real_estaye_app/features/posts/domain/repository/repositroy.dart';
import 'package:real_estaye_app/features/posts/domain/usecases/add_property_usecase.dart';
import 'package:real_estaye_app/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/favorites/favorites_bloc.dart';

GetIt getIt = GetIt.instance;

void initBinding() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  getIt.registerSingleton(InternetConnectionChecker());
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(getIt()));
  getIt.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(auth: firebaseAuth, googleSignIn: googleSignIn));
  getIt.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(
      authRemoteDataSource: getIt(),
      authLocalDataSource: getIt(),
      networkInfo: getIt()));
  getIt.registerSingleton<RealEstateRemoteDataSource>(
      RealEstateRemoteDataSourceImpl());
  getIt.registerSingleton<RealEstateLocalDataSource>(
      RealEstateLocalDataSourceImpl());
  getIt.registerSingleton<RealEstateRepository>(ImplRealEstateRepository(
      networkInfo: getIt(), realEstateRemoteDataSource: getIt()));
  getIt.registerSingleton(GetAllTodoUsecases(getIt()));
  getIt.registerSingleton(AddPropertyUsecases(getIt()));
  getIt.registerSingleton<FavoritesRemoteDataSource>(
      FavoritesRemoteDataSourceImpl());
  getIt.registerSingleton<FavoritesRepository>(ImplFavoritesRepository(
      realEstateRemoteDataSource: getIt(), networkInfo: getIt()));
  getIt.registerSingleton(GetAllFavoritesUsecases(getIt()));

  getIt.registerSingleton(LoginUserUseCase(getIt()));
  getIt.registerSingleton(AuthBloc());
  getIt.registerSingleton(PostsBloc());
  getIt.registerSingleton(FavoritesBloc());
}
