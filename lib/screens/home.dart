import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';
import 'package:math_app/screens/learning/lesson.dart';
import 'package:math_app/widget/navdrawer.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _items = [];
  List _items2 = [];
  List _image = [
    'assets/images/menu1.png',
    'assets/images/menu2.png',
    'assets/images/menu3.png',
    'assets/images/menu4.png',
    'assets/images/menu5.png'
  ];
  bool chk = false;
  dynamic txt_id, txt_title, txt_course_id, txt_order;
  GetStorage box = GetStorage();

  dynamic u_id, firstname, lastname;

  Future<void> setUser() async {
    u_id = box.read('u_id');
    firstname = box.read('firstname');
    lastname = box.read('lastname');
  }

  Future<void> readSection() async {
    var url = Uri.parse('${API_URL}section');
    final response = await http.get(url);
    final data = await json.decode(utf8.decode(response.bodyBytes));

    setState(() {
      _items = data;
    });
    chk = true;
    print(_items);
  }

  @override
  void initState() {
    super.initState();
    readSection();
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: pColor,
      endDrawer: const NavDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.11),
        child: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(
              top: 68,
              left: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                txtStyle("สวัสดี", 26),
                heightBox(size.height * 0.002),
                txtStyle("$firstname " + " $lastname", 18),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              child: Container(
                height: size.height * 1,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: pColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg-home.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                alignment: Alignment.center,
                child: chk
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            txt_id = _items[index]['id'];
                            txt_title = _items[index]["title"];
                            txt_course_id = _items[index]['course_id'];
                            txt_order = _items[index]['order'];
                            return menuContainer(txt_title, _image[index],
                                txt_id, txt_course_id, context);
                          },
                        ),
                      )
                    : const Center(
                        child: Text("Loading"),
                      ),
              ),
            ),
          ],
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

Widget menuContainer(title, image, section_id, course_id, context) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LessonScreen(
            title: title.toString(),
            course_id: course_id.toString(),
            section_id: section_id.toString(),
            image_url: image.toString(),
          ),
        ),
      );
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
                title,
                style: const TextStyle(
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
