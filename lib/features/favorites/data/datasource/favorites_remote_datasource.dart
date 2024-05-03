import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

// final collectionReference =
//     FirebaseFirestore.instance.collection('Real_Estate').snapshots();
User? user = FirebaseAuth.instance.currentUser;

final usersCollection = FirebaseFirestore.instance.collection('users');

final userDocRef = usersCollection.doc(user!.uid);

final favoritesCollection = userDocRef.collection('favorites').snapshots();
final storageReference = FirebaseStorage.instance.ref();
Reference storageRef = FirebaseStorage.instance.ref();

abstract class FavoritesRemoteDataSource {
  Stream<List<Favorites>> getAllFavorites();
}

class FavoritesRemoteDataSourceImpl extends FavoritesRemoteDataSource {
  @override
  Stream<List<Favorites>> getAllFavorites() {
    return favoritesCollection.map((snapshot) {
      final List<Favorites> realEstateList = snapshot.docs
          .map((doc) => Favorites.fromSnapshot(doc))
          .toList();

      return realEstateList;
    });
  }
}
