import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_mobprog_kelompok_2/models/locations.dart';
import 'package:uts_mobprog_kelompok_2/models/order_provider.dart';
import 'package:uts_mobprog_kelompok_2/models/vehicle_option.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        List<VehicleOption> options = orderProvider.vehicleOptions;
        Locations location = orderProvider.locations!;

        return Scaffold(
          backgroundColor: Colors.grey[600],
          body: SafeArea(
            child: Column(
              children: [
                // Menampilkan destination di atas
                Card(
                  margin: const EdgeInsets.all(20.0),
                  child: ListTile(
                    leading: const Icon(Icons.place),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(location.pickup, style: TextStyle(fontSize: 12.0)),
                        const Divider(height: 15),
                        Text(location.destination,
                            style: TextStyle(fontSize: 12.0)),
                      ],
                    ),
                  ),
                ),

                Expanded(child: Container()),

                // Vehicle option
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  shape: const RoundedRectangleBorder(
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
                                margin: const EdgeInsets.all(10),
                                child: ListTile(
                                  leading: Icon(options[index].icon),
                                  title: Text(options[index].name),
                                  trailing: Text(
                                    'Rp ${options[index].pricePerKm * location.distanceKm}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  selected: options[index].name ==
                                      orderProvider.selectedOption.name,
                                  onTap: () {
                                    orderProvider.selectedOption =
                                        options[index];
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 100),
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
                onPressed: () {
                  orderProvider.orderOngoing = true;
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Text(
                    'Order ${orderProvider.selectedOption.name}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    'Rp ${orderProvider.selectedOption.pricePerKm * location.distanceKm}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
