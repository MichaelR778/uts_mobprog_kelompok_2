import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}


class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('name') ?? '';
    _emailController.text = prefs.getString('email') ?? '';
    _phoneController.text = prefs.getString('phone') ?? '';
    _birthdateController.text = prefs.getString('birthdate') ?? '';
    _genderController.text = prefs.getString('gender') ?? '';
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('phone', _phoneController.text);
      await prefs.setString('birthdate', _birthdateController.text);
      await prefs.setString('gender', _genderController.text);

      Navigator.pop(context); // Kembali ke halaman profil setelah menyimpan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: color1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.account_circle, color: color1),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: color1),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                  labelText: 'Nomor Telepon',
                  prefixIcon: Icon(Icons.phone, color: color1),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _birthdateController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                  labelText: 'Tanggal Lahir',
                  prefixIcon: Icon(Icons.calendar_today, color: color1),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                  labelText: 'Jenis Kelamin',
                  prefixIcon: Icon(Icons.person, color: color1),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color2,
                  ),
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(color: color9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
