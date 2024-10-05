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
  DateTime? _selectedDate;
  String? _selectedGender;
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
    String birthdateString = prefs.getString('birthDate') ?? 'Tanggal Lahir belum diisi';
    _selectedDate = birthdateString != 'Tanggal Lahir belum diisi' 
        ? DateTime.parse(birthdateString) 
        : null;
    _selectedGender = prefs.getString('gender') ?? 'Jenis Kelamin belum diisi';
    setState(() {});
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      if (_selectedDate != null) {
        await prefs.setString('birthDate', _selectedDate!.toIso8601String());
      }
      if (_selectedGender != null) {
        await prefs.setString('gender', _selectedGender!);
      }
      Navigator.pop(context); // Kembali ke halaman profil setelah menyimpan
    }
  }

  Future<void> _pickBirthDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile', 
          style: TextStyle(
            color: color9,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: color9),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: color1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      backgroundColor: color9,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: color1),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color1),
                  ),
                ),
                readOnly: true,
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  prefixIcon: Icon(Icons.phone, color: color1),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color1),
                  ),
                ),
                readOnly: true,
              ),

              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickBirthDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: _selectedDate == null
                          ? 'Tanggal Lahir belum diisi'
                          : '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                      prefixIcon: const Icon(Icons.calendar_today, color: color1),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: color1),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedGender != 'Jenis Kelamin belum diisi' ? _selectedGender : null,
                items: const [
                  DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  prefixIcon: Icon(Icons.person, color: color1),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color1),
                  ),
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