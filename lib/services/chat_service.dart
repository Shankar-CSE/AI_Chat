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
  /// 
  /// Throws an [Exception] if the API call fails or returns an error.
  Future<String> sendMessage(String message, List<Map<String, dynamic>> history) async {
    if (_apiKey.isEmpty || _apiKey == '<YOUR_API_KEY>') {
      throw Exception('API key not configured. Please provide a valid API key.');
    }

    final url = Uri.parse(_apiUrl);
    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
      'HTTP-Referer': 'https://github.com/Shankar-CSE/AI_Chat',
      'X-Title': 'AI Chat App',
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
        if (responseBody['choices'] != null && 
            responseBody['choices'].isNotEmpty &&
            responseBody['choices'][0]['message'] != null) {
          return responseBody['choices'][0]['message']['content'] ?? '';
        } else {
          throw Exception('Invalid response format from API');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your OpenRouter API key.');
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else {
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['error']?['message'] ?? 'Unknown error';
        throw Exception('API Error (${response.statusCode}): $errorMessage');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException {
      throw Exception('Failed to parse API response');
    } on Exception catch (e) {
      throw Exception('Error communicating with OpenRouter: $e');
    }
  }
}
