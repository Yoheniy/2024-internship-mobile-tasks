import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final int? lines;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  const CustomTextField({
    super.key,
    this.lines,
    this.hint = '',
    required this.controller,
    this.validation
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color.fromARGB(255, 238, 238, 238),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
      ),
    );
  }
}
