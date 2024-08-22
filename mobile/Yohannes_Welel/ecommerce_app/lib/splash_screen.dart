import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    Timer(Duration(seconds: 4), (){
      Navigator.pushNamed(context, '/signin_page');
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              // color: Color.fromARGB(63, 81, 243, 1),
              image: DecorationImage(
                image: AssetImage('assets/cc185ce21c0977048c188a93caf4ffe2.png'), // Your image path
                fit: BoxFit.cover, // Make the image cover the entire screen
              ),
            ),
          ),
          // Centered text
           Positioned(
            top: 279,
            left: 63,
            child: Container(
              width: 264,
              height: 121,
              
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(31))
              ),

              child: const Center(
                child: Text(
                  'ECOM',
                  style: TextStyle(
                 

                    fontSize: 75.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  
                    color: Color.fromARGB(255, 28, 5, 232), // Text color
                  ),
                ),
              ),
            ),
          ),
          const Positioned( 
            top: 426,
            height: 38,
            width: 400,
            child: Center(
              child: Text(
                    'ECOMMERCE APP',
                    style: TextStyle(
                   
              
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    
                      color: Color.fromARGB(255, 239, 239, 243), // Text color
                    ),
                  ),
            ),
            )
        ],
      ),
    );
  }
}
