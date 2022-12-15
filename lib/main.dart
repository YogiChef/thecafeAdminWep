import 'package:admin_web_cafe/main_sceen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'authentication/login_screen.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Panda Clone',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginScreen()
            : const HomeScreen());
  }
}
