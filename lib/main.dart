import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/chat_service.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(
    Provider(
      create: (context) => ChatService('your_openrouter_api_key_here'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeepSeek Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}