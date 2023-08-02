import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:motplay/screens/dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(0, 87, 150, 1),
            Color.fromRGBO(255, 107, 0, 1)
          ])
        ),
        child: AnimatedSplashScreen(
          splash: Text("MOTO PLAY"),
          nextScreen: Dashboard() ),
      )
    );
  }
}