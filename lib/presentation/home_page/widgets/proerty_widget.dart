import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/core/const.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/core/widgets/search_delegates.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/home_page/widgets/but_list.dart';
import 'package:real_estaye_app/presentation/home_page/widgets/rent.dart';
import 'package:real_estaye_app/presentation/home_page/widgets/vertical_list.dart';

class PropertWidget extends StatefulWidget {
  final List<RealEstateModel> realEstae;

  const PropertWidget({Key? key, required this.realEstae}) : super(key: key);

  @override
  State<PropertWidget> createState() => _PropertWidgetState();
}

class _PropertWidgetState extends State<PropertWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: _appbarBuild(context),
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
          ),
          items: imageSliders,
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Featured Unit",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "View More",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondryColor),
              ),
            )
          ],
        ),
        // Stack(children: [Image.network(widget.realEstae[index].photo)],),
        VerticalList(
          data: widget.realEstae,
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Rent",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "View More",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondryColor),
              ),
            ),
          ],
        ),
        RentList(
          datal: widget.realEstae,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Buy",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "View More",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondryColor),
              ),
            ),
          ],
        ),
        BuyList(
          datal: widget.realEstae,
        ),
        // VerticalList(
        //   data: widget.realEstae,
        // ),
      ]),
    );
  }

  AppBar _appbarBuild(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate:
                  PropertySearchDelegate(realEstateStream: widget.realEstae),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ],
      title: const Text("Home Page"),
      centerTitle: true,
    );
  }
}
      // ListView.builder(
        //   primary: false,
        //   padding: EdgeInsets.zero,
        //   shrinkWrap: true,
        //   itemCount: widget.realEstae.length,
        //   itemBuilder: (context, index) {
        //     final realEstate = widget.realEstae[index];
        //     return GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) => NewDetailsPage(
        //               realEstate: realEstate,
        //             ),
        //           ),
        //         );
        //       },
        //       child: Card(
        //         elevation: 2.0,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //         ),
        //         child: Row(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.all(2.0),
        //               child: Stack(
        //                 alignment: Alignment.bottomRight,
        //                 children: [
        //                   SizedBox.fromSize(
        //                     child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(16),
        //                       child: Image.network(
        //                         realEstate.photo,
        //                         fit: BoxFit.cover,
        //                         width: 160,
        //                         height: 160,
        //                       ),
        //                     ),
        //                   ),
        //                   IconButton(
        //                     onPressed: () async {
        //                       User? user = FirebaseAuth.instance.currentUser;

        //                       if (user != null) {
        //                         CollectionReference usersCollection =
        //                             FirebaseFirestore.instance
        //                                 .collection('users');
        //                         DocumentReference userDocRef =
        //                             usersCollection.doc(user.uid);
        //                         CollectionReference favoritesCollection =
        //                             userDocRef.collection('favorites');

        //                         QuerySnapshot querySnapshot =
        //                             await favoritesCollection
        //                                 .where('id', isEqualTo: realEstate.id)
        //                                 .get();
        //                         if (querySnapshot.docs.isEmpty) {
        //                           await favoritesCollection
        //                               .doc(realEstate.id.toString())
        //                               .set({
        //                             'id': realEstate.id,
        //                             'properyName': realEstate.properyName,
        //                             'location': realEstate.location,
        //                             'size': realEstate.size,
        //                             'photo': realEstate.photo
        //                             // Add more fields as needed
        //                           });

        //                           SnackBarMessage().showSuccessSnackBar(
        //                             message: 'Added to Favorites',
        //                             context: context,
        //                           );
        //                         } else {
        //                           SnackBarMessage().showErrorSnackBar(
        //                             message:
        //                                 'Real estate with ID ${realEstate.id} already exists in favorites',
        //                             context: context,
        //                           );
        //                         }
        //                       }
        //                     },
        //                     icon: const Icon(
        //                       Icons.favorite,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             const SizedBox(width: 10.0),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.only(left: 4),
        //                     child: Text(
        //                       "${realEstate.price} \$",
        //                       style: const TextStyle(
        //                         fontSize: 20.0,
        //                         fontWeight: FontWeight.bold,
        //                         fontFamily: 'Palatino',
        //                       ),
        //                     ),
        //                   ),
        //                   const SizedBox(
        //                     height: 7,
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.only(left: 4.0),
        //                     child: Text(realEstate.properyName),
        //                   ),
        //                   const SizedBox(
        //                     height: 7,
        //                   ),
        //                   const Row(
        //                     children: [
        //                       Icon(IconlyLight.location),
        //                       Text(
        //                         "Erbil 32Park",
        //                         style: TextStyle(fontSize: 16),
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 10,
        //                   ),
        //                   const Row(
        //                     children: [
        //                       Icon(Icons.area_chart),
        //                       Text(
        //                         "150",
        //                         style: TextStyle(fontSize: 16),
        //                       ),
        //                       SizedBox(
        //                         width: 10,
        //                       ),
        //                       Icon(Icons.bed),
        //                       Text(
        //                         "3",
        //                         style: TextStyle(fontSize: 16),
        //                       ),
        //                       SizedBox(
        //                         width: 10,
        //                       ),
        //                       Icon(Icons.bathroom_outlined),
        //                       Text(
        //                         "1",
        //                         style: TextStyle(fontSize: 16),
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 10,
        //                   ),
        //                   Row(
        //                     children: [
        //                       ElevatedButton(
        //                           onPressed: () {}, child: const Text("data")),
        //                       const SizedBox(
        //                         width: 5,
        //                       ),
        //                       ElevatedButton(
        //                           onPressed: () {}, child: const Text("data")),
        //                       const SizedBox(
        //                         width: 5,
        //                       ),
        //                       ElevatedButton(
        //                           onPressed: () {}, child: const Text("data")),
        //                     ],
        //                   )
        //                   // Text("Size ${realEstate.size}"),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // )