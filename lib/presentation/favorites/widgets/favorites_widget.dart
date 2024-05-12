// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_estaye_app/core/lang/localization.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';
import 'package:real_estaye_app/presentation/auth/pages/login_page.dart';

class FavoritesWidget extends StatefulWidget {
  const FavoritesWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<Favorites> data;

  @override
  State<FavoritesWidget> createState() => _FavoritesWidgetState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
User? _user;

class _FavoritesWidgetState extends State<FavoritesWidget> {
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    _user = _auth.currentUser;
  }

  Future<void> deleteFavorite(String favoriteId) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      final userDocRef = usersCollection.doc(_user!.uid);
      final favoritesCollection = userDocRef.collection('favorites');

      await favoritesCollection.doc(favoriteId).delete();
      print("Document with id $favoriteId deleted from favorites");
    } catch (error) {
      print("Error deleting favorite: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Please Login to see Your favorites".tr(context)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginPagee()));
                  },
                  child: Text("Login".tr(context)))
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Favorites".tr(context),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            if (_user != null)
              Column(
                children: widget.data.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final Favorites book = entry.value;

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => TempDetailsBooksPage(books: book),
                          //   ),
                          // );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(19),
                                    child: SizedBox(
                                      height: 160,
                                      width: 140,
                                      child: Image.network(
                                        book.photo,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deleteFavorite(book.id);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          right: 8.0, bottom: 8),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "500000 \$",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      book.properyName,
                                      style: const TextStyle(
                                          color: AppTheme.secondryColor,
                                          fontSize: 15),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.place),
                                    Text(
                                      "32 park lorem ipsum",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.area_chart),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("125"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.bed),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("2"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.bedroom_baby),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("1")
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {},
                                      color: AppTheme.btn1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.call,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Call",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    MaterialButton(
                                      onPressed: () {},
                                      color: AppTheme.btn1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.mail,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Email",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (index < widget.data.length - 1)
                        const Divider(thickness: 1),
                    ],
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
