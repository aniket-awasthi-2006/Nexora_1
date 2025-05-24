import 'package:flutter/material.dart';
import 'package:nexora_flashcard_app/doc_generation.dart';
import 'package:nexora_flashcard_app/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      body: SafeArea(
        top: false,
        child: Container(
          color: Color.fromARGB(255, 30, 30, 30),
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 10,
                child: Row(
                  spacing: 80,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DocGenScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 36,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        '+ New Deck',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        'assets/images/profile_default.jpg'
                      ),
                    ),
                    onTap: (){
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                    },
                    )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 30),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        Color.fromARGB(100, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      5,
                      40,
                      5,
                      80,
                    ), // bottom padding for overlap
                    child: Column(
                      children: List.generate(
                        50,
                        (index) => ListTile(
                          title: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: <Color>[
                                  Color.fromARGB(255, 0, 0, 0),
                                  Color.fromARGB(255, 20, 20, 20),
                                  Color.fromARGB(255, 30, 30, 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
