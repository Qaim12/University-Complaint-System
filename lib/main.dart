import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypersonalproject/spalash_screen.dart';
import 'package:mypersonalproject/user_login/login.dart';
import 'package:mypersonalproject/users/screen1.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'UNIVERSITY COMPLAINT SYSTEM',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,

      ),
      home: const SplashScreen()
    );
  }
}







