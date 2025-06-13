import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nexora_flashcard_app/topic_generation.dart';
import 'package:nexora_flashcard_app/progress_screen.dart';
import 'package:nexora_flashcard_app/home_screen.dart';

void main() {
  runApp(
    
    const MaterialApp(debugShowCheckedModeBanner: false, home: Navigations()),
  );
}

class Navigations extends StatefulWidget {
  const Navigations({super.key});
  @override
  State<Navigations> createState() => _NavigationsState();
}

class _NavigationsState extends State<Navigations> {
  int currentIndex = 1;

  final List<Widget> screens = [
    const TopicGenScreen(),
    const HomeScreen(), 
    const ProgressScreen(),
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final items = <Widget>[
       Padding(
        padding: EdgeInsets.all(8),
        child: Icon(CupertinoIcons.sparkles, size: 25, color: Colors.white),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          CupertinoIcons.collections_solid,
          size: 25,
          color: Colors.white,
        ),
      ),
     Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.leaderboard_rounded, size: 25, color: Colors.white),
      ),
      
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Container(
              color: Color.fromARGB(255, 30, 30, 30),
              child: IndexedStack(index: currentIndex, children: screens),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: isKeyboardOpen
          ? SizedBox.shrink()
          : CurvedNavigationBar(
                height: 63,
                color: const Color.fromARGB(255, 28, 28, 28),
                items: items,
                index: currentIndex,
                backgroundColor: Colors.transparent,

                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
