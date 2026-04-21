import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final String name;
  const MessagesScreen({super.key, required this.name});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final controller = TextEditingController();

  // 🎯 البيانات مع إضافة عداد الرسائل غير المقروءة (unreadCount)
  Map<String, Map<String, dynamic>> chats = {
    "Ahmad": {
      "unreadCount": 2,
      "messages": [
        {"text": "Hello Teacher", "isMe": false},
        {"text": "Hello Ahmad", "isMe": true},
      ]
    },
    "Mohammad": {
      "unreadCount": 1,
      "messages": [
        {"text": "I have a question", "isMe": false},
      ]
    },
    "Ali": {
      "unreadCount": 0,
      "messages": [
        {"text": "Is there a quiz?", "isMe": false},
      ]
    },
    "Sarah": {
      "unreadCount": 1,
      "messages": [
        {"text": "Thank you!", "isMe": false},
      ]
    },
    "Layan": {
      "unreadCount": 2,
      "messages": [
        {"text": "Dear Ms", "isMe": false},
                {"text": "When is the exam?", "isMe": false},

      ]
    },
  };

  late String selectedChat;

  @override
  void initState() {
    super.initState();
    selectedChat = widget.name.isNotEmpty ? widget.name : "Ahmad";
  }

  void send() {
    if (controller.text.trim().isEmpty) return;
    setState(() {
      chats[selectedChat]!["messages"].add({
        "text": controller.text,
        "isMe": true,
      });
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: Row(
        children: [
          // 👥 القائمة الجانبية للأسماء (Side Bar)
          Container(
            width: 100, // عرض القائمة الجانبية
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Colors.black12)),
            ),
            child: ListView(
              children: chats.keys.map((name) {
                final isSelected = name == selectedChat;
                final unread = chats[name]!["unreadCount"];

                return GestureDetector(
                  onTap: () => setState(() => selectedChat = name),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: isSelected ? const Color(0xFF0D47A1) : Colors.grey[300],
                              child: Text(name[0], style: TextStyle(color: isSelected ? Colors.white : Colors.black54)),
                            ),
                            // 🔴 دائرة عدد المسجات
                            if (unread > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                                  child: Text(
                                    '$unread',
                                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? const Color(0xFF0D47A1) : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // 💬 منطقة المحادثة (Chat Area)
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: chats[selectedChat]!["messages"].length,
                    itemBuilder: (_, i) {
                      final m = chats[selectedChat]!["messages"][i];
                      bool isMe = m["isMe"];
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? const Color(0xFF0D47A1) : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                          ),
                          child: Text(
                            m["text"],
                            style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // حقل الإرسال
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "Type...",
                            filled: true, 
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      IconButton(onPressed: send, icon: const Icon(Icons.send, color: Color(0xFF0D47A1))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}