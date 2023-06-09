import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';
import 'package:math_app/screens/video/videoscreen.dart';
import 'package:math_app/widget/navdrawer.dart';
import 'package:photo_view/photo_view.dart';

class LessonScreen extends StatefulWidget {
  final dynamic title, course_id, section_id, image_url, section_img;
  const LessonScreen(
      {super.key,
      required this.title,
      this.course_id,
      this.section_id,
      this.image_url,
      this.section_img});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List _items = [];
  List _percent = [];
  List _quiz_id = [];
  bool chk = false;
  GetStorage box = GetStorage();
  dynamic user_id;
  dynamic txt_id,
      txt_title,
      txt_course_id,
      txt_section_id,
      video_url,
      lesson_quiz_id;

  //dynamic percent = 0;

  Future<void> getSection() async {
    user_id = box.read('u_id');
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
    for (var i = 0; i < _items.length; i++) {
      _quiz_id.add(_items[i]['quiz_id']);
    }
    chk = true;
    getPercent();
  }

  Future<void> getPercent() async {
    var url = Uri.parse('${API_URL}percent-lesson');
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'user_id': user_id.toString(),
          'quiz_id': _quiz_id.toString().replaceAll('[', '').replaceAll(']', '')
        }),
        headers: {"Content-type": "application/json"});
    final data = await json.decode(utf8.decode(response.bodyBytes));

    setState(() {
      _percent = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getSection();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: IconButton(
          splashRadius: 20,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: pColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                      ),
                      color: pColor,
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg-home.png"),
                        fit: BoxFit.none,
                      ),
                    ),
                    height: size.height * 0.25,
                    width: size.width * 0.25,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    height: size.height * 0.234,
                    width: size.width * 0.93,
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
                  top: 5,
                  left: 30,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: Container(
                          width: size.width * 0.56,
                          height: size.height * 0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "พื้นที่ คือ ขนาดของพื้นผิวที่เป็นพื้นราบหรือรูปร่างสองมิติ",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: size.width * 0.3,
                        height: size.height * 0.13,
                        child: Image.asset(
                          widget.image_url.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: SizedBox(
                              width: size.width * 0.77,
                              height: size.height * 0.7,
                              child: GestureDetector(
                                child: PhotoView(
                                  backgroundDecoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  imageProvider:
                                      NetworkImage(widget.section_img),
                                  minScale:
                                      PhotoViewComputedScale.contained * 1,
                                  maxScale: PhotoViewComputedScale.covered * 2,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.play_arrow),
                        Text("ดูสรุปสูตร"),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 70,
                  child: Container(),
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
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: chk
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: _items.isEmpty
                            ? const Center(
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
                                  lesson_quiz_id = _items[index]['quiz_id'];

                                  dynamic percent = 0;
                                  _percent.forEach((element) {
                                    if (element['quiz_id'] == _quiz_id[index]) {
                                      percent = element['percent_score'];
                                    }
                                  });
                                  return cardItem(
                                    lesson_quiz_id.toString(),
                                    txt_title,
                                    video_url,
                                    percent.toString(),
                                  );
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
          ),
        ],
      ),
    );
  }

  Widget cardItem(String id, String title, String url, String progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: ListTile(
          leading: const Icon(Icons.play_circle_outline),
          title: Text(title),
          trailing: Text("$progress %"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoScreen(
                  title: widget.title,
                  video_title: title.toString(),
                  video_url: url.toString(),
                  quiz_id: id.toString(),
                  image_url: widget.image_url.toString(),
                  section_img: widget.section_img,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
