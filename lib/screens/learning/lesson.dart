import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';
import 'package:math_app/screens/video/videoscreen.dart';
import 'package:math_app/widget/navdrawer.dart';

class LessonScreen extends StatefulWidget {
  final dynamic title, course_id, section_id;
  const LessonScreen(
      {super.key, required this.title, this.course_id, this.section_id});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List _items = [];
  bool chk = false;
  dynamic txt_id, txt_title, txt_course_id, txt_section_id, video_url;

  Future<void> readSection() async {
    var url = Uri.parse('${API_URL}lesson');
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'course_id': widget.course_id,
          'section_id': widget.section_id
        }),
        headers: {"Content-type": "application/json"});
    final data = await json.decode(utf8.decode(response.bodyBytes));

    setState(() {
      _items = data;
    });
    chk = true;
    print(_items);
    print(widget.title);
    print("course id : " + widget.course_id);
    print("section id : " + widget.section_id);
  }

  @override
  void initState() {
    super.initState();
    readSection();
  }

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
                Positioned(
                  top: 15,
                  left: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "คำอธิบาย",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.play_arrow),
                        Text("ดูสรุปสูตร"),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: pColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 70,
                  child: Container(
                    alignment: Alignment.center,
                    width: 75,
                    height: 75,
                    color: Colors.lightGreen,
                    child: Text("Image"),
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
              child: Container(
                margin: const EdgeInsets.all(30),
                child: chk
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: _items.isEmpty
                            ? Center(
                                child: Text('ไม่มีข้อมูล'),
                              )
                            : ListView.builder(
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  txt_id = _items[index]['id'];
                                  txt_title = _items[index]["title"];
                                  txt_course_id = _items[index]['course_id'];
                                  txt_section_id = _items[index]['section_id'];
                                  video_url = _items[index]['video_url'];
                                  print(_items);
                                  return cardItem(
                                    txt_id.toString(),
                                    txt_title,
                                    video_url,
                                    '0 %',
                                  );
                                },
                              ),
                      )
                    : const Center(
                        child: Text("Loading"),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardItem(String id, String title, String url, String progress) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        leading: const Icon(Icons.play_circle_outline),
        title: Text(title),
        trailing: Text(progress),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoScreen(
                title: widget.title,
                video_title: title.toString(),
                video_url: url.toString(),
                quiz_id: id.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}
