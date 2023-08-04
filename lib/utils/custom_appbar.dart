// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:motplay/utils/mycolors.dart';
class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
            width: size.width,
            height: size.width/2.3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/appbar_white.png"))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.menu_rounded, size: 45, color: gradBlue,)),
              Text(title, style: TextStyle(fontSize: 20),),
              CircleAvatar(child: IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back_outlined, size: 25, color: gradBlue,) ))
            ],
          ),
        );
  }
}