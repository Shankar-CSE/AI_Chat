import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/chat_service.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(
    Provider(
      create: (context) => ChatService('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'),
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