import 'dart:convert';

import 'package:http/http.dart' as http;

class GeminiApi{
  // creating a header

  static Future<Map<String, String>> getHeader() async {
    return {
      'Content-Type' : 'application/json'
    };

  }
  // creating a http request

  static Future<String> getGeminiData(message) async {
    try{
      final header = await getHeader();

      final Map<String, dynamic> requestBody = {
        'contents' : [
          {
            'parts' : [
              {'text' : 'user message request here $message'}
            ]
          }
        ],
        'generationConfig' : {
          'temperature' : 0.8,
          'maxOutputTokens' : 1000
        }
      };
      String api = "AIzaSyD_UNxHsJUDiLTNaKmsSXq6xGZKgGIP2SE";

      String url =  'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$api';

      var response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if(response.statusCode == 200) {
        var jsonResponse  = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse['candidates'][0]['content']['parts'][0]['text'];

      }else {
        return '';
      }
    }
    catch (e) {
      print("Error: $e");
      return "";
    }
  }
}