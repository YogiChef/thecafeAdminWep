// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.controller,
      this.icon,
      this.hintText,
      this.isObscure = false,
      this.enabled = true,
      this.keyboardType,
      this.textColor,
      this.onChange,
      this.hintColor})
      : super(key: key);
  final TextEditingController? controller;
  final IconData? icon;
  final String? hintText;
  final TextInputType? keyboardType;
  bool? isObscure;
  bool? enabled;
  final Color? textColor;

  final Function(String)? onChange;
  final Color? hintColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onChanged: onChange,
        enabled: enabled,
        controller: controller,
        obscureText: isObscure!,
        keyboardType: keyboardType,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan, width: 2)),
            prefixIcon: Icon(
              icon,
              size: size.height * 0.03,
              color: Colors.teal,
            ),
            focusColor: Theme.of(context).primaryColor,
            hintText: hintText,
            hintStyle:
                TextStyle(color: hintColor, fontSize: size.height * 0.025)),
        validator: (value) => value!.isEmpty ? 'Field con not be empty' : null,
        style: TextStyle(
          fontSize: size.height * 0.025,
          color: textColor,
        ),
      ),
    );
  }
}
