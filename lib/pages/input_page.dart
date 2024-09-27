import 'package:flutter/material.dart';
import 'map_page.dart'; 

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();

  void _navigateToMapPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(
          pickupLocation: pickupController.text,
          destinationLocation: destinationController.text,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        pickupController.text = result['Penjemputan']?.toString() ?? '';
        destinationController.text = result['Tujuan']?.toString() ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masukan Lokasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: pickupController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Titik Penjemputan',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: destinationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TItik Tujuan',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateToMapPage,
              child: const Text('Select on Map'),
            ),
          ],
        ),
      ),
    );
  }
}
