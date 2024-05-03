import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';
import 'package:real_estaye_app/features/favorites/domain/repository/favorites_repositroy.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

class GetAllFavoritesUsecases {
  final FavoritesRepository favoritesRepository;

  GetAllFavoritesUsecases(this.favoritesRepository);

  Future<Either<Failure, Stream<List<Favorites>>>> call() async {
    return await favoritesRepository.getAllFavorites();
  }
}
