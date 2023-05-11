import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:math_app/config/constant.dart';

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
  int dotCount = 5;
  int score = 0;

  Future<void> readQuiz() async {
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
    if (_items.isNotEmpty) {
      chk = true;
    }

    print(_items);
    print(widget.title);
  }

  @override
  void initState() {
    super.initState();
    readQuiz();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: chk
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                    fixedDotDecoration: const FixedDotDecoration(
                      color: Colors.black,
                    ),
                    indicatorDecoration:
                        const IndicatorDecoration(color: pColor),
                    lineConnectorDecoration: const LineConnectorDecoration(
                      color: Colors.black,
                      strokeWidth: 0,
                    ),
                  ),
                  Text("${activeStep + 1}/${_items.length}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [previousButton(), nextButton()],
                  ),
                  Column(
                    children: List.generate(1, (index) {
                      txt_id = _items[activeStep]["id"];
                      txt_title = _items[activeStep]["title"];
                      options = _items[activeStep]["options"];
                      answers =
                          jsonDecode(_items[activeStep]["correct_answers"]);
                      List opList = jsonDecode(options);

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("โจทย์ข้อที่ ${activeStep + 1}"),
                                heightBox(10),
                                Text(txt_title, style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                          heightBox(20),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children:
                                      List.generate(opList.length, (index) {
                                    return Card(
                                      elevation: 3,
                                      margin: EdgeInsets.only(bottom: 20),
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        tileColor: pColor,
                                        textColor: Colors.white,
                                        title: Text(opList[index]),
                                        onTap: () {
                                          if (index + 1 ==
                                              int.parse(answers[0])) {
                                            print("True");
                                            score++;
                                          } else {
                                            print("False");
                                          }
                                          print("Score : $score");
                                          if (activeStep < _items.length - 1) {
                                            setState(() {
                                              activeStep++;
                                            });
                                          } else {
                                            print("End");
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Score"),
                                                  content: Text(
                                                      "Score : $score / ${_items.length}"),
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
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
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
}
