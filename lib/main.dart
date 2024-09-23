import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_mobprog_kelompok_2/models/order_provider.dart';
import 'package:uts_mobprog_kelompok_2/pages/login_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => OrderProvider(),
      child: MyApp(onboarding: onboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, required this.onboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Utiwi',
      theme: ThemeData(fontFamily: 'Handjet'),
      home: onboarding ? const LoginScreen() : const OnboardingScreen(),
    );
  }
}
