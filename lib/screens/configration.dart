import 'package:flutter/material.dart';
import 'package:motplay/utils/mycolors.dart';

import '../utils/custom_drawer.dart';

class Configration extends StatelessWidget {
  const Configration({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    //final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    //final subheading = screenWidth * 0.07 * textScaleFactor;
    //final heading = screenWidth * 0.14 * textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: Text(
          "Configuracion",
          style: TextStyle(fontSize: 32),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade200),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50)),
                height: screenHeight * 0.07,
                width: screenWidth / 2,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/cp.png',
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      "Limpiar Cache",
                      style: TextStyle(fontSize: 27),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50)),
                height: screenHeight * 0.07,
                width: screenWidth / 2,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/moon.png',
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      "Modo Oscuro",
                      style: TextStyle(fontSize: 27),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50)),
                height: screenHeight * 0.07,
                width: screenWidth / 2,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/sun.png',
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      "Modo de Luz",
                      style: TextStyle(fontSize: 27),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
