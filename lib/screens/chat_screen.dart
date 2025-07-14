import 'dart:developer';
import 'package:ai_chat/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isload = false;

  Future<void> sendMessage() async {
    if (_messageController.text.isEmpty) return;
    final message = _messageController.text;
    _messageController.clear();
    _messages.add({'role': 'user', 'content': message});
    setState(() {
      _isload = true;
    });
    
    try{
      final chatService = Provider.of<ChatService>(context,listen: false);
      final response = await chatService.sendMessage(message, _messages);

      setState(() {
        _messages.add({'role': 'assistant', 'content': response});
       
      });

    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      log(e.toString());
    }finally{
      setState(() {
        _isload = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(child: 
          ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: message['role'] == 'user'
                        ? Colors.blue[100]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MarkdownBody(
                    data: message['content']!,
                    selectable: true,
                  ),
                );
              },
            ),
          ),
          if (_isload) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}