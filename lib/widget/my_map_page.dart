import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uts_mobprog_kelompok_2/pages/order_screen.dart';

class MyMapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  double? latitude;
  double? longitude;
  late MapController _mapController;
  bool isLoading = true;
  List<Marker> markers = [];
  LatLng? pickupLocation;
  LatLng? destinationLocation;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _requestLocationPermission();
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
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (latitude != null && longitude != null) {
          _mapController.move(LatLng(latitude!, longitude!), 13.0);
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onTap(LatLng latLng) {
    setState(() {
      if (pickupLocation == null) {
        pickupLocation = latLng;
        markers.add(
          Marker(
            point: pickupLocation!,
            width: 40,
            height: 40,
            child: Icon(Icons.location_on, color: Colors.red, size: 40), // Use child instead of builder
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pickup location set. Tap again for destination.')),
        );
      } else if (destinationLocation == null) {
        destinationLocation = latLng;
        markers.add(
          Marker(
            point: destinationLocation!,
            width: 40,
            height: 40,
            child: Icon(Icons.location_on, color: Colors.green, size: 40), // Use child instead of builder
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Destination location set. Press submit to continue.')),
        );
      }
    });
  }

  void _submitSelectedLocation() {
    if (pickupLocation != null && destinationLocation != null) {
      final pickupLat = pickupLocation!.latitude;
      final pickupLng = pickupLocation!.longitude;
      final destLat = destinationLocation!.latitude;
      final destLng = destinationLocation!.longitude;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderScreen(
            pickupLatitude: pickupLat,
            pickupLongitude: pickupLng,
            destinationLatitude: destLat,
            destinationLongitude: destLng,
          ),
        ),
      ).then((_) {
        setState(() {
          pickupLocation = null;
          destinationLocation = null;
          markers.clear();
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both pickup and destination locations before submitting.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Map')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          onTap: (tapPosition, point) {
            _onTap(point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: markers),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitSelectedLocation,
        child: Icon(Icons.check),
        tooltip: 'Submit Location',
      ),
    );
  }
}
