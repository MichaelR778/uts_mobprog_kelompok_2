import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_mobprog_kelompok_2/models/order_provider.dart';
import 'package:uts_mobprog_kelompok_2/pages/root.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => OrderProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utiwi',
      theme: ThemeData(fontFamily: 'Handjet'),
      home: Root(),
      debugShowCheckedModeBanner: false,
    );
  }
}
