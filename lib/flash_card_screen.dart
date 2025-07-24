import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'flash_card_item.dart';
import 'package:shake/shake.dart';
import 'package:sound_library/sound_library.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

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
  List<dynamic> flashcards = [];
  int shakeCount = 0;
  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();
    readAndSetFlashcards();

    detector = ShakeDetector.autoStart(
      onPhoneShake: (ShakeEvent event) {
        shakeCount++;
        if (shakeCount >= 2) {
          shakeCount = 0;
          shuffleFlashcards();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Flashcards shuffling!"),
              duration: Duration(seconds: 1),
            ),
          );
        }

        // Reset shake count if 2 seconds pass without 3 shakes
        Future.delayed(const Duration(seconds: 2), () {
          shakeCount = 0;
        });
      },
    );
  }

  Future<void> readAndSetFlashcards() async {
    try {
      final file = File(widget.fileAdd ?? '');
      String contents = await file.readAsString();
      final data = jsonDecode(contents);
      setState(() {
        flashcards = data['flashcards'] ?? [];
      });
    } catch (e) {
      setState(() {
        flashcards = [];
      });
      debugPrint("Error reading JSON: $e");
    }
  }

  void shuffleFlashcards() async {
    await SoundPlayer.play(Sounds.welcome, volume: 0.5);
    Vibration.vibrate(duration: 1000);
    setState(() {
      flashcards.shuffle();
    });
  }

  @override
  void dispose() {
    detector?.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
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
              flashcards.isEmpty
                  ? const CircularProgressIndicator()
                  :  Expanded(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          audioPlayer.stop();
                          audioPlayer.setAsset('assets/audio/swip.mp3');
                          audioPlayer.play();
                        },
                        physics: const ClampingScrollPhysics(),
                        controller: PageController(viewportFraction: 0.95),
                        scrollDirection: Axis.vertical,
                        itemCount: flashcards.length,
                        pageSnapping: true,
                        allowImplicitScrolling: true,
                        padEnds: false,
                        itemBuilder: (context, index) {
                          final flashcard = flashcards[index];
                          return FlashCardItem(
                            question: flashcard['question'] ?? 'No question',
                            answer: flashcard['answer'] ?? 'No answer',
                          );
                        },
                      ),
                    ),
                  
            ],
          ),
        ),
      ),
    );
  }
}
