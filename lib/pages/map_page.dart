import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final String pickupLocation;
  final String destinationLocation;

  const MapPage({
    super.key,
    required this.pickupLocation,
    required this.destinationLocation,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? pickupLatLng;
  LatLng? destinationLatLng;
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Locations on Map'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(-6.2088, 106.8456), 
                zoom: 13.0,
                onTap: (tapPosition, point) {
                  _onMapTap(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                if (pickupLatLng != null || destinationLatLng != null)
                  MarkerLayer(
                    markers: [
                      if (pickupLatLng != null)
                        Marker(
                          point: pickupLatLng!,
                          builder: (context) => const Icon(Icons.location_on, color: Colors.blue, size: 30),
                        ),
                      if (destinationLatLng != null)
                        Marker(
                          point: destinationLatLng!,
                          builder: (context) => const Icon(Icons.location_on, color: Colors.red, size: 30),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (pickupLatLng != null && destinationLatLng != null) {
                  Navigator.pop(
                    context,
                    {
                      'Penjemputan': pickupLatLng,
                      'Tujuan': destinationLatLng,
                    },
                  );
                } else {
                  print('Masukkan titik tujuan dan penjemputan sekaligus');
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapTap(LatLng point) {
    if (pickupLatLng == null) {
      setState(() {
        pickupLatLng = point;
      });
    } else if (destinationLatLng == null) {
      setState(() {
        destinationLatLng = point;
      });
    } else {
      setState(() {
        pickupLatLng = point;
        destinationLatLng = null;
      });
    }
  }
}
