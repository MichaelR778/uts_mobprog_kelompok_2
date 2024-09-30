import 'package:flutter/material.dart';
import 'package:uts_mobprog_kelompok_2/pages/changepin.dart';
import 'package:uts_mobprog_kelompok_2/pages/root.dart';

class ProfilePage extends StatelessWidget {
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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pengguna',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Username Here',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(thickness: 3),
            SizedBox(height: 10),
            Text(
              'No Telepon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '08123456789',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Jenis Kelamin',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Laki-laki',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tanggal Lahir',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '01 Januari 1990',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Changepin() ),
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
                      content: Text('Apa Anda Yakin Keluar Akun? Anda Harus Login Kembali.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ya'),
                          onPressed: () {
                            Navigator.of(context).pop(); 
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Root()), 
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Silakan Login Kembali.'),
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
                      content: Text('Apakah Anda yakin ingin menghapus akun? Semua data dan riwayat Anda akan hilang.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ya'),
                          onPressed: () {
                            Navigator.of(context).pop(); 
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Root()),
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
    );
  }
}
