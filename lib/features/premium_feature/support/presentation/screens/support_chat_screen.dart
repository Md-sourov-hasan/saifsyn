import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_bar.dart';

class SupportChatScreen extends StatelessWidget {
  const SupportChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Chat Header
            const ChatHeader(
              name: 'Support Team',
              status: 'Online',
              avatarText: 'ST',
            ),

            // Chat Messages
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 27.h),
                child: Column(
                  children: [
                    // Support message
                    const ChatMessageBubble(
                      message: 'Welcome! How can I help you today?',
                      time: '10:30 AM',
                      isUserMessage: false,
                    ),

                    SizedBox(height: 16.h),

                    // User message
                    const ChatMessageBubble(
                      message: 'I have a question about stock recommendations',
                      time: '10:32 AM',
                      isUserMessage: true,
                    ),

                    SizedBox(height: 16.h),

                    // Support message
                    const ChatMessageBubble(
                      message:
                          'Of course! I\'d be happy to discuss our recommendations with you.',
                      time: '10:33 AM',
                      isUserMessage: false,
                    ),
                  ],
                ),
              ),
            ),

            // Chat Input Bar
            const ChatInputBar(),
          ],
        ),
      ),
    );
  }
}
