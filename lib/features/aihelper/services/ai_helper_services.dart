import 'dart:convert';
import 'package:egtool/models/helper.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:egtool/constants/global_variables.dart';

class Aihelperservices {
  Future<Helper> sendHelper({
    required BuildContext context,
    required String questions,
    required String useranswers,
    required String correctanswer,
    required String mode,
  }) async {
    final response = await http.post(
      Uri.parse('$uri/api/aihelper'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'questions': questions,
        'useranswers': useranswers,
        'correctanswer': correctanswer,
        'mode': mode
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      //print(jsonDecode(response.body)['completion']);
      String explanation =
          jsonDecode(response.body)['completion']['explanation'];

      Helper correction = Helper(
        mode: mode,
        correctanswer: correctanswer,
        explanation: explanation,
        question: questions,
        useranswers: useranswers,
      );

      return correction;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load response');
    }
  }
}
