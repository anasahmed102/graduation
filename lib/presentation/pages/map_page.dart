import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MyMapPage extends StatefulWidget {
  const MyMapPage({super.key});

  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  LatLng? _markerPosition;
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
      appBar: AppBar(
        title: const Text('Set Your Location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: currentLocation, // Initial center of the map
          zoom: 13.0, // Initial zoom level
          onTap: (tapPosition, point) {
            setState(() {
              _markerPosition = point; // Set the marker position on tap
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _markerPosition != null
                ? [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _markerPosition!,
                      child: Container(
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ]
                : [],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_markerPosition != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Location set to: ${_markerPosition!.latitude}, ${_markerPosition!.longitude}'),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
