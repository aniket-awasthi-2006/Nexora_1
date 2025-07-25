//import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nexora_flashcard_app/doc_generation.dart';
import 'package:nexora_flashcard_app/flash_card_screen.dart';
import 'package:nexora_flashcard_app/profile_screen.dart';
import 'package:nexora_flashcard_app/flashcard_storage.dart';
import 'package:nexora_flashcard_app/sharing_screen.dart';

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

  Future<void> deleteJsonFile(String filepath) async {
    try{
    final file = File(filepath);
    await file.delete();
    } catch (e) {
      print("Error deleting file: $e");
    }
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
                          return Center(
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
                          spacing: 5,
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
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (
                                              context,
                                              animation,
                                              secAnimation,
                                            ) => FlashcardScreen(
                                              topic: topic,
                                              description: description,
                                              fileAdd: fileAdd,
                                            ),
                                        transitionDuration: Duration(
                                          seconds: 1,
                                        ),
                                        transitionsBuilder: (
                                          context,
                                          animation,
                                          secAnimation,
                                          child,
                                        ) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(0.0, -1.0),
                                              end: const Offset(0.0, 0.0),
                                            ).animate(animation),
                                            child: child,
                                          );
                                        },
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
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(15, 15, 25, 15),
                                        height: 160,
                                        width: double.maxFinite,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
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
                                              logos[snapshot.data!.indexOf(
                                                    set,
                                                  ) %
                                                  logos.length],
                                              height: 100,
                                              width: 80,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            150,
                                                            150,
                                                            150,
                                                          ),
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    set['description'] ?? '',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            130,
                                                            130,
                                                            130,
                                                          ),
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top:2,
                                        right: 0,    
                                        child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              
              actions: [
                SizedBox(height: 15,),
                TextButton(
                  onPressed: () {
                    deleteJsonFile(set['fileAdd']).then((_) {
                      setState(() {
                        _flashcardSummaries = FlashcardStorage().getAllFlashcardSummaries();
                      });
                      Navigator.of(context).pop();
                    });
                  },
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 20,
                  
                    children: [
                    Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 180, 0, 0),
                      size: 30,
                    ),
                    Text(
                    'Delete Cards',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 180, 0, 0),
                      fontSize: 20,
                                            
                    ),
                  ),
                    ])
                ),
                Divider(color:const Color.fromARGB(20, 0, 234, 255), thickness: 1,),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
              context,
              PageRouteBuilder(pageBuilder: (context,animation,secAnimation) => SharingScreen(), transitionDuration: Duration(milliseconds: 500), transitionsBuilder: (context,animation,secAnimation,child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );
              }),

            );
                  },
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 20,
                  
                    children: [
                    Icon(
                      Icons.share_rounded,
                      color: Color.fromARGB(255, 0, 90, 155),
                      size: 30,
                    ),
                    Text(
                    'Share Cards',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 0, 90, 155),
                      fontSize: 20,
                                            
                    ),
                  ),
                    ])
                ),
              ],
              backgroundColor: Color.fromARGB(255, 25, 25, 25),
            ),
      );

                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          padding: EdgeInsets.all(0),
                                          shape: CircleBorder(
                                            side: BorderSide(
                                              color: const Color.fromARGB(255, 50, 50, 50),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                          child: Icon(
                                          Icons.more_vert,
                                          color: const Color.fromARGB(255, 200, 200, 200),
                                          size: 25,
                                        ),
                                        ),
                                      ),
                                    ],
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
