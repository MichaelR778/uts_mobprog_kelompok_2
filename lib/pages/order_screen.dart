import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_mobprog_kelompok_2/models/locations.dart';
import 'package:uts_mobprog_kelompok_2/models/order_provider.dart';
import 'package:uts_mobprog_kelompok_2/models/vehicle_option.dart';
import 'package:uts_mobprog_kelompok_2/pages/root.dart'; // Import your onboarding screen

class OrderScreen extends StatelessWidget {
  final double pickupLatitude;
  final double pickupLongitude;
  final double destinationLatitude;
  final double destinationLongitude;

  OrderScreen({
    Key? key,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        List<VehicleOption> options = orderProvider.vehicleOptions;
        Locations location = Locations(pickup: 'lokasi 1', destination: 'lokasi 2', distanceKm: 1.0,)
        ;

        return Scaffold(
          backgroundColor: Colors.grey[600],
          body: SafeArea(
            child: Column(
              children: [
                // Displaying the pickup and destination locations
                Card(
                  margin: const EdgeInsets.all(20.0),
                  child: ListTile(
                    leading: const Icon(Icons.place),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(location.pickup, style: const TextStyle(fontSize: 12.0)),
                        const Divider(height: 15),
                        Text(location.destination, style: const TextStyle(fontSize: 12.0)),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),

                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // Vehicle options
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
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
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: options[index].name == orderProvider.selectedOption.name
                                        ? Colors.indigo
                                        : Colors.grey[300]!,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  leading: Container(
                                    margin: const EdgeInsets.all(5),
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(options[index].iconPath),
                                    ),
                                  ),
                                  title: Text(options[index].name),
                                  trailing: Text(
                                    'Rp ${options[index].pricePerKm * location.distanceKm}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  selected: options[index].name == orderProvider.selectedOption.name,
                                  onTap: () {
                                    orderProvider.selectedOption = options[index];
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

          // Button to submit order
          floatingActionButton: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              color: Theme.of(context).cardColor,
            ),
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5),
                  backgroundColor: Colors.indigo,
                ),
                onPressed: () {
                  orderProvider.orderOngoing = true;
                  Navigator.pop(
                    context,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spread the content
                  children: [
                    // Wrapping the text in Expanded to allocate remaining space
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown, // Scale down the text to avoid overflow
                        child: Text(
                          'Pesan ${orderProvider.selectedOption.name}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Adding some spacing between text and price

                    // Wrapping the price text in Expanded or Flexible
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown, // Scale down the text to avoid overflow
                        child: Text(
                          'Rp ${orderProvider.selectedOption.pricePerKm * location.distanceKm}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}

class Location {
}
