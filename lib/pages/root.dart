import 'package:flutter/material.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/pages/history_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/home_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/profile.dart';

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
      backgroundColor: color9,
      bottomNavigationBar: Material(
        elevation: 20,
        child: NavigationBar(
          backgroundColor: color9,
          indicatorColor: color1,
          onDestinationSelected: (int index) {
            setState(() {
              currPageIndex = index;
            });
          },
          selectedIndex: currPageIndex,
          destinations: <Widget>[
            NavigationDestination(icon: Icon(Icons.home, color: currPageIndex == 0 ? color9 : color1), label: 'Beranda',),
            NavigationDestination(icon: Icon(Icons.list, color: currPageIndex == 1 ? color9 : color1), label: 'Riwayat',),
            NavigationDestination(icon: Icon(Icons.person, color: currPageIndex == 2 ? color9 : color1), label: 'Profile',),
          ],
        ),
      ),
      body: const <Widget>[
        HomeScreen(),
        HistoryTransactionScreen(),
        ProfilePage(),
      ][currPageIndex],
    );
  }
}
