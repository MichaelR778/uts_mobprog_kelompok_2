import 'package:flutter/material.dart';
import 'package:uts_mobprog_kelompok_2/models/locations.dart';
import 'package:uts_mobprog_kelompok_2/models/vehicle_option.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.location});

  final Locations location;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<VehicleOption> options = VehicleOption.getOptions();
  int currOptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SafeArea(
        child: Column(
          children: [
            // Menampilkan destination di atas
            Card(
              margin: EdgeInsets.all(20.0),
              child: ListTile(
                leading: Icon(Icons.place),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.location.pickup,
                        style: TextStyle(fontSize: 12.0)),
                    Divider(height: 15),
                    Text(widget.location.destination,
                        style: TextStyle(fontSize: 12.0)),
                  ],
                ),
              ),
            ),

            Expanded(child: Container()),

            // Vehicle option
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              leading: Icon(options[index].icon),
                              title: Text(options[index].name),
                              trailing: Text(
                                'Rp ${options[index].pricePerKm * widget.location.distanceKm}',
                                style: TextStyle(fontSize: 14),
                              ),
                              selected: index == currOptionIndex,
                              onTap: () {
                                setState(() {
                                  currOptionIndex = index;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Button untuk order
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Theme.of(context).cardColor,
        ),
        height: 100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            onPressed: () {},
            child: ListTile(
              leading: Text(
                'Order ${options[currOptionIndex].name}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Text(
                'Rp ${options[currOptionIndex].pricePerKm * widget.location.distanceKm}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
