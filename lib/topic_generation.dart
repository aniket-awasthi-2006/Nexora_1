import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'dart:async';



void main() {
  runApp(const TopicGenScreen());
}

class TopicGenScreen extends StatefulWidget {
  const TopicGenScreen({super.key});
  @override
  State<TopicGenScreen> createState() => _TopicGenScreenState();
}

class _TopicGenScreenState extends State<TopicGenScreen> {
  final _genKey = GlobalKey<FormState>();
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _response = '';
  bool _loading = false;
  late OpenAI _openAI;


  @override
  void initState() {
    super.initState();
     _openAI = OpenAI.instance.build(
      token: "",
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 30)),
      enableLog: true,
    );
  }


  Future<void> generateFlashcards() async {
    final topic = _topicController.text;
    final description = _descriptionController.text;

    if (topic.isEmpty || description.isEmpty) return;

    setState(() {
      _loading = true;
      _response = '';
    });


    final request = ChatCompleteText(
      model:GptTurbo1106Model(),
      messages:[
        Map.of({
          "role": "user",
          "content": """
Generate 30 flashcard-style questions (question + answer(50-70 words)) based on the following topic and description:

Topic: $topic
Description: $description

Format:
1. Question?
Answer: ...
2. ...
"""
        })
      ],
      maxToken: 3000,
      temperature: 0.7,
    );

    try {
      final result = await _openAI.onChatCompletion(request: request);
      final content = result?.choices.first.message?.content ?? 'No response';
      setState(() {
        _response = content;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
        _loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: SafeArea(
        top: false,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          alignment: Alignment.topCenter,
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Form(
                key: _genKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/topic_gen_logo.png',
                      alignment: Alignment.center,
                      height: 250,
                      width: 250,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _topicController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Topic',
                        labelStyle: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                        ),
                        hintText: 'Enter your Topic ...',
                        hintStyle: const TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Topic ...';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      maxLines: null,
                      controller: _descriptionController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Description ...',
                        labelStyle: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                        ),
                        hintText: 'Enter some Description about your Topic ...',
                        hintStyle: const TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter some Description about your Topic ...';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      onPressed:_loading ? null : generateFlashcards
                      ,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 40, 40, 40),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              CupertinoIcons.wand_stars,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                             'Generate',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                   ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SelectableText(_response)
            
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
