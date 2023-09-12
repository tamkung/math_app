import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_app/config/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../widget/navdrawer.dart';
import '../home.dart';

class GameProgressScreen extends StatefulWidget {
  const GameProgressScreen({super.key});

  @override
  State<GameProgressScreen> createState() => _GameProgressScreenState();
}

class _GameProgressScreenState extends State<GameProgressScreen> {
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
  String? API_URL = dotenv.env['API_URL'];

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
        preferredSize: Size.fromHeight(size.height * 0.21),
        child: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 20,
                  right: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30, left: 20),
                      child: Text(
                        'ผลคะแนน',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    widthBox(size.width * 0.02),
                    Image.asset(
                      'assets/images/score-progress.png',
                      width: size.width * 0.40,
                      height: size.height * 0.2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: pColor,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const HomeScreen(),
                    ),
                    ModalRoute.withName('Home'),
                  );
                },
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(
                30,
              ),
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
                color: Colors.white,
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              child: Container(
                height: size.height * 0.8,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: pColor,
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg-home.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                alignment: Alignment.center,
                child: chk
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            txt_id = _items[index]['id'];
                            txt_title = _items[index]["title"];
                            txt_course_id = _items[index]['course_id'];
                            txt_order = _items[index]['order'];
                            if (txt_id != 1 ||
                                txt_title != "รูปเรขาคณิตสองมิติและสามมิติ") {
                              return menuProgressContainer(
                                  txt_title,
                                  _image[index],
                                  txt_id,
                                  txt_course_id,
                                  context,
                                  size);
                            } else {
                              return Container();
                            }
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

Widget menuProgressContainer(
    title, image, section_id, course_id, context, size) {
  return Stack(
    alignment: Alignment.centerRight,
    children: [
      Container(
        margin: const EdgeInsets.only(right: 50),
        padding: const EdgeInsets.only(
          left: 10,
          right: 20,
          bottom: 4,
          top: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        //color: Colors.blue,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  height: size.height * 0.095,
                  width: size.width * 0.68,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Container(
          width: 98,
          height: 98,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '32',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: pColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'คะแนน',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                color: Colors.black,
                width: 70,
                height: 2,
              ),
              const Text(
                '08:45',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: pColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'นาที',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
