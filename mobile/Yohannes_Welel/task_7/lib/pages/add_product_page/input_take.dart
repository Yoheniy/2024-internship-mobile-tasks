
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({super.key});
  
  get hint => null;
  
  get type => null;

  @override
  Widget build(BuildContext context) {

  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 0),
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 226, 226),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: const Color.fromARGB(255, 215, 212, 212))),
    child: Center(
      child: TextField(
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsetsDirectional.only(start: 4),
          hintStyle: const TextStyle(color: Color(0xffC1C1C1)),
     
        ),
      ),
    ),
  );
}
  }
