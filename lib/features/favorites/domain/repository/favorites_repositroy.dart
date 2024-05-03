import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, Stream<List<Favorites>>>> getAllFavorites();
}
