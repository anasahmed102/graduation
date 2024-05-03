// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:real_estaye_app/core/const.dart';

// class FavoritesPage extends StatelessWidget {
//   const FavoritesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       // Handle the case where the user is not authenticated
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Favorites'),
//         ),
//         body: const Center(
//           child: Text('Please log in to view favorites.'),
//         ),
//       );
//     }

//     // Reference to the "users" collection
//     CollectionReference usersCollection =
//         FirebaseFirestore.instance.collection('users');

//     // Reference to the user's document in the "users" collection
//     DocumentReference userDocRef = usersCollection.doc(user.uid);

//     // Reference to the "favorites" subcollection within the user's document
//     CollectionReference favoritesCollection =
//         userDocRef.collection('favorites');

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorites'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: favoritesCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No favorites yet.'));
//           }

//           return ListView.separated(
//             separatorBuilder: (context, index) {
//               return const SizedBox(
//                 height: 20,
//               );
//             },
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var favoriteData =
//                   snapshot.data!.docs[index].data() as Map<String, dynamic>;

//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Stack(
//                       alignment: Alignment.topRight,
//                       children: [
//                         ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Image.network(favoriteData['photo'])),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 50,
//                             width: 50,
//                             decoration: const BoxDecoration(
//                                 shape: BoxShape.circle, color: Colors.white),
//                             child: Icon(
//                               FontAwesomeIcons.heart,
//                               color: context.isDarkMode
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           favoriteData['propertyName'].toString(),
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           favoriteData['propertyName'].toString(),
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           favoriteData['propertyName'].toString(),
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),

//                     // ListTile(
//                     //   title: Text(favoriteData['propertyName'].toString()),
//                     //   subtitle: const Text("Price "),
//                     // )
//                     const SizedBox(
//                       height: 20,
//                     )
//                   ],
//                   // onTap: () {
//                   //   Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsPage(realEstate: )));
//                   // },

//                   // Add more fields as needed
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/favorites/favorites_bloc.dart';
import 'package:real_estaye_app/presentation/favorites/widgets/favorites_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is LoadedFavoritesState) {
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: FavoritesWidget(
                data: state.data,
              ));
        } else if (state is LoadedFavoritesState) {
          return FavoritesWidget(
            data: state.data,
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {},
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<FavoritesBloc>(context).add(RefreshAllFavoritesEvent());
  }
}
