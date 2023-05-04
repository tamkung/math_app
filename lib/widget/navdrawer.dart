// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 70,
          ),
          ListTile(
            leading: Icon(Icons.my_library_books_rounded),
            title: Text('หน่วยการเรียน'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.games_outlined),
            title: Text('Game'),
            onTap: () => {
              Navigator.pushNamed(context, 'Game'),
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Profile'),
            onTap: () => Navigator.pushNamed(context, 'Profile'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              print(box.getValues());
              box.write('isLogin', false);
              Navigator.pushNamed(context, 'Login');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('test'),
            onTap: () => Navigator.pushNamed(context, 'test'),
          ),
        ],
      ),
    );
  }
}
