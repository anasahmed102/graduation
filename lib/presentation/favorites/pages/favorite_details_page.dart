// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:real_estaye_app/features/favorites/data/model/favorites.dart';

class FavoriteDetailsPage extends StatelessWidget {
  const FavoriteDetailsPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Favorites data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / 2,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(data.properyName),
              background: Image.network(
                data.photo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   data.price,
                          //   style: const TextStyle(
                          //     fontSize: 18.0,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // Text(
                          //   realEstate.location,
                          //   style: const TextStyle(
                          //     fontSize: 16.0,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          Text(
                            'Posted 2 hours ago',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                // Add Text Info
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Property Info',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text(
                //     data.description,
                //     style: const TextStyle(
                //       fontSize: 16.0,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Agent Name',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // _launchPhoneDialer("7701618237");
              },
              child: const Text(
                'Contact Agent',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _launchPhoneDialer(String phoneNumber) async {
  //   final url = 'tel:$phoneNumber';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
