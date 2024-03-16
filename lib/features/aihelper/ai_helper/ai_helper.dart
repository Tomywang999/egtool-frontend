import 'dart:async';
import 'package:egtool/features/aihelper/services/ai_helper_services.dart';
import 'package:egtool/constants/global_variables.dart';
import 'package:egtool/models/helper.dart';
import 'package:flutter/material.dart';

class AIHelperScreen extends StatefulWidget {
  static const String routeName = '/aihelper';
  const AIHelperScreen({super.key});

  @override
  _AIHelperScreenState createState() => _AIHelperScreenState();
}

class _AIHelperScreenState extends State<AIHelperScreen> {
  bool isLoading = false;
  final TextEditingController questionController = TextEditingController();
  final TextEditingController userAnswerController = TextEditingController();
  final TextEditingController correctAnswerController = TextEditingController();
  var dropdownValue = 'TOEFL';
  var questionType = 'Vocabulary Questions';
  var explanation = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void emptyTextField() {
    setState(() {
      questionController.clear();
      userAnswerController.clear();
      correctAnswerController.clear();
      explanation = '';
    });
  }

  List<String> getQuestionTypes() {
    switch (dropdownValue) {
      case 'TOEFL':
        return [
          'Vocabulary Questions',
          'Detail Questions',
          // Add all TOEFL question types here...
        ];
      case 'IELTS':
        return [
          'Multiple Choice Questions',
          'Matching Questions',
          // Add all IELTS question types here...
        ];
      case 'GRE':
        return [
          'Reading Comprehension Questions',
          'Text Completion Questions',
          // Add all GRE question types here...
        ];
      case 'SAT':
        return [
          'Words in Context Questions',
          'Command of Evidence Questions',
          // Add all SAT question types here...
        ];
      default:
        return [];
    }
  }

  sendhelp() async {
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
      Helper helper = await Future.any([
        Aihelperservices().sendHelper(
            context: context,
            questions: questionController.text,
            useranswers: userAnswerController.text,
            mode: dropdownValue,
            correctanswer: correctAnswerController.text),
        timeout,
      ]);

      setState(() {
        explanation = helper.explanation;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        //feedback = 'Error: ${e.toString()}';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
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
                                        controller: questionController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Enter your question here'),
                                        maxLines: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
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
                                          Icon(Icons.question_answer),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Your answer",
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
                                        controller: userAnswerController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter your answer here'),
                                        maxLines: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
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
                                          Icon(Icons.check_box),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Correct answer",
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
                                        controller: correctAnswerController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Enter the correct answer here'),
                                        maxLines: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 240,
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
                                        Icon(Icons.explore_sharp),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Explanation",
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
                                          185, // Set the desired constant height
                                      child: SingleChildScrollView(
                                        child: Text(
                                          explanation,
                                          //highscoreexample.toString(),
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 360,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  const SizedBox(height: 40),
                                  const Text(
                                    'Configuation: ',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Mode: ",
                                          style: TextStyle(
                                            color:
                                                GlobalVariables.TextBlackColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        DropdownButton<String>(
                                          value: dropdownValue,
                                          //icon: Icon(Icons.arrow_downward),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(
                                            color:
                                                GlobalVariables.TextBlackColor,
                                          ),
                                          underline: Container(
                                            height: 2,
                                            color: GlobalVariables.Selected,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                              questionType = getQuestionTypes()[
                                                  0]; // Set questionType to the first item in the new list
                                            });
                                          },
                                          items: <String>[
                                            'TOEFL',
                                            'IELTS',
                                            'GRE',
                                            'SAT',
                                          ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /*Center(
                                  child: LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      if (constraints.maxWidth < 350) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Question Type: ",
                                              style: TextStyle(
                                                color: GlobalVariables
                                                    .TextBlackColor,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            DropdownButton<String>(
                                              value: questionType,
                                              iconSize: 24,
                                              elevation: 16,
                                              style: const TextStyle(
                                                color: GlobalVariables
                                                    .TextBlackColor,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: GlobalVariables.Selected,
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  questionType = newValue!;
                                                });
                                              },
                                              items: getQuestionTypes()
                                                  .map<DropdownMenuItem<String>>(
                                                (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Flexible(
                                                      child: Text(
                                                        value,
                                                        //softWrap: true,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Question Type: ",
                                              style: TextStyle(
                                                color: GlobalVariables
                                                    .TextBlackColor,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            DropdownButton<String>(
                                              value: questionType,
                                              iconSize: 24,
                                              elevation: 16,
                                              style: const TextStyle(
                                                color: GlobalVariables
                                                    .TextBlackColor,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: GlobalVariables.Selected,
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  questionType = newValue!;
                                                });
                                              },
                                              items: getQuestionTypes()
                                                  .map<DropdownMenuItem<String>>(
                                                (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Flexible(
                                                      child: Text(
                                                        value,
                                                        //softWrap: true,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),*/
                                  const SizedBox(
                                    height: 45,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width *
                                        0.2, // Adjust the width value as needed
                                    child: ElevatedButton(
                                      onPressed: sendhelp,
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
                                    height: 40,
                                    width: MediaQuery.of(context).size.width *
                                        0.2, // Adjust the width value as needed
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
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
