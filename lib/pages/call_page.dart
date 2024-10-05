import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
  final String img =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQKhSHpsmJH6rfqlQm86pkI_2ELwxrh31Kmg&s';
  final String name = 'Jamal';

  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  String text = 'Calling...';

  void startCall() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        text = 'Ringing...';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.img),
                radius: 60.0,
              ),
              const SizedBox(height: 10.0),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 60.0),
              Text(
                text,
                style: const TextStyle(fontSize: 18.0),
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.call_end,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
