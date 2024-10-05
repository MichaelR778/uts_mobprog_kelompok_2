import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/pages/register_screen.dart';
import 'package:uts_mobprog_kelompok_2/pages/root.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      String registeredPhone = prefs.getString('phone') ?? '';
      String registeredPin = prefs.getString('pin') ?? '';

      bool isPhoneCorrect = _phoneController.text == registeredPhone;
      bool isPinCorrect = _pinController.text == registeredPin;

      if (!prefs.containsKey('birthDate')) {
        await prefs.setString('birthDate', 'Tanggal Lahir belum diisi');
      }
      if (!prefs.containsKey('gender')) {
        await prefs.setString('gender', 'Jenis Kelamin belum diisi');
      }

      // Jika Pin dan No HP salah
      if (!isPhoneCorrect && !isPinCorrect) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nomor telepon dan PIN salah!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // jika No Telepon salah
      if (!isPhoneCorrect) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nomor telepon anda salah!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // jika PIN salah
      if (!isPinCorrect) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN anda salah!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      await prefs.setBool('isLoggedIn', true);
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
            Image.asset(
              'images/utiwi-logo.png',
              height: 150,
            ),
            const Text(
              'Selamat Datang Kembali!',
              style: TextStyle(
                  fontSize: 28, color: color1, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 3),
            const Text(
              'Silahkan masukkan nomor telepon dan PIN untuk masuk, dan klik daftar jika kamu belum mempunyai akun.',
              style: TextStyle(fontSize: 18, color: color6),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: color2,
                      ),
                      onPressed: _login,
                      child: const Text(
                        'Masuk',
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
                        'Belum memiliki akun? ',
                        style: TextStyle(
                          fontSize: 16,
                          color: color1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: const Text(
                          'Daftar',
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
