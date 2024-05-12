import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/home_page/pages/new_details_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<RealEstateModel> data;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng currentLocation;
  List<LatLng> realEstateLocations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        isLoading = false; // Set loading to false when location is fetched
      });
    } catch (e) {
      print("Error getting location: $e");
      // Handle errors here
      setState(() {
        isLoading = false; // Set loading to false in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Tabs"),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              child: FlutterMap(
            options: MapOptions(
              center: currentLocation, // Default center
              zoom: 1,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: currentLocation,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                  ...widget.data.map(
                    (realEstate) => Marker(
                      width: 40.0,
                      height: 40.0,
                      point: LatLng(realEstate.location.latitude,
                          realEstate.location.longitude),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    NewDetailsPage(realEstate: realEstate)),
                          );
                        },
                        child: const Icon(
                          Icons.home,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({
//     Key? key,
//     required this.data,
//   }) : super(key: key);
//   final Stream<List<RealEstateModel>> data;

//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late LatLng currentLocation;
//   List<LatLng> realEstateLocations = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       final Position position = await Geolocator.getCurrentPosition();
//       setState(() {
//         currentLocation = LatLng(position.latitude, position.longitude);
//         isLoading = false; // Set loading to false when location is fetched
//       });
//       _fetchRealEstateLocations(); // Fetch real estate locations after getting current location
//     } catch (e) {
//       print("Error getting location: $e");
//       // Handle errors here
//       setState(() {
//         isLoading = false; // Set loading to false in case of an error
//       });
//     }
//   }

//   Future<void> _fetchRealEstateLocations() async {
//     try {
//       widget.data.listen((List<RealEstateModel> realEstates) {
//         setState(() {
//           realEstateLocations = realEstates
//               .map((estate) => LatLng(
//                     estate.location.latitude,
//                     estate.location.longitude,
//                   ))
//               .toList();
//         });
//       });
//     } catch (e) {
//       print("Error fetching real estate locations: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: SizedBox(
//         child: MaterialButton(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           color: Colors.blue,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text("Tabs"),
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Flexible(
//             child: isLoading
//                 ? const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : FlutterMap(
//                     options: MapOptions(
//                       center: currentLocation,
//                       zoom: 1,
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate:
//                             "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                         subdomains: const ['a', 'b', 'c'],
//                       ),
//                       MarkerLayer(
//                         markers: [
//                           Marker(
//                             width: 40.0,
//                             height: 40.0,
//                             point: currentLocation,
//                             child: const Icon(
//                               Icons.location_on,
//                               color: Colors.blue,
//                               size: 40.0,
//                             ),
//                           ),
//                           ...realEstateLocations.map(
//                             (location) => Marker(
//                               width: 40.0,
//                               height: 40.0,
//                               point: location,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   // Navigate to detail page or do something else
//                                 },
//                                 child: const Icon(
//                                   Icons.home,
//                                   color: Colors.red,
//                                   size: 40.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
