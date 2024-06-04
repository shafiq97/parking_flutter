import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final IconData icons;
  final String lable;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  MyTextField(
      {required this.icons,
      required this.lable,
      required this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icons),
        labelText: lable,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
