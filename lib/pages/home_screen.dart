import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_mobprog_kelompok_2/models/order_provider.dart';
import 'package:uts_mobprog_kelompok_2/models/vehicle_option.dart';
import 'package:uts_mobprog_kelompok_2/pages/call_page.dart';
import 'package:uts_mobprog_kelompok_2/pages/chat_page.dart';
import 'package:uts_mobprog_kelompok_2/pages/my_map_page.dart';

import '../widget/mini_map.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        if (!orderProvider.orderOngoing) {
        }

        return Scaffold(
          body: orderProvider.orderOngoing
              ? const OrderWidget()
              : HomeWidget(options: orderProvider.vehicleOptions),
        );
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.options,
  });

  final List<VehicleOption> options;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Stack(
            children: [
              Image.asset('images/home_img.png'),
              Column(
                children: [
                  const SizedBox(height: 125),
                  Stack(
                    children: [
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(20),
                        color: Colors.indigo[300],
                        child: Container(height: 200),
                      ),
                      Card(
                        elevation: 0,
                        margin: const EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text(
                                  'Tempat Tujuan',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('Mau kemana nih?'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  title: const Text('Cari tempat tujuan'),
                                  trailing: const Icon(Icons.search),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MyMapPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const ListTile(
                            title: Text(
                              'Pilih sesuai kebutuhan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text('Layanan yang tersedia:'),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.1,
                            ),
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(options[index].iconPath),
                                    ),
                                  ),
                                  Text(
                                    options[index].name,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return SafeArea(
      child: ListView(
        children: [
          Stack(
            children: [
              Image.asset('images/home_order_img.jpg'),
              Column(
                children: [
                  const SizedBox(height: 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipOval(
                            child: Image.asset(orderProvider.selectedOption.iconPath),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Driver',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Sedang dalam perjalanan'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 125,
                          child: MiniMap(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'B1234OK',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton.filled(
                                    onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CallPage(),
                                      ),
                                    );
                                  },
                                    icon: const Icon(Icons.phone),
                                  ),
                                  IconButton.filled(
                                    onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ChatPage(),
                                      ),
                                    );
                                  },
                                    icon: const Icon(Icons.chat),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Expanded(child: Text('Lokasi pick-up :')),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      orderProvider.locations?.pickup ?? 'Rumah',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Expanded(child: Text('Tujuan :')),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      orderProvider.locations?.destination ?? 'Universitas Tarumanagara',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      orderProvider.selectedOption.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Rp ${orderProvider.selectedOption.pricePerKm * (orderProvider.locations?.distanceKm ?? 2)}',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FilledButton(
                                    onPressed: () {
                                      Provider.of<OrderProvider>(context, listen: false).orderOngoing = false;
                                    },
                                    child: const Text('Batalkan pesanan'),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      Provider.of<OrderProvider>(context, listen: false).orderOngoing = false;
                                    },
                                    child: const Text('Pesanan selesai'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
