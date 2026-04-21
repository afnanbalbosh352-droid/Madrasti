import 'package:flutter/material.dart';
import '../General/app_colors.dart'; 
import 'user_type_screen.dart'; 

class SchoolSelectionScreen extends StatelessWidget {
  SchoolSelectionScreen({super.key});

  // التحكم في النص المدخل لاسم المدرسة
  final TextEditingController _schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // شعار المدرسة أو أيقونة تعبيرية
              Icon(
                Icons.school_outlined,
                size: 100,
                color: AppColors.primary,
              ),
              const SizedBox(height: 20),
              Text(
                "Madrasati",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your school ID to continue",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 50),

              // حقل إدخال اسم المدرسة
              TextField(
                controller: _schoolController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "School ID",
                  hintText: "e.g. 12345",
                  prefixIcon: Icon(Icons.pin_outlined, color: AppColors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // زر الانتقال لشاشة نوع المستخدم
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    // التأكد من أن المستخدم أدخل نصاً قبل الانتقال
                    if (_schoolController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserTypeScreen(),
                        ),
                      );
                    } else {
                      // تنبيه بسيط في حال كان الحقل فارغاً
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter school name")),
                      );
                    }
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}