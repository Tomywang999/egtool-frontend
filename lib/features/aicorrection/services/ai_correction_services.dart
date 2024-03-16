import 'dart:convert';
import 'package:egtool/models/correction.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:egtool/constants/global_variables.dart';

class Aicorrectionservices {
  Future<Correction> sendCorrection({
    required BuildContext context,
    required String questions,
    required String useranswers,
    required String mode,
  }) async {
    final response = await http.post(
      Uri.parse('$uri/api/${mode.toLowerCase()}correction'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'questions': questions,
        'useranswers': useranswers,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      //print(jsonDecode(response.body)['completion']);
      int grade = jsonDecode(response.body)['completion']['grade'];
      String sample = jsonDecode(response.body)['completion']['sample'];
      String feedback = jsonDecode(response.body)['completion']['feedback'];

      Correction correction = Correction(
          grade: grade,
          sample: sample,
          feedback: feedback,
          questions: questions,
          useranswers: useranswers);

      return correction;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load response');
    }
  }
}
