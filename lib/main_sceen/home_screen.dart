import 'dart:async';

import 'package:admin_web_cafe/authentication/login_screen.dart';
import 'package:admin_web_cafe/riders/blocked_riders_screen.dart';
import 'package:admin_web_cafe/riders/verified_rider_screen.dart';
import 'package:admin_web_cafe/sellers/all_verified_sellers_screen.dart';
import 'package:admin_web_cafe/sellers/blocked_sellers_screen.dart';
import 'package:admin_web_cafe/users/verified_users_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import '../users/all_blocked_users_screen.dart';
import '../widgets/widget_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String timeText = '';
  String dateText = '';
  String formatCurrentLiveTime(DateTime time) {
    return DateFormat('hh:mm:ss a').format(time);
  }

  String formatCurrentDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  void initState() {
    super.initState();
    // time
    timeText = formatCurrentLiveTime(DateTime.now());
    // date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTime();
    });
  }

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if (mounted) {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

// flutter run -d chrome --web-renderer html
// flutter run -d edge --web-renderer html
// flutter run -d Edge --web-renderer html
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Admin Web Portal',
            style: GoogleFonts.sriracha(fontSize: size.height * 0.03),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.teal, Colors.blue],
              ),
            ),
            // child: Padding(
            //   padding: EdgeInsets.only(
            //     right: size.width * 0.03,
            //   ),
            // child: Align(
            //   alignment: Alignment.centerRight,
            //   child: Text(
            //     dateText + ' ' + timeText,
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: size.height * 0.03,
            //       letterSpacing: 3,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            // ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                timeText + '\n' + dateText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.03,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetButton(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifiedUsersScreen()));
                  },
                  text: 'All Verified users',
                  icon: Icons.person_add,
                  color: Colors.teal,
                ),
                const SizedBox(
                  width: 20,
                ),
                WidgetButton(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AllBlockedUsersScreen()));
                  },
                  text: ' All Blocked users',
                  icon: Icons.block_flipped,
                  color: Colors.pink,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetButton(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AllVerifiedSellersScreen()));
                  },
                  text: 'All Virified sellers',
                  icon: Icons.person_add,
                  color: Colors.teal,
                ),
                const SizedBox(
                  width: 20,
                ),
                WidgetButton(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BlockedSellersScreen()));
                  },
                  text: 'All block sellers',
                  icon: Icons.block_flipped,
                  color: Colors.pink,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetButton(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const VerifiedRidersScreen()));
                  },
                  text: 'All Virified riders',
                  icon: Icons.person_add,
                  color: Colors.teal,
                ),
                const SizedBox(
                  width: 20,
                ),
                WidgetButton(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BlockedRidersScreen()));
                  },
                  text: 'All block riders',
                  icon: Icons.block_flipped,
                  color: Colors.pink,
                ),
              ],
            ),
            WidgetButton(
              press: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              color: Colors.redAccent.shade700,
              text: 'Logout',
              icon: Icons.logout,
            )
          ],
        ));
  }
}
