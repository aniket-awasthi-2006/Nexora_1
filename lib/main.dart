import 'package:flutter/material.dart';
import 'package:nexora_flashcard_app/navigations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



void main() async{
  await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Status bar
    systemNavigationBarColor: Color.fromARGB(255, 25, 25, 25), // Nav bar
    systemNavigationBarIconBrightness: Brightness.light, // Icon color
    statusBarIconBrightness: Brightness.light,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
  [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],);
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
      home:Navigations(),
      );
    
  }
}
