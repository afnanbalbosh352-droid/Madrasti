import 'package:flutter/material.dart';
import '../General/app_colors.dart'; // تأكدي أن المسار صحيح حسب مجلداتك

class ChatScreen extends StatelessWidget {
  final String teacherName;

  // هذا "Constructor" لاستقبال اسم المدرس الذي اخترناه
  const ChatScreen({super.key, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teacherName), // اسم المدرس يظهر في الأعلى
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 1. منطقة عرض الرسائل
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildChatBubble("Hello Teacher, I have a question.", true),
                _buildChatBubble("Welcome! How can I help you?", false),
              ],
            ),
          ),

          // 2. منطقة كتابة الرسالة (في الأسفل)
          _buildMessageInput(),
        ],
      ),
    );
  }

  // دالة لتصميم شكل "فقاعة" الرسالة
  Widget _buildChatBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  // دالة لتصميم حقل الإدخال وزر الإرسال
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {}, // سنضيف الأكشن لاحقاً في الباك إند
            ),
          ),
        ],
      ),
    );
  }
}