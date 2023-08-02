// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motplay/screens/dashboard.dart';
import 'package:motplay/screens/motogp.dart';
import 'package:motplay/screens/newhome.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: NewHome(),
    );
  }
}
