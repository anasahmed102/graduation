import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, Stream<List<Favorites>>>> getAllFavorites();
  Future<void> deleteFavorite(int favoriteId);
}
