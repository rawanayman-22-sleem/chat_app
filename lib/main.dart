import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/pages/loginpage.dart';
import 'package:chat_app/pages/regesterpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'loginpage': (context) => Loginpage(),
        'regesterpage': (context) => Regesterpage(),
        'chatpage': (context) => Chatpage(),
      },
      

      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Loginpage(),
    );
  }
}


