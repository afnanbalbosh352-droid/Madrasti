import 'package:flutter/material.dart';
import 'package:madrasati/General/app_localizations.dart';
import 'package:madrasati/General/language_provider.dart';
import 'package:madrasati/Student/student_screen.dart';
import 'package:madrasati/Teacher/teacher_screen.dart';
import 'package:provider/provider.dart'; 
import '../Admin/admin_screen.dart';
import 'app_colors.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  final List<String> studentIds = ["111", "222", "333"];
  final List<String> teacherIds = ["444", "555", "666"];
  final List<String> adminIds = ["777", "888", "999"];

  void login(BuildContext context) {
    String id = nationalIdController.text.trim();
    String pass = passwordController.text.trim();

    if (id != pass) {
    showError(context, "National ID number does not match password");
      return;
    }

    if (studentIds.contains(id)) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => StudentScreen(name: id)));
    } else if (teacherIds.contains(id)) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TeacherScreen(name: id)));
    } else if (adminIds.contains(id)) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AdminScreen(name: id)));
    }
  }

  void showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔵 Header المطور مع زر اللغة
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, bottom: 50),
                decoration: const BoxDecoration(
                  gradient: AppColors.gradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // زر تبديل اللغة في أعلى اليمين
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextButton.icon(
                          onPressed: () {var provider = Provider.of<LanguageProvider>(context, listen: false);
               if (Localizations.localeOf(context).languageCode == 'ar') {
               provider.changeLanguage(const Locale('en'));
               } else {
                provider.changeLanguage(const Locale('ar'));
                }

                            print("The language change button was pressed");
                          },
                          icon: const Icon(Icons.language, color: Colors.white, size: 20),
                          label: Text(
                            Localizations.localeOf(context).languageCode == 'ar' ? "English" : "عربي",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.school, size: 70, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text(
                      "Madrasati",
                      style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ⚪ Login Card
              Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // العنوان مترجم
                        Text(
                          AppLocalizations.of(context)!.translate('Log in'),
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                        const SizedBox(height: 20),

                        // حقل الرقم الوطني مترجم
                        TextField(
                          controller: nationalIdController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.translate('national_id'),
                            prefixIcon: const Icon(Icons.badge),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // حقل كلمة المرور مترجم
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.translate('password'),
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // زر الدخول مترجم
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => login(context),
                          child: Text(AppLocalizations.of(context)!.translate('Sign in')),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
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