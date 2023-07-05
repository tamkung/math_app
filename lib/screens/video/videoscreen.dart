import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:math_app/screens/quiz/quizscreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../config/constant.dart';
import '../../widget/navdrawer.dart';

class VideoScreen extends StatefulWidget {
  final dynamic title,
      video_title,
      video_url,
      quiz_id,
      image_url,
      section_img,
      course_id,
      section_id;
  const VideoScreen(
      {super.key,
      required this.title,
      this.video_title,
      this.video_url,
      this.quiz_id,
      this.image_url,
      this.section_img,
      this.course_id,
      this.section_id});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String? score, total_score;
  String txt_score = 'loading...';
  bool chk = false;
  dynamic user_id;
  GetStorage box = GetStorage();
  String? videoId;

  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _muted = false;
  bool _isPlayerReady = false;
  String? quiz_id;

  Future<void> getQuestionID() async {
    user_id = box.read('u_id');
    var url = Uri.parse('${API_URL}lesson-question');
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'course_id': widget.course_id.toString(),
          'section_id': widget.section_id.toString(),
          'title': widget.video_title.toString(),
        }),
        headers: {"Content-type": "application/json"});
    final data = await json.decode(utf8.decode(response.bodyBytes));

    if (data.length > 0) {
      setState(() {
        quiz_id = data[0]['id'].toString();
      });
    }
    print(quiz_id);
    getScore();
  }

  Future<void> getScore() async {
    user_id = box.read('u_id');
    var url = Uri.parse('${API_URL}get-score');
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'user_id': user_id.toString(),
          'quiz_id': quiz_id.toString(),
        }),
        headers: {"Content-type": "application/json"});
    final data = await json.decode(utf8.decode(response.bodyBytes));
    if (data.length > 0) {
      setState(() {
        score = data[0]['score'].toString();
        total_score = data[0]['total_score'].toString();
        txt_score = '$score  / $total_score คะแนน';
      });
      chk = true;
    } else {
      setState(() {
        txt_score = 'ยังไม่มีคะแนน';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getQuestionID();
    videoId = YoutubePlayer.convertUrlToId(widget.video_url);
    _controller = YoutubePlayerController(
      initialVideoId: videoId.toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return newScaffold(size);
        } else {
          return Container(
            color: Colors.black,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.contain,
                child: YoutubePlayer(
                  controller: _controller,
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget newScaffold(size) {
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
      body: SafeArea(
        child: Column(
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
                          child: SizedBox(
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
                        showPopUp(
                          context,
                          'สูตร \n${widget.title}',
                          widget.section_img,
                          size.width * 0.7,
                          size.height * 0.5,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
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
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: pColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg-home.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    //height: size.height * 0.1,
                    width: size.width,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 50, 20, 40),
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.play_circle_filled,
                                color: Colors.red,
                              ),
                              widthBox(size.width * 0.02),
                              Text(widget.video_title),
                            ],
                          ),
                          heightBox(10),
                          YoutubePlayerBuilder(
                            player: YoutubePlayer(
                              controller: _controller,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.blueAccent,
                              // onReady: () {
                              //   _isPlayerReady = true;
                              // },
                            ),
                            builder: (context, player) {
                              return Column(
                                children: [
                                  player,
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  heightBox(size.height * 0.03),
                  Text(
                    txt_score,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      top: 15,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => pColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(
                              id: quiz_id,
                              title: widget.title,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'แบบทดสอบ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
