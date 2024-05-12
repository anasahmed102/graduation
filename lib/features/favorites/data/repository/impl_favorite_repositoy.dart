import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/excemption.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/core/netwrok/network.dart';
import 'package:real_estaye_app/features/favorites/data/datasource/favorites_remote_datasource.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';
import 'package:real_estaye_app/features/favorites/domain/repository/favorites_repositroy.dart';

class ImplFavoritesRepository extends FavoritesRepository {
  final FavoritesRemoteDataSource realEstateRemoteDataSource;
  final NetworkInfo networkInfo;

  ImplFavoritesRepository({
    required this.realEstateRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Stream<List<Favorites>>>> getAllFavorites() async {
    if (await networkInfo.isconnected) {
      try {
        Stream<List<Favorites>> remotePosts =
            realEstateRemoteDataSource.getAllFavorites();

        return Right(remotePosts);
      } on ServerException {
        return const Left(ServerFailure(message: "No Internet Connection"));
      } on Exception {
        return const Left(WrongDataFailure(
            message:
                "No Data, please connect to the internet and try again later"));
      }
    } else {
      return const Left(OfflineFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFavorite(int favoriteId) async {
    if (await networkInfo.isconnected) {
      try {
        await realEstateRemoteDataSource.deleteFavorite(favoriteId);
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure(message: "No Internet Connection"));
      } catch (_) {
        return const Left(WrongDataFailure(
            message: "Failed to delete favorite. Please try again later."));
      }
    } else {
      return const Left(OfflineFailure(message: ""));
    }
  }
}
