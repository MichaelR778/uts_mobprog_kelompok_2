import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/pages/edit_profile.dart';
import 'package:uts_mobprog_kelompok_2/pages/login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String phone = '';
  String birthDate = '';
  String gender = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      phone = prefs.getString('phone') ?? '';
      birthDate = prefs.getString('birthDate') ?? '';
      gender = prefs.getString('gender') ?? '';
    });
  }

  Future<void> _logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn');
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: color6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nomor Telepon',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  phone,
                  style: const TextStyle(
                    fontSize: 16,
                    color: color6,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Jenis Kelamin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  gender,
                  style: const TextStyle(
                    fontSize: 16,
                    color: color6,
                  ),
                ),
                const Text(
                  'Tanggal Lahir',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  birthDate,
                  style: const TextStyle(
                    fontSize: 16,
                    color: color6,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Add logout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color3,
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfilePage()),
          );
        },
        backgroundColor: color3,
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}