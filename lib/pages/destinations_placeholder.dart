import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_mobprog_kelompok_2/models/locations.dart';
import 'package:uts_mobprog_kelompok_2/models/order_provider.dart';
import 'package:uts_mobprog_kelompok_2/pages/login_screen.dart';

class DestinationsPlaceholder extends StatelessWidget {
  const DestinationsPlaceholder({super.key});

  static List<Locations> locations = [
    Locations(
        pickup: 'pickuplocation', destination: 'Location 1', distanceKm: 1.0),
    Locations(
        pickup: 'pickuplocation', destination: 'Location 2', distanceKm: 1.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ini Page Placeholder'),
      ),
      body: Column(
        children: [
          Image(
            image: NetworkImage(
                'https://cdn.wccftech.com/wp-content/uploads/2020/08/Google-Maps.jpg'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: ListTile(
                    leading: Icon(Icons.place),
                    title: Text(locations[index].destination),
                    trailing: Text('${locations[index].distanceKm} Km'),
                    onTap: () async {
                      dynamic orderProvider =
                          Provider.of<OrderProvider>(context, listen: false);
                      orderProvider.selectedOption =
                          orderProvider.vehicleOptions[0];
                      orderProvider.locations = locations[index];
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                      if (orderProvider.orderOngoing) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
