import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uts_mobprog_kelompok_2/pages/order_screen.dart';

import '../models/order_provider.dart';

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

  TextEditingController _pickupController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

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
        _mapController.move(LatLng(latitude!, longitude!), 13.0);
      });
    } catch (e) {
      setState(() {
        latitude = -6.2088;
        longitude = 106.8456;
        isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.move(LatLng(latitude!, longitude!), 13.0);
      });
    }
  }

  void _onTap(LatLng latLng) {
    setState(() {
      if (pickupLocation == null) {
        pickupLocation = latLng;
        _pickupController.text = 'Rumah'; // Isi otomatis dengan "Rumah"
        markers.add(
          Marker(
            point: pickupLocation!,
            width: 40,
            height: 40,
            child: Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pickup location set to "Rumah". Tap again for destination.')),
        );
      } else if (destinationLocation == null) {
        destinationLocation = latLng;
        _destinationController.text = 'Universitas Tarumanagara'; // Isi otomatis dengan "Universitas Tarumanagara"
        markers.add(
          Marker(
            point: destinationLocation!,
            width: 40,
            height: 40,
            child: Icon(Icons.location_on, color: Colors.green, size: 40),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Destination location set to "Universitas Tarumanagara". Press submit to continue.')),
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
          _pickupController.clear();
          _destinationController.clear();
        });
        if (Provider.of<OrderProvider>(context, listen: false).orderOngoing) {
          Navigator.pop(context);
        }
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
      body: Stack(
        children: [
          isLoading
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
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                TextField(
                  controller: _pickupController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Pickup Location',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _destinationController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Destination Location',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
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
