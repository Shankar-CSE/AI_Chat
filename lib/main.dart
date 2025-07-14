import 'package:flutter/material.dart';
import 'package:ai_chat/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:ai_chat/services/chat_service.dart';

void main() {
  
  runApp(
    Provider(create: (context) => ChatService("Api-key"),
    child:const MyApp()),
    );
    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); @override
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