import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class MessagesScreen extends StatefulWidget {
  final String name;

  const MessagesScreen({super.key, required this.name});

  @override
  State<MessagesScreen> createState() => _MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen> {

  final controller = TextEditingController();

  // 🎯 5 محادثات (كل طالب له رسائل مختلفة)
  Map<String, List<Map<String, dynamic>>> chats = {
    "أحمد": [
      {"text": "مرحبا أستاذ", "isMe": false},
      {"text": "أهلاً أحمد", "isMe": true},
    ],
    "محمد": [
      {"text": "عندي سؤال", "isMe": false},
      {"text": "تفضل", "isMe": true},
    ],
    "علي": [
      {"text": "هل في واجب؟", "isMe": false},
      {"text": "نعم موجود", "isMe": true},
    ],
    "سارة": [
      {"text": "شكراً أستاذ", "isMe": false},
    ],
    "ليان": [
      {"text": "متى الامتحان؟", "isMe": false},
      {"text": "الأسبوع القادم", "isMe": true},
    ],
  };

  // 👇 الطالب الحالي
  String selectedChat = "أحمد";

  void send() {
    if (controller.text.isEmpty) return;

    setState(() {
      chats[selectedChat]!.add({
        "text": controller.text,
        "isMe": true,
      });
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = chats[selectedChat]!;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text(selectedChat),
      ),

      body: Column(
        children: [

          // 👥 قائمة الطلاب (أعلى الشاشة)
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: chats.keys.map((name) {
                final isSelected = name == selectedChat;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedChat = name;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // 💬 الرسائل
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final m = messages[i];

                return Align(
                  alignment: m["isMe"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: m["isMe"]
                          ? AppColors.primary
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      m["text"],
                      style: TextStyle(
                        color: m["isMe"] ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ✏️ إدخال رسالة
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "اكتب رسالة...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: send,
                  icon: const Icon(Icons.send),
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}