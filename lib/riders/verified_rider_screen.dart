import 'package:admin_web_cafe/main_sceen/home_screen.dart';
import 'package:admin_web_cafe/widgets/widget_button_simple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/simple_appbar.dart';

class VerifiedRidersScreen extends StatefulWidget {
  const VerifiedRidersScreen({Key? key}) : super(key: key);

  @override
  State<VerifiedRidersScreen> createState() => _VerifiedRidersScreenState();
}

class _VerifiedRidersScreenState extends State<VerifiedRidersScreen> {
  QuerySnapshot? allRiders;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('riders')
        .where('status', isEqualTo: "approved")
        .get()
        .then((verifiedRiders) {
      setState(() {
        allRiders = verifiedRiders;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'All Verified Riders Accounts'),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: displayVerfiedRidersDesign(),
        ),
      ),
    );
  }

  displayDialogBoxForBockingAccout(userDocumentId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Block Account',
              style: GoogleFonts.sriracha(
                  fontSize: 20, letterSpacing: 2, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Do you want to Block this Account',
              style: GoogleFonts.sriracha(
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> userDataMap = {'status': 'not approved'};
                  FirebaseFirestore.instance
                      .collection('riders')
                      .doc(userDocumentId)
                      .update(userDataMap)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                    SnackBar snackBar = SnackBar(
                      content: Text(
                        'Block Succeddfully. ',
                        style: GoogleFonts.sriracha(
                            fontSize: 24, color: Colors.white),
                      ),
                      backgroundColor: Colors.cyan,
                      duration: const Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }

  Widget displayVerfiedRidersDesign() {
    if (allRiders != null) {
      return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allRiders!.docs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                allRiders!.docs[index].get('riderImage'),
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(
                        allRiders!.docs[index].get('riderName'),
                        style: GoogleFonts.sriracha(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            allRiders!.docs[index].get('riderEmail'),
                            style: GoogleFonts.sriracha(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: WidgetButtonSimple(
                      press: () {
                        SnackBar snackBar = SnackBar(
                          content: Text(
                            'Total Earnings  '.toUpperCase() +
                                allRiders!.docs[index]
                                    .get('earnings')
                                    .toString() +
                                ' ฿.',
                            style: GoogleFonts.sriracha(
                                fontSize: 24, color: Colors.white),
                          ),
                          backgroundColor: Colors.cyan,
                          duration: const Duration(seconds: 6),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      lable: 'Total Earnings  '.toUpperCase() +
                          allRiders!.docs[index].get('earnings').toString() +
                          ' ฿.',
                      color: Colors.white,
                      textColor: Colors.teal,
                      icon: Icons.person_pin_sharp,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: WidgetButtonSimple(
                      press: () {
                        displayDialogBoxForBockingAccout(
                            allRiders!.docs[index].id);
                      },
                      lable: 'Block this Account'.toUpperCase(),
                      color: Colors.redAccent.shade700,
                      icon: Icons.person_pin_sharp,
                    ),
                  )
                ],
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        'No Record Found.',
        style: GoogleFonts.sriracha(
          fontSize: 25,
        ),
      ));
    }
  }
}
