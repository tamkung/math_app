// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Profile'),
            onTap: () => Navigator.pushNamed(context, 'Profile'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
