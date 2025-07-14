import "dart:convert";
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

class ChatService {
  static const String _apiUrl = "https://api.openai.com/v1/chat/completions";
  final String _apiKey;
  ChatService(this._apiKey);


}
