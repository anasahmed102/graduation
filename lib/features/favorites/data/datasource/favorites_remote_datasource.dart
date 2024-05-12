import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';

User? user = FirebaseAuth.instance.currentUser;

final usersCollection = FirebaseFirestore.instance.collection('users');

final userDocRef = usersCollection.doc(user!.uid);

final favoritesCollection = userDocRef.collection('favorites');

final storageReference = FirebaseStorage.instance.ref();
Reference storageRef = FirebaseStorage.instance.ref();

abstract class FavoritesRemoteDataSource {
  Stream<List<Favorites>> getAllFavorites();
  Future<void> deleteFavorite(int favoriteId);
}

class FavoritesRemoteDataSourceImpl extends FavoritesRemoteDataSource {
  @override
  Stream<List<Favorites>> getAllFavorites() {
    return favoritesCollection.snapshots().map((snapshot) {
      final List<Favorites> favoritesList =
          snapshot.docs.map((doc) => Favorites.fromSnapshot(doc)).toList();

      return favoritesList;
    });
  }

@override
  Future<void> deleteFavorite(int favoriteId) async {
    try {
      final QuerySnapshot snapshot = await favoritesCollection
          .where('favoriteId', isEqualTo: favoriteId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot docSnapshot = snapshot.docs.first;
        await docSnapshot.reference.delete();
      } else {
        throw Exception('Favorite not found');
      }
    } catch (e) {
      throw Exception('Failed to delete the favorite: $e');
    }
  }

}
