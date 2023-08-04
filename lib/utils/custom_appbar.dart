// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:motplay/utils/mycolors.dart';
class CustomAppBar extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> globalKey;
  const CustomAppBar({super.key, required this.title, required this.globalKey});

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
              IconButton(onPressed: (){
                globalKey.currentState?.openDrawer();
              }, icon: Icon(Icons.menu_rounded, size: 45, color: gradBlue,)),
              Text(title, style: TextStyle(fontSize: 20),),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back_outlined, size: 25, color: gradBlue,) )),
                ),
              )
            ],
          ),
        );
  }
}