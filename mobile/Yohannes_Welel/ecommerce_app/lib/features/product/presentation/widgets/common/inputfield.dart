
import 'package:flutter/material.dart';

class InputTake extends StatelessWidget {
  const InputTake({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '',
            ),
          ),
        ),
      
      ],
    );
  }
}