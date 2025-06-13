import 'package:flutter/material.dart';

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
  bool _showQuestion = true;

  void _flipCard() {
    setState(() {
      _showQuestion = !_showQuestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _flipCard,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            key: ValueKey(_showQuestion),
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.fromLTRB(10,50,10,50),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 0, 0, 0),
                  const Color.fromARGB(255, 41, 66, 82),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                _showQuestion ? widget.question : widget.answer,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 180, 180, 180),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                softWrap: true,    
                maxLines: 10,                     
              ),
              )
            ),
          ),
        ),
    );
  }
}
