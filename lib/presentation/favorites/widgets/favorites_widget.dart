// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estaye_app/core/const.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';
import 'package:real_estaye_app/presentation/favorites/pages/favorite_details_page.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<Favorites> data;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: const Center(
          child: Text('Please log in to view favorites.'),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.red,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.752,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                    child: Column(children: [
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final favoriteData = data[index];

                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FavoriteDetailsPage(
                                          data: favoriteData),
                                    ),
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                      child: Image.network(
                                        favoriteData.photo,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.heart,
                                          color: context.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          favoriteData.properyName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.place,
                                          size: 20,
                                        ),
                                        Text(
                                          "Iraq Erbil Bakhtayri",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "9924.1-1000000",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ]))),
          ],
        )));
  }
}


// body: StreamBuilder<QuerySnapshot>(
//   stream: realEstae.
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (snapshot.hasError) {
//       return Center(child: Text('Error: ${snapshot.error}'));
//     }

//     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//       return const Center(child: Text('No favorites yet.'));
//     }

//     return ListView.separated(
//       separatorBuilder: (context, index) {
//         return const SizedBox(
//           height: 20,
//         );
//       },
//       itemCount: snapshot.data!.docs.length,
//       itemBuilder: (context, index) {
//         var favoriteData =
//             snapshot.data!.docs[index].data() as Map<String, dynamic>;

//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Stack(
//                 alignment: Alignment.topRight,
//                 children: [
//                   ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Image.network(favoriteData['photo'])),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.white),
//                       child: Icon(
//                         FontAwesomeIcons.heart,
//                         color: context.isDarkMode
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     favoriteData['propertyName'].toString(),
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     favoriteData['propertyName'].toString(),
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     favoriteData['propertyName'].toString(),
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),

//               // ListTile(
//               //   title: Text(favoriteData['propertyName'].toString()),
//               //   subtitle: const Text("Price "),
//               // )
//               const SizedBox(
//                 height: 20,
//               )
//             ],
//             // onTap: () {
//             //   Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsPage(realEstate: )));
//             // },

//             // Add more fields as needed
//           ),
//         );
//       },
//     );
//   },
// ),
