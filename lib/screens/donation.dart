import 'package:flutter/material.dart';
import 'package:motplay/utils/mycolors.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  _DonationState createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  Color containerBorderColor1 = Colors.blue;
  Color containerBorderColor2 = Colors.blue;
  Color containerBorderColor3 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // Adjust font size based on screen width and text scale factor
    final subheading = screenWidth * 0.07 * textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Donación",
          style: TextStyle(fontSize: 32),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade200),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Image(
              fit: BoxFit.contain,
              height: screenHeight * 0.3,
              width: screenWidth,
              image: const AssetImage('assets/images/donation.png'),
            ),
            const Text(
              "Dona para las niñas a su bienestar",
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              "Fundación de caridad",
              style: TextStyle(fontSize: 32, color: Colors.blue),
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Elegir la cantidad",
                    style: TextStyle(fontSize: subheading, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        containerBorderColor1 = Colors.blue;
                        containerBorderColor2 = Colors.grey;
                        containerBorderColor3 = Colors.grey;
                      });
                    },
                    child: Container(
                      height: screenHeight / 10,
                      width: screenWidth / 4.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 1, color: containerBorderColor1),
                      ),
                      child: Center(
                        child: Text(
                          '\$5',
                          style: TextStyle(
                              fontSize: subheading,
                              color: containerBorderColor1),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        containerBorderColor1 = Colors.grey;
                        containerBorderColor2 = Colors.blue;
                        containerBorderColor3 = Colors.grey;
                      });
                    },
                    child: Container(
                      height: screenHeight / 10,
                      width: screenWidth / 4.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 1, color: containerBorderColor2),
                      ),
                      child: Center(
                        child: Text(
                          '\$10',
                          style: TextStyle(
                              fontSize: subheading,
                              color: containerBorderColor2),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        containerBorderColor1 = Colors.grey;
                        containerBorderColor2 = Colors.grey;
                        containerBorderColor3 = Colors.blue;
                      });
                    },
                    child: Container(
                      height: screenHeight / 10,
                      width: screenWidth / 4.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 1, color: containerBorderColor3),
                      ),
                      child: Center(
                        child: Text(
                          '\$50',
                          style: TextStyle(
                              fontSize: subheading,
                              color: containerBorderColor3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("O"),
                  ),
                  Expanded(child: Divider())
                ],
              ),
            ),
            Container(
              height: screenHeight / 12,
              width: screenWidth - 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(05),
              ),
              child: const Center(
                child: Text(
                  "Introducir precio manualmente",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            Center(
              child: Container(
                height: screenHeight / 12,
                width: screenWidth / 2,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Done Ahora",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
          ],
        ),
      ),
    );
  }
}
