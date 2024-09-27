import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MyMapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  double? latitude;
  double? longitude;
  late MapController _mapController;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _requestLocationPermission(); // Request location permission on initialization
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permission permanently denied')),
      );
      return;
    }

    // Permission granted, get the current location
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        isLoading = false; // Set loading to false once location is obtained
      });

      // Use addPostFrameCallback to ensure the map is rendered before moving
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (latitude != null && longitude != null) {
          _mapController.move(LatLng(latitude!, longitude!), 13.0); // Move the map to the user's location
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
      setState(() {
        isLoading = false; // Stop loading even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Map')),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while waiting for location
          : FlutterMap(
        mapController: _mapController,
        options: MapOptions(),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(latitude!, longitude!),
                width: 40,
                height: 40,
                child: Container(
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
