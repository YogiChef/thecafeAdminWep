import 'package:admin_web_cafe/main_sceen/home_screen.dart';
import 'package:admin_web_cafe/widgets/custom_textfield.dart';
import 'package:admin_web_cafe/widgets/widget_button_simple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? adminEmail;
  String? adminPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/admin.png'),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onChange: (value) {
                    adminEmail = value;
                  },
                  hintText: 'Addmin Email',
                  hintColor: Colors.grey,
                  textColor: Colors.white,
                  icon: Icons.email,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChange: (value) {
                    adminPassword = value;
                  },
                  hintText: 'Addmin Password',
                  hintColor: Colors.grey,
                  textColor: Colors.white,
                  icon: Icons.admin_panel_settings,
                  isObscure: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                WidgetButtonSimple(
                  press: () {
                    allowAdminToLogin();
                  },
                  lable: 'Login',
                  color: Colors.teal,
                  icon: Icons.person,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void allowAdminToLogin() async {
    SnackBar snackBar = SnackBar(
      content: Text(
        'Loading... ',
        style: GoogleFonts.sriracha(fontSize: 24, color: Colors.white),
      ),
      backgroundColor: Colors.cyan,
      duration: const Duration(seconds: 6),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    User? currentAdmin;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: adminEmail!,
      password: adminPassword!,
    )
        .then((fAuth) {
      currentAdmin = fAuth.user;
    }).catchError((onError) {
      final snackBar = SnackBar(
        content: Text(
          'Error Occured: ' + onError.toString(),
          style: GoogleFonts.sriracha(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if (currentAdmin != null) {
      // check if that admin record also exists in the admins colection in firestore database
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(currentAdmin!.uid)
          .get()
          .then((snap) {
        if (snap.exists) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          SnackBar snackBar = SnackBar(
            content: Text(
              'No record found,  You are not an admin. ',
              style: GoogleFonts.sriracha(fontSize: 24, color: Colors.white),
            ),
            backgroundColor: Colors.cyan,
            duration: const Duration(seconds: 6),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }
}
