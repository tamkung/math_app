import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_app/config/constant.dart';
import 'package:math_app/screens/home.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../widget/navdrawer.dart';

class LessonProgressScreen extends StatefulWidget {
  const LessonProgressScreen({super.key});

  @override
  State<LessonProgressScreen> createState() => _LessonProgressScreenState();
}

class _LessonProgressScreenState extends State<LessonProgressScreen> {
  List _items = [];
  final List _image = [
    'assets/images/menu1.png',
    'assets/images/menu2.png',
    'assets/images/menu3.png',
    'assets/images/menu4.png',
    'assets/images/menu5.png'
  ];
  bool chk = false;
  dynamic txt_id, txt_title, avg_percent;
  GetStorage box = GetStorage();
  String? API_URL = dotenv.env['API_URL'];

  dynamic user_id;

  Future<void> readSection() async {
    user_id = box.read('u_id');
    var url = Uri.parse('${API_URL}percent-section');
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'user_id': user_id.toString(),
          'course_id': '1',
        }),
        headers: {"Content-type": "application/json"});
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
                        'ผลทดสอบ',
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
        physics: const NeverScrollableScrollPhysics(),
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
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            txt_title = _items[index]["title"];

                            _items[index]['avg_percent'] == null
                                ? avg_percent = '0'
                                : avg_percent = _items[index]['avg_percent'];

                            return menuProgressContainer(
                                txt_title, avg_percent, context, size);
                          },
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget menuProgressContainer(title, percent, context, size) {
  return Stack(
    alignment: Alignment.centerRight,
    children: [
      Container(
        margin: const EdgeInsets.only(right: 50),
        padding: const EdgeInsets.only(
          left: 10,
          right: 20,
          bottom: 10,
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
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  height: size.height * 0.085,
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
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  color: pColor,
                  width: size.width * 0.6,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation<Color>(pColor),
                    value: double.parse(percent) / 100,
                    minHeight: 6,
                  ),
                )
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
          child: Center(
            child: Text(
              "$percent %",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
