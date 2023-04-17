import 'package:flutter/material.dart';

class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: ClipPath(
          clipper: CurveClipper(), // custom clipper defining the curve
          child: AppBar(
            title: Text(
              "ประวัติ",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color.fromARGB(255, 143, 15, 15),
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            // Your body content
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Define the custom curve using a Path object
    Path path = Path();
    path.lineTo(-10, size.height - 25); // start at the bottom left
    path.quadraticBezierTo(size.width / 100, size.height, size.width,
        size.height - 0); // curve to the middle top
    path.lineTo(size.width, 0); // end at the bottom right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
