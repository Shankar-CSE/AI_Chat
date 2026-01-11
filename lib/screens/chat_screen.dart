import 'dart:developer';
import 'dart:ui';
import 'package:ai_chat/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fabController;
  late AnimationController _typingController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    _typingController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    if (_messageController.text.isEmpty) return;
    final message = _messageController.text;
    _messageController.clear();
    _messages.add({'role': 'user', 'content': message});
    setState(() {
      _isLoading = true;
    });
    _scrollToBottom();

    try {
      final chatService = Provider.of<ChatService>(context, listen: false);
      final response = await chatService.sendMessage(message, _messages);

      setState(() {
        _messages.add({'role': 'assistant', 'content': response});
      });
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: const Color(0xFFFF6B6B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        )
      );
      log(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat'),
        content: const Text('Are you sure you want to clear all messages?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _messages.clear();
              });
              Navigator.of(context).pop();
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667EEA).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667EEA),
              Color(0xFF764BA2),
              Color(0xFFF093FB),
              Color(0xFFF5576C),
            ],
          ),
        ),
        child: Column(
          children: [
            // Custom App Bar with Glassmorphism
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Color(0xFFF0F0F0)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.auto_awesome, color: Color(0xFF667EEA), size: 20),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Assistant',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Powered by DeepSeek',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, color: Colors.white, size: 20),
                            onSelected: (value) {
                              if (value == 'clear') {
                                _showClearChatDialog();
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'clear',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_outline, size: 20),
                                    SizedBox(width: 8),
                                    Text('Clear Chat'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Chat Messages
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: _messages.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Colors.white, Color(0xFFF0F0F0)],
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF667EEA), size: 40),
                                  ),
                                  const SizedBox(height: 20),
                                  AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        'Hello! How can I help you today?',
                                        textStyle: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        speed: const Duration(milliseconds: 100),
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(20),
                              itemCount: _messages.length + (_isLoading ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == _messages.length && _isLoading) {
                                  return _buildTypingIndicator();
                                }

                                final message = _messages[index];
                                final isUser = message['role'] == 'user';

                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 300 + (index * 100)),
                                  curve: Curves.easeOutBack,
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                                    children: [
                                      if (!isUser)
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                                            ),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF667EEA).withOpacity(0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                                        ),

                                      Flexible(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 12),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            gradient: isUser
                                                ? const LinearGradient(
                                                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                                                  )
                                                : null,
                                            color: isUser ? null : Colors.white.withOpacity(0.9),
                                            borderRadius: BorderRadius.only(
                                              topLeft: const Radius.circular(20),
                                              topRight: const Radius.circular(20),
                                              bottomLeft: Radius.circular(isUser ? 20 : 5),
                                              bottomRight: Radius.circular(isUser ? 5 : 20),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: MarkdownBody(
                                            data: message['content']!,
                                            selectable: true,
                                            styleSheet: MarkdownStyleSheet(
                                              p: GoogleFonts.poppins(
                                                color: isUser ? Colors.white : const Color(0xFF2D3748),
                                                fontSize: 15,
                                                height: 1.4,
                                              ),
                                              a: TextStyle(
                                                color: isUser ? Colors.white.withOpacity(0.8) : const Color(0xFF667EEA),
                                              ),
                                              code: GoogleFonts.firaCode(
                                                color: isUser ? Colors.white : const Color(0xFF2D3748),
                                                backgroundColor: isUser
                                                    ? Colors.white.withOpacity(0.2)
                                                    : const Color(0xFFF7FAFC),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      if (isUser)
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                                            ),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFFF5576C).withOpacity(0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(Icons.person, color: Colors.white, size: 20),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ),
            ),

            // Input Area
            Container(
              margin: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Type your message...',
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey.withOpacity(0.7),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            onSubmitted: (_) => sendMessage(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF667EEA).withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                            onPressed: _isLoading ? null : sendMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
