//import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'package:flutter/material.dart';
import 'package:nexora_flashcard_app/doc_generation.dart';
import 'package:nexora_flashcard_app/flash_card_screen.dart';
import 'package:nexora_flashcard_app/profile_screen.dart';
import 'package:nexora_flashcard_app/flashcard_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> logos = [
    'assets/images/cardLogo1.png',
    'assets/images/cardLogo2.png',
    'assets/images/cardLogo3.png',
    'assets/images/cardLogo4.png',
  ];
  late Future<List<Map<String, dynamic>>> _flashcardSummaries;
  @override
  void initState() {
    super.initState();
    _flashcardSummaries = FlashcardStorage().getAllFlashcardSummaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: SafeArea(
        top: false,
        child: Container(
          color: Color.fromARGB(255, 20, 20, 20),
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 10,
                right: 10,
                child: Row(
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
                        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
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
                    Spacer(),
                    InkWell(
                      child: CircleAvatar(
                        radius: 26,
                        backgroundImage: AssetImage(
                          'assets/images/profile_default.jpg',
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 30),
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      5,
                      20,
                      5,
                      80,
                    ), // bottom padding for overlap

                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _flashcardSummaries,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(16),
                            height: 200,
                            width: double.maxFinite,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: <Color>[
                                  Color.fromARGB(255, 50, 50, 50),
                                  Color.fromARGB(255, 30, 30, 30),
                                  Color.fromARGB(255, 40, 40, 40),
                                  Color.fromARGB(255, 50, 50, 50),
                                ],
                              ),
                            ),
                            child: Text(
                              'No Stored Cards Found !',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 140, 140, 140),
                              ),
                            ),
                          );
                        }

                        return Column(
                          spacing: 20,
                          children:
                              snapshot.data!.map((set) {
                                return ElevatedButton(
                                  onPressed: () {
                                    final String fileAdd = set['fileAdd'] ?? '';
                                    final String topic = set['topic'] ?? '';
                                    final String description =
                                        set['description'] ?? '';
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => FlashcardScreen(
                                              topic: topic,
                                              description: description,
                                              fileAdd: fileAdd,
                                            ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    padding:
                                        EdgeInsets
                                            .zero, // Remove default padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    height: 200,
                                    width: double.maxFinite,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: <Color>[
                                          Color.fromARGB(255, 10, 10, 10),
                                          Color.fromARGB(255, 20, 20, 20),
                                          Color.fromARGB(255, 30, 30, 30),
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      spacing: 30,
                                      children: [
                                        Image.asset(
                                          logos[snapshot.data!.indexOf(set) %
                                              logos.length],
                                          height: 120,
                                          width: 100,
                                        ),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: [
                                              Text(
                                                set['topic'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                    255,
                                                    150,
                                                    150,
                                                    150,
                                                  ),
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                set['description'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromARGB(
                                                    255,
                                                    130,
                                                    130,
                                                    130,
                                                  ),
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                        );
                      },
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
