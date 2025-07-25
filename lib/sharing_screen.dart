import 'package:flutter/material.dart';

class SharingScreen extends StatefulWidget {
  const SharingScreen({super.key});

  @override
  State<SharingScreen> createState() => _SharingScreenState();
}

class _SharingScreenState extends State<SharingScreen> {
  @override

  Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(
      title: const Text('Sharing Screen'),
      backgroundColor: Colors.blue,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Share your flashcards with friends!',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement sharing functionality here
            },
            child: const Text('Share Now'),
          ),
        ],
      ),
    ),
  );
  }
}