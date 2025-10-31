import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final obscurdtext;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscurdtext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscurdtext,
      style: TextStyle(fontSize: 20, color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),

          // fillColor: Colors.grey[100],
          // filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70, fontSize: 18)),
    );
  }
}
