import 'package:admin_web_cafe/main_sceen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;

  final String title;
  SimpleAppBar({Key? key, this.bottom, required this.title}) : super(key: key);

  @override
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 18,
            // backgroundImage: NetworkImage(
            // sharedPreferences!.getString('photoUrl')!,
            // ),
          ),
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.teal,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.sriracha(
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
      ),
    );
  }
}
