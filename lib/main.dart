// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motplay/screens/dashboard.dart';
import 'package:motplay/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moto Play',
      theme: ThemeData(
        fontFamily: GoogleFonts.teko().fontFamily,
        //pri
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      routes: {
        Dashboard.routeName: (ctx) => const Dashboard(),
      },
    );
  }
}
