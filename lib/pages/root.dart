import 'package:flutter/material.dart';
import 'package:uts_mobprog_kelompok_2/pages/home_screen.dart';

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
        title: const Text('Utiwi'),
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
        HomeScreen(),
        Text('History'),
        Text('Profile'),
      ][currPageIndex],
    );
  }
}
