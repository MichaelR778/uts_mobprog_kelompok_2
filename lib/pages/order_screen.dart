import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/models/chat_provider.dart';
import 'package:uts_mobprog_kelompok_2/models/locations.dart';
import 'package:uts_mobprog_kelompok_2/models/order_provider.dart';
import 'package:uts_mobprog_kelompok_2/models/vehicle_option.dart';

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
        Locations location = Locations(pickup: 'Rumah', destination: 'Universitas Tarumanagara', distanceKm: 1.0,)
        ;

        return Scaffold(
          backgroundColor: Colors.grey[600],
          body: SafeArea(
            child: Column(
              children: [
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
                                        ? color1
                                        : colorGrey!,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  leading: Container(
                                    margin: const EdgeInsets.all(5),
                                    width: 50,
                                    height: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(options[index].iconPath),
                                    ),
                                  ),
                                  title: Text(options[index].name),
                                  trailing: Text(
                                    'Rp${NumberFormat('#,##0', 'id_ID').format(options[index].pricePerKm * location.distanceKm)}',
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

          floatingActionButton: Container(
            decoration: BoxDecoration(
              border: Border.all(color: colorGrey!),
              color: Theme.of(context).cardColor,
            ),
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5),
                  backgroundColor: color1,
                ),
                onPressed: () {
                  orderProvider.orderOngoing = true;
                  Provider.of<ChatProvider>(context, listen: false)
                      .clearMessage();
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown, 
                        child: Text(
                          'Pesan ${orderProvider.selectedOption.name}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color9,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), 
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Rp${NumberFormat('#,##0', 'id_ID').format(orderProvider.selectedOption.pricePerKm * location.distanceKm)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color9,
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
