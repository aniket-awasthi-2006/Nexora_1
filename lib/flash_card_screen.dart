import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'flash_card_item.dart';

class FlashcardScreen extends StatefulWidget {
  final String? topic;
  final String? description;
  final String? fileAdd;

  const FlashcardScreen({
    super.key,
    this.topic,
    this.description,
    this.fileAdd,
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  @override
  void initState() {
    super.initState();
  }

  readJsonFile() async {
    final file = File(widget.fileAdd ?? '');
    String contents = await file.readAsString();
    final data = jsonDecode(contents);
    return data['flashcards'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.topic ?? 'Flashcards',
                style: const TextStyle(
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.description ?? 'No description available',
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 30),
              FutureBuilder<dynamic>(
                future: readJsonFile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No flashcards available');
                  } else {
                    final flashcards = snapshot.data!;
                    return Expanded(
                      
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
                        scrollDirection: Axis.vertical,
                        itemExtent: MediaQuery.of(context).size.height * 0.7,
                        itemCount: flashcards.length,
                        shrinkWrap: true, 
                        itemBuilder: (context, index) {
                        
                          final flashcard = flashcards[index];
                          return FlashCardItem(
                            question: flashcard['question'] ?? 'No question',
                            answer: flashcard['answer'] ?? 'No answer',
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
