import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    this.text,
    this.icon,
    this.color,
    this.press,
  }) : super(key: key);

  final String? text;
  final IconData? icon;
  final Color? color;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton.icon(
      onPressed: press,
      icon: Icon(
        icon!,
        size: size.width * 0.016,
        color: Colors.white,
      ),
      label: Text(
        text!.toUpperCase() + '\n' + ' Accounts'.toUpperCase(),
        style: GoogleFonts.sriracha(
            fontSize: size.height * 0.02,
            color: Colors.white,
            letterSpacing: 3),
      ),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(size.width * 0.02), backgroundColor: color),
    );
  }
}
