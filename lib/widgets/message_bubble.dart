import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final int index;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeOutBack,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(false),
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
                data: message,
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
          if (isUser) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUserAvatar) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isUserAvatar
              ? [const Color(0xFFF093FB), const Color(0xFFF5576C)]
              : [const Color(0xFF667EEA), const Color(0xFF764BA2)],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (isUserAvatar ? const Color(0xFFF5576C) : const Color(0xFF667EEA))
                .withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        isUserAvatar ? Icons.person : Icons.auto_awesome,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}