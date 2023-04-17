import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';
import 'package:math_app/widget/navdrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      endDrawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
          ),
        ),
        toolbarHeight: 100,
        title: Column(
          children: [
            txtStyle("สวัสดี", 20),
            txtStyle("ชื่อผู้ใช้" + " นามสกุล", 15),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: pColor,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                menuContainer("รูปเลขาคณิตสองมิติและสามมิติ",
                    "assets/images/menu1.png", "Learn"),
                menuContainer(
                    "การหาพื้นที่", "assets/images/menu2.png", "Learn"),
                menuContainer(
                    "การหาปริมาตร", "assets/images/menu3.png", "Learn"),
                menuContainer(
                    "การหาพื้นที่ผิว", "assets/images/menu4.png", "Learn"),
                menuContainer(
                    "การหาความยาวรอบรูป", "assets/images/menu5.png", "Learn"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget txtStyle(String text, double size) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontSize: size,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget menuContainer(text, image, nav) {
  return TextButton(
    onPressed: () {
      // Navigator.pushNamed(context, nav);
    },
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      //color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              height: 80,
              //color: Colors.red,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              //color: Colors.green,
              child: Image.asset(
                image,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
