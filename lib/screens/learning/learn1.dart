import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';
import 'package:math_app/widget/navdrawer.dart';

class Learn1 extends StatefulWidget {
  const Learn1({super.key});

  @override
  State<Learn1> createState() => _Learn1State();
}

class _Learn1State extends State<Learn1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: pColor,
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg-home.png"),
                        fit: BoxFit.none,
                      ),
                    ),
                    height: 200,
                    width: 50,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    height: 167,
                    width: 370,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: pColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/bg-home.png"),
                  fit: BoxFit.fill,
                ),
              ),
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
