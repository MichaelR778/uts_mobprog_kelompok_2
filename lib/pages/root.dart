import 'package:flutter/material.dart';
import 'input_page.dart'; 

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastDrive'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currPageIndex = index;
          });
        },
        selectedIndex: currPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.list), label: 'History'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: <Widget>[
        _buildHomePage(),
        const Center(child: Text('History')),
        const Center(child: Text('Profile')),
      ][currPageIndex],
    );
  }

  Widget _buildHomePage() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InputPage(),
            ),
          );
        },
        child: const Text('GO TIWI'),
      ),
    );
  }
}
