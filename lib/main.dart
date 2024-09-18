import 'package:flutter/material.dart';
import 'package:uts_mobprog_kelompok_2/pages/root.dart';
import 'package:uts_mobprog_kelompok_2/pages/change_pin.dart';

void main() {
  runApp(MaterialApp(
    home: Root(),
  ));
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key}); 
  
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo', 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), 
        useMaterial3: true, 
      ), 
      home: const change_pin(), 
    );
  }
}