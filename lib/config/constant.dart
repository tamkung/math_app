import 'dart:ffi';

import 'package:flutter/material.dart';

//const API_URL = 'http://192.168.43.23:8080/api/';
const API_URL = 'https://math-app-api.cyclic.cloud/api/';

const pColor = Color(0xFF8159FB);

const sColor = Color(0xFFFF6633);

const tColor = Color(0xFF6600FF);

const bColor = Color(0xFF2D55A6);

Widget heightBox(double height) {
  return SizedBox(
    height: height,
  );
}

Widget widthBox(double width) {
  return SizedBox(
    width: width,
  );
}

void showPopUp(BuildContext context, String title, String content, double width,
    double height) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        content: Container(
          width: width,
          height: height,
          child: Image.network(
            content,
            fit: BoxFit.fill,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
