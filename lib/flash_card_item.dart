import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nexora_flashcard_app/answer_checker_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';



class FlashCardItem extends StatefulWidget {
  final String question;
  final String answer;

  const FlashCardItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FlashCardItem> createState() => _FlashCardItemState();
}

class _FlashCardItemState extends State<FlashCardItem> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    setupTts();
  }

  Future<void> setupTts() async {
    await flutterTts.setLanguage("en-US"); // change based on locale
    await flutterTts.setSpeechRate(0.5); // slower speed for clarity
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> textSpeak(String text) async {
    await flutterTts.stop(); // stop any previous speech
    await flutterTts.speak(text);
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          front: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -10) {
            
            Navigator.push(
              context,
              PageRouteBuilder(pageBuilder: (context,animation,secAnimation) => AnswerCheckerScreen(), transitionDuration: Duration(milliseconds: 500), transitionsBuilder: (context,animation,secAnimation,child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );
              }),

            );
          }
          if (details.delta.dx > 10) {
      
          }
        },
        child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 0, 0, 0),
                  const Color.fromARGB(255, 30, 82, 100),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.volume_up,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => textSpeak(widget.question),
                ),
                Center(
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 180, 180, 180),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      
                    ),
                    softWrap: true,
                    maxLines: 12,
                  ),
                ),
              ],
            ),
          ),),
          back: Container(
            margin: const EdgeInsets.fromLTRB(10, 50, 10, 50),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 0, 0, 0),
                  const Color.fromARGB(255, 60, 100, 30),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              
              children: [
                Container(
                alignment: Alignment.topLeft,
                child :IconButton(
                  icon: const Icon(
                    Icons.volume_up,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => textSpeak(widget.answer),
                ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    widget.answer,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 180, 180, 180),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                    maxLines: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
