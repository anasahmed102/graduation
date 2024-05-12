import 'package:real_estaye_app/features/favorites/domain/repository/favorites_repositroy.dart';

class DeleteFavoritesUsecases {
  final FavoritesRepository favoritesRepository;

  DeleteFavoritesUsecases(this.favoritesRepository);

  Future<void> call(int id) async {
    return await favoritesRepository.deleteFavorite(id);
  }
}
