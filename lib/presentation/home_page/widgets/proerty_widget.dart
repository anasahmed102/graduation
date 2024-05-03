import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/core/const.dart';
import 'package:real_estaye_app/core/widgets/search_delegates.dart';
import 'package:real_estaye_app/core/widgets/snack_bar.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/home_page/pages/new_details_page.dart';
import 'package:real_estaye_app/presentation/auth/pages/sign_in_page.dart';
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

  BlocListener<AuthBloc, AuthState> _buildBody() {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        } else if (state is MessageState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        }
      },
      child: SingleChildScrollView(
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
                  "Featured",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "View More",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
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
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          VerticalList(
            data: widget.realEstae,
          ),
          ListView.builder(
            primary: false,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: widget.realEstae.length,
            itemBuilder: (context, index) {
              final realEstate = widget.realEstae[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewDetailsPage(
                        realEstate: realEstate,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image(
                          image: NetworkImage(realEstate.photo),
                          width: 120,
                          height: 90,
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                realEstate.properyName,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Palatino',
                                ),
                              ),
                              Text(realEstate.price),
                              Text("Location ${realEstate.location}"),
                              Text("Size ${realEstate.size}"),
                            ],
                          ),
                        ),
                        IconButton(
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

                              await favoritesCollection.add({
                                'id': realEstate.id,
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
                            }
                          },
                          icon: const Icon(Icons.favorite),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ]),
      ),
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
