import 'package:flutter/material.dart';
//import 'package:nexora_flashcard_app/navigations.dart';
//import 'package:nexora_flashcard_app/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nexora_flashcard_app/splash_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
  [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],);

   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Status bar
    systemNavigationBarColor: Color.fromARGB(255, 25, 25, 25), // Nav bar
    systemNavigationBarIconBrightness: Brightness.light, // Icon color
    statusBarIconBrightness: Brightness.light,
  ));

  await Firebase.initializeApp();

  await dotenv.load(fileName: ".env");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nexora",
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primaryColor: Colors.black),
      //home:LoginScreen(),
      home:SplashScreen(),
      //home:Navigations(),
      );
    
  }
}
