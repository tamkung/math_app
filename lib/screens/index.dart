import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            bottom: size.height * 0.23,
            right: size.width * 0.24,
            child: CircleAvatar(
              radius: size.width * 0.05,
              backgroundColor: pColor,
            ),
          ),
          Positioned(
            top: size.height * -0.05,
            right: size.width * -0.22,
            child: CircleAvatar(
              radius: size.width * 0.25,
              backgroundColor: pColor,
              child: CircleAvatar(
                radius: size.width * 0.18,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.18,
            left: size.width * -0.1,
            child: CircleAvatar(
              radius: size.width * 0.1,
              backgroundColor: Color(0XFFEAEBEF),
            ),
          ),
          Positioned(
            bottom: size.height * -0.17,
            left: size.height * -0.17,
            child: CircleAvatar(
              backgroundColor: Color(0XFFEAEBEF),
              radius: size.width * 0.35,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: size.width * 0.26,
                child: CircleAvatar(
                  backgroundColor: pColor,
                  radius: size.width * 0.1,
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/index-logo.png',
              width: size.width * 0.42,
              height: size.height * 0.42,
            ),
          )
        ],
      ),
    );
  }
}
