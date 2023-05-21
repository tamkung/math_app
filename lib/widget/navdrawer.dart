// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_app/config/constant.dart';
import 'package:math_app/screens/login/login.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    var size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.65,
      child: ListView(
        padding: EdgeInsets.only(left: 10),
        children: <Widget>[
          heightBox(size.height * 0.1),
          ExpansionTile(
            collapsedBackgroundColor: pColor,
            collapsedTextColor: Colors.white,
            collapsedIconColor: Colors.white,
            textColor: pColor,
            iconColor: pColor,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            childrenPadding: EdgeInsets.only(left: 50),
            title: Row(
              children: [
                Icon(Icons.menu_book),
                widthBox(size.width * 0.04),
                Text(
                  'หน่วยการเรียน',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            children: [
              ListTile(
                  title: txt('บทเรียน'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, 'Home');
                  }),
              ListTile(
                title: txt('ผลทดสอบ'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'LessonProgress');
                },
              ),
            ],
          ),
          heightBox(size.height * 0.02),
          ExpansionTile(
            collapsedBackgroundColor: pColor,
            collapsedTextColor: Colors.white,
            collapsedIconColor: Colors.white,
            textColor: pColor,
            iconColor: pColor,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            childrenPadding: EdgeInsets.only(left: 50),
            title: Row(
              children: [
                Icon(
                  Icons.gamepad,
                ),
                widthBox(size.width * 0.04),
                txt('เกม')
              ],
            ),
            children: [
              ListTile(
                title: txt('เล่นเกม'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'Games');
                },
              ),
              ListTile(
                title: txt('ผลคะแนน'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'GameProgress');
                },
              ),
            ],
          ),
          heightBox(size.height * 0.01),
          ListTile(
            title: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.person_2_outlined,
                  ),
                  widthBox(size.width * 0.04),
                  txt('ประวัติ')
                ],
              ),
            ),
            onTap: () => Navigator.pushNamed(context, 'Profile'),
          ),
          heightBox(size.height * 0.01),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.logout,
                ),
                widthBox(size.width * 0.04),
                Text(
                  'ออกจากระบบ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              print(box.getValues());
              box.erase();
              box.write('isLogin', false);
              //Navigator.pushNamed(context, 'Login');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                  ModalRoute.withName('Login'));
            },
          ),
        ],
      ),
    );
  }
}

Widget txt(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}
