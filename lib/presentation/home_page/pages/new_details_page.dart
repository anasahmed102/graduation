// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/core/widgets/snack_bar.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/home_page/pages/details_map_page.dart';

bool isBlueDark = AppThemee.blueDark as bool;

class NewDetailsPage extends StatelessWidget {
  const NewDetailsPage({
    Key? key,
    required this.realEstate,
  }) : super(key: key);
  final RealEstateModel realEstate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: appThemeData[AppThemee.blueDark]?.brightness == Brightness.dark
            ? Colors.white
            : Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {},
              color: AppTheme.btn1,
              child: const Row(
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Call",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {},
              color: AppTheme.btn1,
              child: const Row(
                children: [
                  Icon(
                    Icons.map,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Whatsapp",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    fit: BoxFit.cover,
                    realEstate.photo,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  Positioned(
                    right: 10,
                    top: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                            onPressed: () async {
                              User? user = FirebaseAuth.instance.currentUser;

                              if (user != null) {
                                CollectionReference usersCollection =
                                    FirebaseFirestore.instance
                                        .collection('users');
                                DocumentReference userDocRef =
                                    usersCollection.doc(user.uid);
                                CollectionReference favoritesCollection =
                                    userDocRef.collection('favorites');

                                QuerySnapshot querySnapshot =
                                    await favoritesCollection
                                        .where('id', isEqualTo: realEstate.id)
                                        .get();
                                if (querySnapshot.docs.isEmpty) {
                                  await favoritesCollection
                                      .doc(realEstate.id.toString())
                                      .set({
                                    'id': realEstate.id.toString(),
                                    'properyName': realEstate.properyName,
                                    'location': realEstate.location,
                                    'size': realEstate.size,
                                    'photo': realEstate.photo
                                    // Add more fields as needed
                                  });

                                  SnackBarMessage().showSuccessSnackBar(
                                    message: 'Added to Favorites',
                                    context: context,
                                  );
                                } else {
                                  SnackBarMessage().showErrorSnackBar(
                                    message:
                                        'Real estate with ID ${realEstate.id} already exists in favorites',
                                    context: context,
                                  );
                                }
                              }
                            },
                            icon: const Icon(FontAwesomeIcons.heart,
                                color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DetailsMapPage(data: realEstate)));
                      },
                      color: AppTheme.btn1,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.map,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Map",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {},
                      color: AppTheme.btn1,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Photos",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "${realEstate.price}\$",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Hrkn Apartment",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Row(
                  children: [
                    Icon(Icons.area_chart),
                    SizedBox(
                      width: 5,
                    ),
                    Text("102M"),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.bed),
                    SizedBox(
                      width: 5,
                    ),
                    Text("3"),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.bathroom_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text("1"),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.place),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Erbil 32park",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsMapPage(
                              data: realEstate,
                            ),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/location.png"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "OverView",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.black,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bed_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text("3"),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 90),
                          child: Row(
                            children: [
                              Icon(Icons.bathroom_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text("2"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.area_chart),
                            SizedBox(
                              width: 10,
                            ),
                            Text("125M"),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 90),
                          child: Row(
                            children: [
                              Icon(Icons.hail),
                              SizedBox(
                                width: 10,
                              ),
                              Text("1"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.query_stats),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Purpose : Sell"),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 90),
                          child: Row(
                            children: [
                              Text("No of floor:"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("2"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Icon(Icons.abc),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text("data")
              //     ],
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Icon(Icons.abc),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text("data")
              //     ],
              //   ),
              // ),
              // const Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Text(
              //         "Map",
              //         style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const MapHrkn()));
              //     },
              //     child: SizedBox(
              //       height: 200,
              //       child: GestureDetector(
              //         child: FlutterMap(
              //           options: MapOptions(
              //             initialCenter: LatLng(realEstate.location.latitude,
              //                 realEstate.location.longitude),
              //             initialZoom: 5.0,
              //           ),
              //           children: [
              //             TileLayer(
              //               urlTemplate:
              //                   "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              //               subdomains: const ['a', 'b', 'c'],
              //             ),
              //             MarkerLayer(
              //               markers: [
              //                 Marker(
              //                   width: 80.0,
              //                   height: 80.0,
              //                   point: LatLng(realEstate.location.latitude,
              //                       realEstate.location.longitude),
              //                   child: Container(
              //                     child: const Icon(
              //                       Icons.location_pin,
              //                       color: Colors.red,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Posted By",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: SvgPicture.asset("assets/images/Workout-Pic.svg"),
                title: const Text(
                  "Anas Ahmed",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
