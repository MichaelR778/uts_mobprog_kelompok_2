import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/pages/login_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/root.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('phone', _phoneController.text);
      await prefs.setString('pin', _pinController.text);
      await prefs.setString('birthDate', 'Tanggal Lahir belum diisi');
      await prefs.setString('gender', 'Jenis Kelamin belum diisi');
      await prefs.setBool("onboarding", false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Root()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color9,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Daftar Akun',
              style: TextStyle(fontSize: 28, color: color1),
            ),
            const SizedBox(height: 3),
            const Text(
              'Untuk membuat akun, lengkapi data dirimu ya!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: color6,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      prefixIcon: Icon(Icons.account_circle, color: color1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      if (value.length < 3) {
                        return 'Nama harus minimal 3 huruf';
                      }
                      if (RegExp(r'\d').hasMatch(value)) {
                        return 'Nama tidak boleh mengandung angka';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: color1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Alamat email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    maxLength: 12,
                    decoration: const InputDecoration(
                      labelText: 'Nomor Telepon',
                      prefixText: '+62 ',
                      counterText: '',
                      prefixIcon: Icon(Icons.phone_android, color: color1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      String phoneNumber = value!.replaceFirst('+62 ', '');
                      if (value.isEmpty) {
                        return 'Nomor telepon tidak boleh kosong';
                      }
                      if (!RegExp(r'^\d{9,12}$').hasMatch(phoneNumber)) {
                        return 'Nomor telepon harus berisi 9 - 12 angka';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _pinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'PIN',
                      counterText: '',
                      prefixIcon: Icon(Icons.lock, color: color1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PIN tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Dengan mendaftar, Anda setuju dengan syarat dan ketentuan kami.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: color2,
                      ),
                      onPressed: _register,
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 20,
                          color: color9,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah memiliki akun? ',
                        style: TextStyle(
                          fontSize: 16,
                          color: color1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            color: color4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
