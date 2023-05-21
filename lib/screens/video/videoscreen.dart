import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
  @override
  Widget build(BuildContext context) {
    String? videoId = YoutubePlayer.convertUrlToId(widget.video_url);
    print(videoId);
    print(widget.quiz_id);

    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    var size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: NavDrawer(),
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
                    top: 5,
                    left: 30,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: SizedBox(
                            width: size.width * 0.56,
                            height: size.height * 0.13,
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
                      onPressed: () {},
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
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 50,
                    ),
                    child: Container(
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
                            YoutubePlayer(
                              controller: _controller,
                              liveUIColor: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Text('ยังไม่ได้ทำแบบทดสอบ'),
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
