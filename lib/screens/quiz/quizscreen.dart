import 'dart:convert';

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
  List _exams = [];
  bool chk = false;
  dynamic txt_id, txt_title, type, number, options, answers;
  // REQUIRED: USED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.
  // OPTIONAL: can be set directly.
  int dotCount = 5;

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
      // _exams = data["options"];
    });
    chk = true;
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
                    // direction: Axis.vertical,
                    dotCount: _items.length,
                    dotRadius: 15,

                    /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
                    activeStep: activeStep,
                    shape: Shape.pipe,
                    spacing: 10,
                    indicator: Indicator.slide,

                    /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
                    onDotTapped: (tappedDotIndex) {
                      setState(() {
                        activeStep = tappedDotIndex;
                      });
                    },

                    // DOT-STEPPER DECORATIONS
                    fixedDotDecoration: const FixedDotDecoration(
                      color: Colors.black,
                    ),

                    indicatorDecoration: const IndicatorDecoration(
                        // style: PaintingStyle.stroke,
                        // strokeWidth: 8,
                        color: pColor),
                    lineConnectorDecoration: const LineConnectorDecoration(
                      color: Colors.black,
                      strokeWidth: 0,
                    ),
                  ),

                  // Next and Previous buttons.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [previousButton(), nextButton()],
                  ),
                  Container(
                    color: Colors.amber,
                    height: 400,
                    child: ListView.builder(
                      itemCount: activeStep + 1,
                      itemBuilder: (context, index) {
                        txt_id = _items[index]["id"];
                        txt_title = _items[index]["title"];
                        options = _items[index]["options"];
                        // List op = [];
                        // setState(() {
                        //   op = _items[index]["options"];
                        // });

                        return Container(
                          child: Column(
                            children: [
                              Text(txt_title),
                              heightBox(20),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      color: Colors.amberAccent,
                                      height: 300,
                                      child: ListView.builder(
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              child: ListTile(
                                                title: Text(options),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: Text("Loading..."),
            ),
    );
  }

  // Row exam() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: List.generate(dotCount, (index) {
  //       return Container(
  //         child: Text('${index + 1}'),
  //       );
  //     }),
  //   );
  // }

  /// Returns the next button widget.
  Widget nextButton() {
    return ElevatedButton(
      child: Text('Next'),
      onPressed: () {
        /// ACTIVE STEP MUST BE CHECKED FOR (dotCount - 1) AND NOT FOR dotCount To PREVENT Overflow ERROR.
        if (activeStep < _items.length - 1) {
          setState(() {
            activeStep++;
          });
        }
      },
    );
  }

  /// Returns the previous button widget.
  Widget previousButton() {
    return ElevatedButton(
      child: Text('Prev'),
      onPressed: () {
        // activeStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }
}
