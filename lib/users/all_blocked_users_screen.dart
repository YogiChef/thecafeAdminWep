import 'package:admin_web_cafe/main_sceen/home_screen.dart';
import 'package:admin_web_cafe/widgets/widget_button_simple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/simple_appbar.dart';

class AllBlockedUsersScreen extends StatefulWidget {
  const AllBlockedUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllBlockedUsersScreen> createState() => _AllBlockedUsersScreenState();
}

class _AllBlockedUsersScreenState extends State<AllBlockedUsersScreen> {
  QuerySnapshot? allUsers;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .where('status', isEqualTo: "not approved")
        .get()
        .then((verifiedUsers) {
      setState(() {
        allUsers = verifiedUsers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'All Blocked Users Accounts'),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: displayNonVerfiedUsersDesign(),
        ),
      ),
    );
  }

  displayDialogBoxForActivatingAccout(userDocumentId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Activate Account',
              style: GoogleFonts.sriracha(
                  fontSize: 20, letterSpacing: 2, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Do you want to activate this Account',
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
                  Map<String, dynamic> userDataMap = {'status': 'approved'};
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(userDocumentId)
                      .update(userDataMap)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                    SnackBar snackBar = SnackBar(
                      content: Text(
                        'Activate Succeddfully. ',
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

  Widget displayNonVerfiedUsersDesign() {
    if (allUsers != null) {
      return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allUsers!.docs.length,
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
                                allUsers!.docs[index].get('photoImage'),
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(
                        allUsers!.docs[index].get('name'),
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
                            allUsers!.docs[index].get('email'),
                            style: GoogleFonts.sriracha(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: WidgetButtonSimple(
                      press: () {
                        displayDialogBoxForActivatingAccout(
                            allUsers!.docs[index].id);
                      },
                      lable: 'Activate this Account'.toUpperCase(),
                      color: Colors.teal,
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
