// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motplay/screens/blocflutter.dart';
import 'package:motplay/screens/blogscreentest.dart';
import 'package:motplay/screens/dashboard.dart';
import 'package:motplay/screens/exoplyertestapp.dart';
import 'package:motplay/screens/splash_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BlogProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Moto Play',
          theme: ThemeData(
            fontFamily: GoogleFonts.teko().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: Dashboard(),
          routes: {
            Dashboard.routeName: (ctx) => const Dashboard(),
          },
        ));
  }
}
