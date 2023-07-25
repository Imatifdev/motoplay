import 'package:flutter/material.dart';

import '../utils/mycolors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

int selectedButton = 1;

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    final subheading = screenWidth * 0.07 * textScaleFactor;
    final heading = screenWidth * 0.14 * textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(),
      body: Column(children: [
        Container(
          width: screenWidth,
          height: screenHeight * 0.11,
          decoration: BoxDecoration(color: blue, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(0, 3), // Horizontal and vertical offset
            ),
          ]),
          child: Column(
            children: [
              Text(
                "MOTOPLAY",
                style: TextStyle(fontSize: heading, color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Container(
          width: screenWidth,
          height: screenHeight * 0.03,
          decoration: BoxDecoration(color: blue, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(0, 3), // Horizontal and vertical offset
            ),
          ]),
          child: Column(
            children: [],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedButton = 1;
                });
              },
              child: Text('Button 1'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedButton = 2;
                });
              },
              child: Text('Button 2'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedButton = 3;
                });
              },
              child: Text('Button 3'),
            ),
          ],
        ),
      ]),
    );
  }
}
