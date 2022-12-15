import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetButtonSimple extends StatelessWidget {
  const WidgetButtonSimple({
    Key? key,
    this.lable,
    this.icon,
    this.color,
    this.press,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String? lable;
  final IconData? icon;
  final Color? color;
  final Function()? press;
  final Color? textColor;

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
        lable!,
        style: GoogleFonts.sriracha(
            fontSize: size.height * 0.02, color: textColor, letterSpacing: 3),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: color),
    );
  }
}
