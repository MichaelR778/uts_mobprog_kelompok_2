import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/pages/edit_profile.dart';
import 'package:uts_mobprog_kelompok_2/pages/changepin.dart';
import 'package:uts_mobprog_kelompok_2/pages/login_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/onboarding_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/register_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/root.dart';

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
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePin() ),
                );
              },
              child: Text(
                'Ubah PIN',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Konfirmasi'),
                      content: Text('Yakin keluar dari akun? Kamu harus login kembali nanti.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ya'),
                          onPressed: () {
                            Navigator.of(context).pop(); 
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()), 
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Silakan login kembali.'),
                              ),
                            );
                          },
                        ),
                        TextButton(
                          child: Text('Tidak'),
                          onPressed: () {
                            Navigator.of(context).pop(); 
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Keluar Akun',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Konfirmasi'),
                      content: Text('Yakin hapus akun kamu?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ya'),
                          onPressed: () {
                            Navigator.of(context).pop(); 
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => OnboardingScreen()),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Akun berhasil dihapus.'),
                              ),
                            );
                          },
                        ),
                        TextButton(
                          child: Text('Tidak'),
                          onPressed: () {
                            Navigator.of(context).pop(); 
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Hapus Akun',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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