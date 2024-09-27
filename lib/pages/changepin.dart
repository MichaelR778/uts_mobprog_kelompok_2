import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Changepin extends StatefulWidget {
  const Changepin({super.key});

  @override
  State<Changepin> createState() => ChangepinState();
}

class ChangepinState extends State<Changepin> {
  String enteredPin = ''; 
  String? newPin; 
  bool isPinVisible = false; 
  bool isConfirmingPin = false; 

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredPin.length < 6) {
              enteredPin += number.toString();
            }

            if (enteredPin.length == 6) {
              if (!isConfirmingPin) {
                newPin = enteredPin;
                enteredPin = ''; 
                isConfirmingPin = true;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Konfirmasi PIN"),
                    content: const Text("Silakan Masukkan Kembali PIN Baru Untuk Konfirmasi."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); 
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              } else {
                if (enteredPin == newPin) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Berhasil!"),
                      content: const Text("PIN Berhasil Diubah!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); 
                            Navigator.pop(context); 
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  enteredPin = ''; 
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("PIN Tidak Sesuai"),
                      content: const Text("PIN Yang Dimasukkan Tidak Sesuai. Silakan Coba Lagi."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              }
            }
          });
        },
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 50),
            
            Center(
              child: Text(
                isConfirmingPin ? 'Konfirmasi PIN Baru' : 'Masukkan PIN Baru',
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) {
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    width: isPinVisible ? 50 : 16,
                    height: isPinVisible ? 50 : 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: index < enteredPin.length
                          ? isPinVisible
                              ? Color(0xFF48CAE4)
                              : const Color(0xFF0096B7)
                          : CupertinoColors.black.withOpacity(0.3),
                    ),
                    child: isPinVisible && index < enteredPin.length
                        ? Center(
                            child: Text(
                              enteredPin[index],
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : null,
                  );
                },
              ),
            ),

            IconButton(
              onPressed: () {
                setState(() {
                  isPinVisible = !isPinVisible; 
                });
              },
              icon: Icon(
                isPinVisible ? Icons.visibility_off : Icons.visibility,
              ),
            ),

            const SizedBox(height: 40),

            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => numButton(1 + 3 * i + index),
                  ).toList(),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextButton(onPressed: null, child: SizedBox()),
                  numButton(0),
                  TextButton(
                    onPressed: () {
                      setState(
                        () {
                          if (enteredPin.isNotEmpty) {
                            enteredPin = enteredPin.substring(0, enteredPin.length - 1); 
                          }
                        },
                      );
                    },
                    child: const Icon(
                      Icons.backspace,
                      color: Colors.black,
                      size: 24,
                    ),
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
