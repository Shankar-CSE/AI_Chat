import "dart:convert";
import "package:http/http.dart" as http;
// import 'package:flutter/material.dart';

class ChatService {
  static const String _apiUrl = "https://api.openai.com/v1/chat/completions";
  static const _deepSeekModel = 'deepseek/deepseek-chat:free';
  final String _apiKey;
  ChatService(this._apiKey);

  Future<String> sendMessage(String message , List<Map<String, dynamic>> history) async{
      try{
        final response = await http.post(
          Uri.parse(_apiUrl),
          headers: {
           'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://chat.openai.com', // Required by OpenRouter
          'X-Title': 'AI-Chat',
          },
          body: jsonEncode({
          'model': _deepSeekModel,
          'messages': [
            ...?history?.map((msg) => {'role': msg['role'], 'content': msg['content']}),
            {'role': 'user', 'content': message},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to get response: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error communicating with OpenRouter: $e');
    }
  }
}
