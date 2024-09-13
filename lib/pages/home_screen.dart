import 'package:flutter/material.dart';
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
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Text(
            'Where would you like to go?',
            style: TextStyle(
              fontSize: 48.0,
            ),
          ),

          // Widget untuk menampilkan lokasi saat ini, ada button untuk destination
          Card(
            color: Colors.indigo,
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

          Divider(
            height: 40.0,
          ),
          Text(
            'Available services:',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),

          // Listview untuk service yang tersedia
          SizedBox(
            height: 175, // Membatasi height dari listview
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontal
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  child: SizedBox(
                    width: 175,
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
      ),
    );
  }
}
