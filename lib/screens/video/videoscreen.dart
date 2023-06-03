import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:math_app/screens/quiz/quizscreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../config/constant.dart';
import '../../widget/navdrawer.dart';

class VideoScreen extends StatefulWidget {
  final dynamic title, video_title, video_url, quiz_id, image_url;
  const VideoScreen(
      {super.key,
      required this.title,
      this.video_title,
      this.video_url,
      this.quiz_id,
      this.image_url});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String? score, total_score;
  String txt_score = 'loading...';
  bool chk = false;
  dynamic user_id;
  GetStorage box = GetStorage();
  YoutubePlayerController? _controller;

  Future<void> getScore() async {
    user_id = box.read('u_id');
    var url = Uri.parse('${API_URL}get-score');
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'user_id': user_id.toString(),
          'quiz_id': widget.quiz_id.toString(),
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
    getScore();
    String? videoId = YoutubePlayer.convertUrlToId(widget.video_url);
    _controller = YoutubePlayerController(
      initialVideoId: videoId.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
        isLive: false,
      ),
    );
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
                      height: size.height * 0.222,
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
                        showPopUp(context, 'สูตร \n${widget.title}', 'image');
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
                              Text(widget.video_title)
                            ],
                          ),
                          heightBox(10),
                          YoutubePlayerBuilder(
                            player: YoutubePlayer(
                              controller: _controller!,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                              progressColors: const ProgressBarColors(
                                playedColor: Colors.red,
                                handleColor: Colors.redAccent,
                              ),
                              bottomActions: [
                                CurrentPosition(),
                                ProgressBar(isExpanded: true),
                                RemainingDuration(),
                                FullScreenButton(),
                              ],
                            ),
                            builder: (context, player) {
                              return Column(
                                children: [
                                  // some widgets
                                  player,
                                  //some other widgets
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
                              id: widget.quiz_id,
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
