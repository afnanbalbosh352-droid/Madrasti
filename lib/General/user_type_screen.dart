import 'package:flutter/material.dart';
import '../General/app_colors.dart'; //
import 'login_screen.dart'; // هذا السطر ضروري جداً لربط الشاشتين

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select User Type"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Who are you?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // خيارات أنواع المستخدمين
            _buildUserCard(context, "Admin", Icons.admin_panel_settings, Colors.blue),
            const SizedBox(height: 15),
            _buildUserCard(context, "Teacher", Icons.school, Colors.green),
            const SizedBox(height: 15),
            _buildUserCard(context, "Student", Icons.person, Colors.orange),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لبناء بطاقات الاختيار بشكل أنيق
  Widget _buildUserCard(BuildContext context, String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        // الانتقال لشاشة تسجيل الدخول عند الضغط
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  LoginScreen()),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1), //
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.1), //
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}