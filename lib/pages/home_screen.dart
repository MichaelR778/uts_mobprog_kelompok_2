import 'package:flutter/material.dart';
import 'package:uts_mobprog_kelompok_2/components/neu_box.dart';
import 'package:uts_mobprog_kelompok_2/models/vehicle_option.dart';
import 'package:uts_mobprog_kelompok_2/pages/destinations_placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainWidget();
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
  });

  static List<VehicleOption> options = VehicleOption.getOptions();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Where would you like to go?',
            style: TextStyle(
              fontSize: 48.0,
            ),
          ),
        ),

        // Widget untuk menampilkan lokasi saat ini, ada button untuk destination
        NeuBox(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Image(
                image: NetworkImage(
                    'https://cdn.wccftech.com/wp-content/uploads/2020/08/Google-Maps.jpg'),
              ),
              Card(
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text('Search for a destination'),
                  trailing: Icon(Icons.search),
                  onTap: () {
                    // Navigate ke choose destination
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DestinationsPlaceholder(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            height: 40.0,
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Available services:',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),

        // Listview untuk service yang tersedia
        SizedBox(
          height: 150, // Membatasi height dari listview
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Scroll horizontal
            itemCount: options.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.fromLTRB(12, 12, 0, 12),
                elevation: 4,
                child: SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(options[index].icon, size: 40.0),
                      Text(options[index].name),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
