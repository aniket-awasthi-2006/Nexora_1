import 'package:flutter/material.dart';
import 'package:nexora_flashcard_app/doc_generation.dart';
import 'package:nexora_flashcard_app/profile_screen.dart';
import 'package:nexora_flashcard_app/flashcard_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    InkWell(
                      child: CircleAvatar(
                      radius: 26,
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
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty){
              return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      height: 200,
      width: 350,
      decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: <Color>[
                                  Color.fromARGB(255, 0, 0, 0),
                                  Color.fromARGB(255, 10, 10, 10),
                                  Color.fromARGB(255, 20, 20, 20),
                                  Color.fromARGB(255, 30, 30, 30),
                                ],
                              ),
                            ),
      child: 
          Text('No Stored Cards Found !', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ,color: const Color.fromARGB(255, 140, 140, 140)))
    );
            }

            return ListView.builder(
  
  physics: NeverScrollableScrollPhysics(), // Disable internal scroll
  itemCount: snapshot.data!.length,
  itemBuilder: (context, index) {
    final set = snapshot.data![index];
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: <Color>[
                                  Color.fromARGB(255, 0, 0, 0),
                                  Color.fromARGB(255, 10, 10, 10),
                                  Color.fromARGB(255, 20, 20, 20),
                                  Color.fromARGB(255, 30, 30, 30),
                                ],
                              ),
                            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(set['topic'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ,color: const Color.fromARGB(255, 140, 140, 140))),
          SizedBox(height: 6),
          Text(set['description'] ?? '', style: TextStyle(color: const Color.fromARGB(255, 120, 120, 120))),
        ],
      ),
    );
  },
);
          },
        ),
                  ),
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}
