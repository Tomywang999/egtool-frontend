import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:egtool/constants/global_variables.dart';
import 'package:egtool/models/correction.dart';
import 'package:flutter/material.dart';
import 'package:egtool/features/aicorrection/services/ai_correction_services.dart';

class AiCorrectionScreen extends StatefulWidget {
  static const String routeName = '/aicorrection';
  const AiCorrectionScreen({super.key});

  @override
  State<AiCorrectionScreen> createState() => _AiCorrectionScreenState();
}

class _AiCorrectionScreenState extends State<AiCorrectionScreen> {
  bool isLoading = false;
  final Aicorrectionservices correctionservices = Aicorrectionservices();
  final TextEditingController oringetext = TextEditingController();
  final TextEditingController question = TextEditingController();
  var score = 0;
  var feedback = '';
  var highscoreexample = '';
  int wordCount = 0;
  String correctionres = '';
  var dropdownValue = 'TOEFL';

  @override
  void initState() {
    super.initState();
    oringetext.addListener(countWords);
  }

  @override
  void dispose() {
    oringetext.dispose();
    super.dispose();
  }

  void countWords() {
    setState(() {
      wordCount =
          oringetext.text.split(' ').where((word) => word.isNotEmpty).length;
    });
  }

  void emptyTextField() {
    setState(() {
      wordCount = 0;
      oringetext.clear();
      question.clear();
      score = 0;
      feedback = '';
      highscoreexample = '';
    });
  }

  sendcorrection() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Set a time limit for the API call
      final timeoutDuration = Duration(seconds: 10);
      final timeout = Future.delayed(timeoutDuration, () {
        throw TimeoutException('The request took too long to complete.');
      });

      // Make the API call and wait for the result or timeout
      Correction correction = await Future.any([
        correctionservices.sendCorrection(
          context: context,
          questions: question.text,
          useranswers: oringetext.text,
          mode: "TOEFL",
        ),
        timeout,
      ]);

      setState(() {
        score = correction.grade;
        highscoreexample = correction.sample;
        feedback = correction.feedback;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        feedback = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 260,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.question_mark),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Question",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: question,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your question here'),
                            maxLines: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 420,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.edit),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Your writing",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      width: 200,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: GlobalVariables.Selected,
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Word count: $wordCount',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: oringetext,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your writing here'),
                                  maxLines: 13,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength:
                                      800, // Adjust this value as needed
                                  lineThickness: 5.0,
                                  dashLength: 7.0,
                                  dashColor: GlobalVariables.primarycolor,
                                  dashRadius: 0.0,
                                  dashGapLength: 10.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    score.toString(),
                                    style: const TextStyle(
                                        fontSize: 90,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    "Overall Score",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    width: MediaQuery.of(context).size.width *
                                        0.5, // Adjust the width value as needed
                                    child: ElevatedButton(
                                      onPressed: sendcorrection,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            GlobalVariables.Selected,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Adjust the border radius value as needed
                                        ),
                                      ),
                                      child: const Text(
                                        "Sumbit",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    width: MediaQuery.of(context).size.width *
                                        0.5, // Adjust the width value as needed
                                    child: ElevatedButton(
                                      onPressed: emptyTextField,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            GlobalVariables.Selected,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Adjust the border radius value as needed
                                        ),
                                      ),
                                      child: const Text(
                                        "Empty out",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      const Text(
                                        "Mode: ",
                                        style: TextStyle(
                                          color: GlobalVariables.TextBlackColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      DropdownButton<String>(
                                        value: dropdownValue,
                                        //icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color:
                                                GlobalVariables.TextBlackColor),
                                        underline: Container(
                                          height: 2,
                                          color: GlobalVariables.Selected,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          'TOEFL',
                                          'IELTS',
                                          'GRE',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.book),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "High score example",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height:
                                        400, // Set the desired constant height
                                    child: SingleChildScrollView(
                                      child: Text(
                                        highscoreexample.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.star),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Feedback",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 400,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        feedback.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5), // This is optional
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
