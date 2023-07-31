import 'package:flutter/material.dart';

import '../utils/mycolors.dart';

class Donation extends StatelessWidget {
  const Donation({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    //final subheading = screenWidth * 0.07 * textScaleFactor;
    final heading = screenWidth * 0.14 * textScaleFactor;

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: blue,
        title: Text(
          "Donación",
          style: TextStyle(fontSize: 32),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade200),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Image(
            fit: BoxFit.contain,
            height: screenHeight * 0.3,
            width: screenWidth,
            image: AssetImage('assets/images/donation.png'),
          ),
          Text(
            "Dona para las niñas a su bienestar",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            "Fundación de caridad",
            style: TextStyle(fontSize: 32, color: blue),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Elegir la cantidad",
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
