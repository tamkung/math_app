import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:math_app/config/constant.dart';

import '../home.dart';

class QuizScreen extends StatefulWidget {
  final dynamic id, title;
  const QuizScreen({super.key, required this.id, required this.title});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List _items = [];
  bool chk = false;
  dynamic txt_id, txt_title, type, number, options, answers;
  int activeStep = 0;
  int score = 0;
  dynamic user_id;
  GetStorage box = GetStorage();

  List _user_answers = [];
  List _correct_answers = [];

  List isSeleted = [];
  List<bool> isChk = [];

  Future<void> getQuiz() async {
    user_id = box.read('u_id');
    var url = Uri.parse('${API_URL}question');
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'quiz_id': widget.id,
        }),
        headers: {"Content-type": "application/json"});
    final data = await json.decode(utf8.decode(response.bodyBytes));

    setState(() {
      _items = data;
    });
    chk = true;
    if (_items.isNotEmpty) {
      isSeleted.add({
        for (var i = 0; i < _items.length; i++)
          i + 1: [
            for (var j = 0; j < jsonDecode(_items[i]["options"]).length; j++)
              false
          ],
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getQuiz();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.12),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 15),
            margin: const EdgeInsets.only(left: 60, right: 60),
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: pColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: chk
          ? Container(
              width: size.width * 1,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(),
                image: DecorationImage(
                  image: AssetImage("assets/images/bg-change-pass.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: _items.isNotEmpty
                  ? Column(
                      children: [
                        _items.length <= 1
                            ? Container()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DotStepper(
                                    dotCount: _items.length,
                                    dotRadius: 15,
                                    activeStep: activeStep,
                                    shape: Shape.pipe,
                                    spacing: 10,
                                    indicator: Indicator.slide,
                                    onDotTapped: (tappedDotIndex) {
                                      setState(() {
                                        activeStep = tappedDotIndex;
                                      });
                                    },
                                    fixedDotDecoration:
                                        const FixedDotDecoration(
                                      color: Colors.black,
                                    ),
                                    indicatorDecoration:
                                        const IndicatorDecoration(
                                            color: pColor),
                                    lineConnectorDecoration:
                                        const LineConnectorDecoration(
                                      color: Colors.black,
                                      strokeWidth: 0,
                                    ),
                                  ),
                                  Text(
                                    "${activeStep + 1}/${_items.length}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                        Column(
                          children: List.generate(1, (index) {
                            txt_id = _items[activeStep]["id"];
                            txt_title = _items[activeStep]["title"];
                            options = _items[activeStep]["options"];
                            answers = jsonDecode(
                                _items[activeStep]["correct_answers"]);

                            List opList = jsonDecode(options);

                            List<bool> isChk = isSeleted[0][activeStep + 1];

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "โจทย์ข้อที่ ${activeStep + 1}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      heightBox(10),
                                      Text(txt_title,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                                heightBox(20),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: List.generate(opList.length,
                                            (index) {
                                          return Card(
                                            elevation: 3,
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: ListTile(
                                              tileColor: isChk[index]
                                                  ? Colors.green
                                                  : pColor,
                                              textColor: Colors.white,
                                              title: Text(opList[index]),
                                              enabled: !isChk[index],
                                              onTap: () async {
                                                setState(() {
                                                  isChk[index] = true;
                                                });
                                                for (int i = 0;
                                                    i < isChk.length;
                                                    i++) {
                                                  if (i != index) {
                                                    isChk[i] = false;
                                                  }
                                                }
                                                print(isChk);

                                                _user_answers.removeWhere(
                                                    (element) =>
                                                        element.keys.first ==
                                                        txt_id);
                                                _user_answers.add({
                                                  txt_id: index + 1,
                                                });

                                                _correct_answers.removeWhere(
                                                    (element) =>
                                                        element.keys.first ==
                                                        txt_id);
                                                _correct_answers.add({
                                                  txt_id: answers[0],
                                                });

                                                if (activeStep <
                                                    _items.length - 1) {
                                                  setState(() {
                                                    activeStep++;
                                                  });
                                                } else {
                                                  submit();
                                                }
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [previousButton(), nextButton()],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 18,
                                bottom: 18,
                                left: 135,
                                right: 135,
                              ),
                              height: size.height * 0.12,
                              width: size.width * 1,
                              decoration: const BoxDecoration(
                                color: pColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                ),
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(Size(
                                      size.width * 0.8, size.height * 0.1)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                    (states) => Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (_user_answers.length == _items.length) {
                                    addQuizResult();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("แจ้งเตือน"),
                                          content:
                                              const Text("ส่งคำตอบเรียบร้อย"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen(),
                                                  ),
                                                );
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("แจ้งเตือน"),
                                          content: const Text(
                                              "กรุณาตอบคำถามให้ครบทุกข้อ"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: const Text(
                                  'ส่ง',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: pColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text("ไม่พบข้อมูล"),
                    ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> addQuizResult() async {
    var url = Uri.parse('${API_URL}add-quiz-result');
    final response = await http.post(url,
        body: jsonEncode({
          "quiz_id": widget.id.toString(),
          "user_id": user_id.toString(),
          "user_answers": _user_answers.toString(),
          "correct_answers": _correct_answers.toString(),
          "score": score,
          "total_score": _items.length,
        }),
        headers: {"Content-type": "application/json"});
    final data = await json.decode(utf8.decode(response.bodyBytes));
    print(data);
  }

  Widget nextButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(pColor),
      ),
      child: Text('Next'),
      onPressed: () {
        if (activeStep < _items.length - 1) {
          setState(() {
            activeStep++;
          });
        }
      },
    );
  }

  Widget previousButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(pColor),
      ),
      child: Text('Prev'),
      onPressed: () {
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }

  Future<void> submit() async {
    _user_answers.sort((a, b) => a.keys.first.compareTo(b.keys.first));
    _correct_answers.sort((a, b) => a.keys.first.compareTo(b.keys.first));
    // คำนวณคะแนน
    for (int i = 0; i < _user_answers.length; i++) {
      var userAnswer = _user_answers[i];
      var correctAnswer = _correct_answers[i];

      // แปลงชนิดข้อมูลของ userAnswer เป็นสตริง
      var userAnswerString = userAnswer.values.first.toString();

      if (userAnswerString == correctAnswer.values.first) {
        score += 1;
        print('score: $score');
      }
    }

    print(_user_answers);
    print(_correct_answers);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Score"),
          content: Text("Score : $score / ${_items.length}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
