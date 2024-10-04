import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final TextEditingController _oldPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _changePin() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      String registeredPin = prefs.getString('pin') ?? '';

      if (_oldPinController.text != registeredPin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN Tidak Sesuai!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_newPinController.text == _confirmPinController.text) {
        await prefs.setString('pin', _newPinController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN Berhasil Diubah!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN Tidak Sesuai!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color9,
      appBar: AppBar(
        title: const Text('Ganti PIN', 
          style: TextStyle(
            color: color9,
          ),
        ),
        backgroundColor: color1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _oldPinController,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'PIN Lama',
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
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'PIN Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newPinController,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'PIN Baru',
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
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'PIN Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPinController,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi PIN',
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
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi PIN Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: color2,
                  ),
                  onPressed: _changePin,
                  child: const Text(
                    'Ubah PIN',
                    style: TextStyle(
                      fontSize: 20,
                      color: color9,
                    ),
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
