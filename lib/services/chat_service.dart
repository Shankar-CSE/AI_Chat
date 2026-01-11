import "dart:convert";
import "package:http/http.dart" as http;

class ChatService {
  static const String _apiUrl = "https://openrouter.ai/api/v1/chat/completions";
  static const _deepSeekModel = 'deepseek/deepseek-chat:free';
  final String _apiKey;

  ChatService(this._apiKey);

  /// Sends a message to the chat API and returns the response.
  ///
  /// [message] is the message to send to the API.
  /// [history] is a list of previous messages in the conversation.
  Future<String> sendMessage(String message, List<Map<String, dynamic>> history) async {
    final url = Uri.parse(_apiUrl);
    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };
    final requestBody = {
      'model': _deepSeekModel,
      'messages': [
        ...history.map((msg) => {'role': msg['role'], 'content': msg['content']}),
        {'role': 'user', 'content': message},
      ],
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error communicating with OpenRouter: $e');
    }
  }
}
