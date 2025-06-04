import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexora_flashcard_app/login_screen.dart';
import 'package:nexora_flashcard_app/navigations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();

 

    Timer(Duration(seconds:3), () async {
    try {
       final prefs = await SharedPreferences.getInstance();

       if(prefs.getBool('remember_me') == true) {
   
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Navigations()));
       }
        else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
    } catch (e) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } 
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/NEXORA.png',
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
