import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // تعريف وحدات التحكم للنصوص
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  // المتغيرات المختارة افتراضياً
  String selectedClass = "All Classes";
  String selectedType = "Exam Schedule";

  // القوائم الخاصة بالخيارات
  final List<String> classes = ["All Classes", "Grade 10-A", "Grade 10-B", "Grade 9-A"];
  final List<String> notificationTypes = ["Exam Schedule", "School Event", "Urgent Note", "Marks Upload"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Send New Notification",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            
            // تصميم النموذج داخل Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // اختيار الصف المستهدف
                    DropdownButtonFormField<String>(
                      initialValue: selectedClass,
                      decoration: const InputDecoration(
                        labelText: "Target Class",
                        prefixIcon: Icon(Icons.people_outline),
                      ),
                      items: classes.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (val) => setState(() => selectedClass = val!),
                    ),
                    const SizedBox(height: 15),

                    // اختيار نوع الإشعار
                    DropdownButtonFormField<String>(
                      initialValue: selectedType,
                      decoration: const InputDecoration(
                        labelText: "Notification Category",
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      items: notificationTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                      onChanged: (val) => setState(() => selectedType = val!),
                    ),
                    const SizedBox(height: 15),

                    // حقل العنوان
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        hintText: "e.g., Final Exam Dates",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // حقل محتوى الرسالة
                    TextField(
                      controller: _messageController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Message Content",
                        hintText: "Enter the details you want to share...",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // زر الإرسال النهائي
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _submitNotification,
                        icon: const Icon(Icons.send_rounded, color: Colors.white),
                        label: const Text(
                          "Send to Students", 
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة الإرسال
  void _submitNotification() {
    if (_titleController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both title and message")),
      );
      return;
    }

    // محاكاة نجاح الإرسال (سيتم ربطها بـ Firebase لاحقاً)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Notification has been broadcasted successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    // تفريغ الحقول بعد الإرسال
    _titleController.clear();
    _messageController.clear();
  }
}